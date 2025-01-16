# php-alpine-dockerfile
面向php运行环境的dockerfile

[English](README.md) | 简体中文

## php 8.3：

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3`

包含的包：
`php:8.3.15-fpm-alpine3.21 nginx supervisor `

包含的php扩展：
`swoole-5.1.1 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug event simplexml`

如果不需要 swoole 扩展，可以拉取 `registry.cn-hangzhou.aliyuncs.com/blackaay/php8.3:noSwoole` 镜像，这个镜像只移除了 swoole 扩展，使得镜像大小只有原来的一半（大约 215MB）

## php 8.0：

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php80`

包含的包：
`php:8.0.26-fpm-alpine3.16 nginx supervisor composer `

包含的php扩展：
`swoole-5.1.1 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug ssh2 pdo_pgsql pgsql`

如果不需要 swoole 扩展，可以拉取 `registry.cn-hangzhou.aliyuncs.com/blackaay/php80:noSwoole` 镜像，这个镜像只移除了 swoole 扩展，使得镜像大小只有原来的一半（大约 190MB）

## php 7.4：

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4`

包含的包：
`7.4.33-fpm-alpine3.16 nginx supervisor composer `

包含的php扩展：
`swoole-4.8.12 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

如果不需要 swoole 扩展，可以拉取 `registry.cn-hangzhou.aliyuncs.com/blackaay/php7.4:noSwoole` 镜像，这个镜像只移除了 swoole 扩展，使得镜像大小只有原来的一半（大约 187MB）


## php 7.3：

个人维护的镜像地址：`registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3`

包含的包：
`php:7.3.33-fpm-alpine3.14 nginx supervisor composer `

包含的php扩展：
`swoole-4.8.12 bcmath calendar exif ftp gd gettext mongodb mysqli pcntl pdo_mysql redis shmop sockets sysvmsg sysvsem sysvshm xhprof xlswriter opcache zip xdebug`

如果不需要 swoole 扩展，可以拉取 `registry.cn-hangzhou.aliyuncs.com/blackaay/php7.3:noSwoole` 镜像，这个镜像只移除了 swoole 扩展，使得镜像大小只有原来的一半（大约 180MB）
