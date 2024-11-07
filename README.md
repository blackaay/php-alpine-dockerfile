# php-alpine-dockerfile
dockerfile for php

English | [简体中文](README_zh-CN.md)

## php8.3
Maintained image location: 
`registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3`

Included packages:
`php:8.3.11RC2-fpm-alpine3.20 nginx supervisor`

Included PHP extensions:
`swoole-5.1.1 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug event`

If you don't need the Swoole extension, you can pull `registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3:noSwoole`. This image only removes the Swoole extension, reducing the image size to about half (approximately 215MB).

## php8.0
Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php80`

Included packages:
`php:8.0.26-fpm-alpine3.16 nginx supervisor composer `

Included PHP extensions:
`swoole-5.1.1 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 pdo_pgsql pgsql`

If you don't need the Swoole extension, you can pull `registry.cn-hangzhou.aliyuncs.com/blackaay/php80:noSwoole`. This image only removes the Swoole extension, reducing the image size to about half (approximately 190MB).

## php 7.4：

Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4`

Included packages:
`7.4.33-fpm-alpine3.16 nginx supervisor composer `

Included PHP extensions:
`swoole-4.8.12 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

If you don't need the Swoole extension, you can pull `registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4:noSwoole`. This image only removes the Swoole extension, reducing the image size to about half (approximately 187MB).


## php 7.3：

Maintained image location:
`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3`

Included packages:
`php:7.3.33-fpm-alpine3.14 nginx supervisor composer `

Included PHP extensions:
`swoole-4.8.12 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

If you don't need the Swoole extension, you can pull `registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3:noSwoole`. This image only removes the Swoole extension, reducing the image size to about half (approximately 180MB).
