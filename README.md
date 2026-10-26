# php-alpine-dockerfile
Dockerfiles for PHP runtime images

English | [简体中文](README_zh-CN.md)

## Build helper

The helper builds images locally only and does not push them to a registry.

Run without arguments to select the PHP version, whether to include Swoole, and the target platform interactively:

```sh
./build-php-image.sh
```

Build directly with the defaults, which are PHP 8.2 on the detected host platform:

```sh
./build-php-image.sh 8.2
```

Build for a specific Linux platform:

```sh
./build-php-image.sh --platform amd64 8.2
./build-php-image.sh --platform arm64 8.2
```

Swoole is optional. The standard image does not include it:

```sh
./build-php-image.sh --swoole 8.2
```

The resulting local tags follow this pattern:

```text
php<version>:local-amd64
php<version>:local-arm64
php<version>:local-amd64-swoole
php<version>:local-arm64-swoole
```

On Apple Silicon Macs the detected host platform is `linux/arm64`; on Intel Macs it is `linux/amd64`.

Run `./build-php-image.sh --help` for all options.

## php8.3
Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3`

Base image: `php:8.3.15-fpm-alpine3.21`

Optional Swoole version: `5.1.2`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug event simplexml`

## php8.2
Base image: `php:8.2.35-fpm-alpine3.23`

Optional Swoole version: `5.1.2`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php8.1
Base image: `php:8.1.32-fpm-alpine3.21`

Optional Swoole version: `5.1.2`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php8.0
Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php80`

Base image: `php:8.0.26-fpm-alpine3.16`

Optional Swoole version: `5.1.1`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php7.4
Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4`

Build base: `alpine:3.16`

Optional Swoole version: `4.8.12`

PHP source: `php-src` branch `PHP-7.4-CVE-2026-109618-109619`, pinned to commit `712e60f9edfd03f0960fc4fc3c2c375f42b90aa2`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mbstring mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

The build also includes `curl`, `iconv`, `openssl`, `sodium`, `sqlite3`, and `pdo_sqlite`.

## php7.3
Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3`

Base image: `php:7.3.33-fpm-alpine3.14`

Optional Swoole version: `4.8.12`

Included packages:
`nginx supervisor composer`

Included PHP extensions (standard image):
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`
