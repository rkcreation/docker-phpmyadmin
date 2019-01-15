FROM phpmyadmin/phpmyadmin

RUN set -x \
    && apk add --no-cache ca-certificates wget \
    && update-ca-certificates

RUN wget -O fallen.zip https://files.phpmyadmin.net/themes/fallen/0.7/fallen-0.7.zip && \
		rm -rf /www/themes/fallen* && \
		unzip -d/www/themes fallen.zip

# Get fully-configured file
COPY config.inc.php /etc/phpmyadmin/config.user.inc.php
RUN chmod 775 /etc/phpmyadmin/config.user.inc.php
