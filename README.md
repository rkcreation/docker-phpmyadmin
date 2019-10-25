# Docker PHPMyAdmin #

![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/rkcreation/phpmyadmin?style=for-the-badge) ![Docker Pulls](https://img.shields.io/docker/pulls/rkcreation/phpmyadmin?style=for-the-badge) ![Docker Stars](https://img.shields.io/docker/stars/rkcreation/phpmyadmin?style=for-the-badge) ![GitHub stars](https://img.shields.io/github/stars/rkcreation/docker-phpmyadmin?label=GitHub%20Stars&style=for-the-badge) ![GitHub last commit](https://img.shields.io/github/last-commit/rkcreation/docker-phpmyadmin?style=for-the-badge)

## General config ##
- UPLOAD_PATH
- STACK_NAME - defaults to dev
- APPLICATION_ENV - defaults to null
- LOGIN_EXPIRATION - defaults to 24h (in seconds)

## Use custom theme ##
- CUSTOM_THEME - defaults to fallen
- CUSTOM_THEME_VERSION - defaults to 0.7

## Settings ##
- Exports : pre-configured exports with STACK_NAME-APPLICATION_ENV--DB--TIME.sql.gz

## Multi-server ##
Build a `config.servers.inc.php` file, with content :

```php
$i++;
$cfg['Servers'][$i]['verbose'] = 'Database Server 2';
$cfg['Servers'][$i]['host'] = '192.168.1.102';
$cfg['Servers'][$i]['port'] = '';
$cfg['Servers'][$i]['socket'] = '';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['extension'] = 'mysqli';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['AllowNoPassword'] = false;
```

### Example with docker-gen ###
See `phpmyadmin-servers.tmpl`.

Use `PHPMYADMIN_SERVER` on mysql containers.

In a `docker-compose.yml` file :
```yaml
version: '3'
volumes:
    pmaconf:
networks:
    phpmyadmin:
        external: true
services:
    phpmyadmin:
        image: rkcreation/phpmyadmin:3
        restart: always
    gen:
        image: jwilder/docker-gen
        environment:
            - PHPMYADMIN_SERVER=mysql_server2
        volumes:
            - /var/run/docker.sock:/tmp/docker.sock:ro
            - pmaconf:/etc/phpmyadmin
            - ./phpmyadmin-servers.tmpl:/etc/docker-gen/templates/phpmyadmin-servers.tmpl
        command: -notify-sighup phpmyadmin -watch /etc/docker-gen/templates/phpmyadmin-servers.tmpl /etc/phpmyadmin/config.servers.inc.php
        volumes:
            - ./nginx.tmpl:/etc/docker-gen/templates/nginx.tmpl
        networks:
            phpmyadmin:
            default:
```

In an other `docker-compose.yml` file :
```yaml
version: '3'
networks:
    phpmyadmin:
        external: true
services:
    mysql:
        image: mysql:5
        restart: always
        environment:
            - PHPMYADMIN_SERVER=mysql_server1
        networks:
            phpmyadmin:
            default:
    mysql2:
        image: mysql:5
        restart: always
        environment:
            - PHPMYADMIN_SERVER=mysql_server2
        networks:
            phpmyadmin:
            default:
```