# php-alpine-dockerfile
面向 PHP 运行环境的 Dockerfile

[English](README.md) | 简体中文

## 构建脚本

构建脚本只会生成并加载本地镜像，不会推送到镜像仓库。

直接运行，通过菜单选择 PHP 版本、目标平台和构建变体：

```sh
./build-php-image.sh
```

使用默认参数直接构建。默认 PHP 版本为 8.2，目标平台为本机自动识别的平台：

```sh
./build-php-image.sh 8.2
```

构建指定 Linux 平台：

```sh
./build-php-image.sh --platform amd64 8.2
./build-php-image.sh --platform arm64 8.2
```

Swoole 是可选扩展，标准镜像默认不包含：

```sh
./build-php-image.sh --swoole 8.2
```

生成的本地镜像标签格式如下：

```text
php<版本>:local-amd64
php<版本>:local-arm64
php<版本>:local-amd64-swoole
php<版本>:local-arm64-swoole
```

在 Apple Silicon Mac 上，本机平台会自动识别为 `linux/arm64`；在 Intel Mac 上为 `linux/amd64`。

执行 `./build-php-image.sh --help` 查看全部选项。

## php 8.3

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3`

基础镜像：`php:8.3.15-fpm-alpine3.21`

可选 Swoole 版本：`5.1.2`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug event simplexml`

## php 8.2

基础镜像：`php:8.2.35-fpm-alpine3.23`

可选 Swoole 版本：`5.1.2`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php 8.1

基础镜像：`php:8.1.32-fpm-alpine3.21`

可选 Swoole 版本：`5.1.2`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php 8.0

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php80`

基础镜像：`php:8.0.26-fpm-alpine3.16`

可选 Swoole 版本：`5.1.1`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 event pdo_pgsql pgsql`

## php 7.4

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4`

构建基础镜像：`alpine:3.16`

可选 Swoole 版本：`4.8.12`

PHP 源码：`php-src` 分支 `PHP-7.4-CVE-2026-109618-109619`，固定提交 `712e60f9edfd03f0960fc4fc3c2c375f42b90aa2`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mbstring mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

构建时还会启用 `curl`、`iconv`、`openssl`、`sodium`、`sqlite3` 和 `pdo_sqlite`。

## php 7.3

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3`

基础镜像：`php:7.3.33-fpm-alpine3.14`

可选 Swoole 版本：`4.8.12`

包含的包：
`nginx supervisor composer`

包含的 PHP 扩展（标准镜像）：
`bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`
