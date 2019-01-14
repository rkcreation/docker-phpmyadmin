FROM phpmyadmin/phpmyadmin

RUN set -x \
    && apk add --no-cache ca-certificates wget \
    && update-ca-certificates

RUN wget -O metro.zip https://files.phpmyadmin.net/themes/metro/2.8/metro-2.8.zip && \
		unzip metro.zip -d /tmp && \
		rm -rf /www/themes/metro* && \
		mv /tmp/metro /www/themes

RUN wget -O fallen.zip https://files.phpmyadmin.net/themes/fallen/0.7/fallen-0.7.zip && \
		unzip fallen.zip -d /tmp && \
		rm -rf /www/themes/fallen* && \
		mv /tmp/fallen /www/themes

# Get fully-configured file
COPY config.inc.php /etc/phpmyadmin/config.user.inc.php
RUN chmod 777 /etc/phpmyadmin/config.user.inc.php