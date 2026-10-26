#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_VERSION="8.2"

usage() {
    cat <<'USAGE'
Usage:
  ./build-php-image.sh                     Select build options interactively
  ./build-php-image.sh [options] [version] Build directly with arguments

PHP version defaults to 8.2, for example 8.2, 8.0, 7.4.

Options:
  -i, --interactive         Use interactive selection
  -p, --platform PLATFORM   Target platform: amd64 or arm64
                            amd64  linux/amd64, for x86_64 Linux
                            arm64  linux/arm64, for ARM64 Linux
                            Defaults to the detected host platform
  -t, --tag IMAGE           Custom image tag
      --swoole              Install the Swoole extension
      --no-cache            Disable Docker build cache
  -h, --help                Show this help

Interactive example:
  ./build-php-image.sh

Direct build examples:
  ./build-php-image.sh --platform amd64 8.2
  ./build-php-image.sh --platform arm64 8.2
  ./build-php-image.sh --swoole 8.2

Note:
  The built image is always loaded into Docker with --load.
USAGE
}

die() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

choose_option() {
    local title="$1"
    local default_index="$2"
    shift 2
    local options=("$@")
    local index
    local choice

    printf '\n%s\n' "$title"
    for ((index = 0; index < ${#options[@]}; index++)); do
        if ((index + 1 == default_index)); then
            printf '  %d) %s (default)\n' "$((index + 1))" "${options[$index]}"
        else
            printf '  %d) %s\n' "$((index + 1))" "${options[$index]}"
        fi
    done

    while true; do
        printf 'Select [1-%d]: ' "${#options[@]}"
        IFS= read -r choice || die "Failed to read selection; use command-line arguments for non-interactive builds"
        if [[ -z "$choice" ]]; then
            choice="$default_index"
        fi
        if [[ "$choice" =~ ^[0-9]+$ ]] && ((choice >= 1 && choice <= ${#options[@]})); then
            selected_index=$((choice - 1))
            return 0
        fi
        printf 'Invalid selection. Enter a number from 1 to %d.\n' "${#options[@]}"
    done
}

platform_request="host"
image_tag=""
no_cache=false
swoole=false
version_request="$DEFAULT_VERSION"
version_set=false
interactive=false

if [[ $# -eq 0 ]]; then
    interactive=true
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--interactive)
            interactive=true
            shift
            ;;
        -p|--platform)
            [[ $# -ge 2 ]] || die "$1 requires a platform value"
            platform_request="$2"
            shift 2
            ;;
        -t|--tag)
            [[ $# -ge 2 ]] || die "$1 requires an image tag"
            image_tag="$2"
            shift 2
            ;;
        --swoole)
            swoole=true
            shift
            ;;
        --no-cache)
            no_cache=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        -*)
            die "Unknown option: $1 (use --help for usage)"
            ;;
        *)
            if [[ "$version_set" == true ]]; then
                die "Only one PHP version can be specified"
            fi
            version_request="$1"
            version_set=true
            shift
            ;;
    esac
done

command -v docker >/dev/null 2>&1 || die "docker command not found"
docker info >/dev/null 2>&1 || die "Cannot connect to Docker; make sure Docker Desktop is running"

host_machine="$(uname -m)"
case "$host_machine" in
    arm64|aarch64)
        host_platform="linux/arm64"
        ;;
    x86_64|amd64)
        host_platform="linux/amd64"
        ;;
    *)
        die "Unsupported host architecture: $host_machine"
        ;;
esac

image_dirs=()
while IFS= read -r dockerfile_path; do
    image_dirs+=("$(basename "$(dirname "$dockerfile_path")")")
done < <(find "$SCRIPT_DIR" -mindepth 2 -maxdepth 2 -name dockerfile -print | sort)

[[ ${#image_dirs[@]} -gt 0 ]] || die "No image directories containing a dockerfile were found"

if [[ "$interactive" == true ]]; then
    default_version_index=1
    for ((index = 0; index < ${#image_dirs[@]}; index++)); do
        if [[ "${image_dirs[$index]}" == "php${DEFAULT_VERSION}" ]]; then
            default_version_index=$((index + 1))
            break
        fi
    done

    choose_option "Select PHP version:" "$default_version_index" "${image_dirs[@]}"
    version_request="${image_dirs[$selected_index]}"
    version_set=true

    platform_options=(
        "x86_64 Linux (linux/amd64)"
        "ARM64 Linux (linux/arm64)"
    )

    if [[ "$host_platform" == "linux/amd64" ]]; then
        default_platform_index=1
    else
        default_platform_index=2
    fi

    choose_option "Select target platform:" "$default_platform_index" "${platform_options[@]}"
    case "$selected_index" in
        0)
            platform_request="amd64"
            ;;
        1)
            platform_request="arm64"
            ;;
    esac

    variant_options=(
        "Standard (without Swoole)"
        "With Swoole"
    )
    if [[ "$swoole" == true ]]; then
        default_variant_index=2
    else
        default_variant_index=1
    fi
    choose_option "Select build variant:" "$default_variant_index" "${variant_options[@]}"
    if [[ "$selected_index" -eq 1 ]]; then
        swoole=true
    else
        swoole=false
    fi
fi

requested="${version_request#php}"
candidates=("php${requested}")
if [[ "$requested" == *.* ]]; then
    candidates+=("php${requested//./}")
fi

image_dir=""
for candidate in "${candidates[@]}"; do
    if [[ -f "$SCRIPT_DIR/$candidate/dockerfile" ]]; then
        image_dir="$candidate"
        break
    fi
done

[[ -n "$image_dir" ]] || die "No dockerfile found for PHP ${requested}; available directories: ${image_dirs[*]}"

case "$platform_request" in
    host)
        platform="$host_platform"
        ;;
    arm64|aarch64|linux/arm64)
        platform="linux/arm64"
        ;;
    amd64|x86_64|linux/amd64)
        platform="linux/amd64"
        ;;
    *)
        die "Unsupported platform: ${platform_request} (choose amd64 or arm64)"
        ;;
esac

dockerfile="$SCRIPT_DIR/$image_dir/dockerfile"
context_dir="$SCRIPT_DIR/$image_dir"

if [[ -z "$image_tag" ]]; then
    platform_tag="${platform#linux/}"
    tag_suffix=""
    if [[ "$swoole" == true ]]; then
        tag_suffix="-swoole"
    fi
    image_tag="$image_dir:local-$platform_tag$tag_suffix"
fi

printf '\nBuild configuration:\n'
printf '  PHP version:     %s\n' "$requested"
printf '  Build context:   %s\n' "$context_dir"
printf '  Target platform: %s\n' "$platform"
printf '  Swoole:          %s\n' "$([[ "$swoole" == true ]] && echo yes || echo no)"
printf '  Image tag:       %s\n' "$image_tag"

if [[ "$interactive" == true ]]; then
    printf '\nStart build? [Y/n]: '
    IFS= read -r confirm || confirm=""
    case "${confirm:-Y}" in
        y|Y|yes|YES)
            ;;
        *)
            printf 'Build cancelled.\n'
            exit 0
            ;;
    esac
fi

build_args=(
    buildx build
    --platform "$platform"
    --file "$dockerfile"
    --tag "$image_tag"
)

if [[ "$swoole" == true ]]; then
    build_args+=(--build-arg INSTALL_SWOOLE=true)
fi

if [[ "$no_cache" == true ]]; then
    build_args+=(--no-cache)
fi

build_args+=(--load)

build_args+=("$context_dir")

printf '\nRunning command:\n  docker'
for arg in "${build_args[@]}"; do
    if [[ "$arg" == *[[:space:]]* ]]; then
        printf ' %q' "$arg"
    else
        printf ' %s' "$arg"
    fi
done
printf '\n\n'

docker "${build_args[@]}"

printf '\nBuild complete: %s\n' "$image_tag"
printf 'Run locally:\n  docker run --rm --platform %s %s php -v\n' "$platform" "$image_tag"
