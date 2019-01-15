FROM phpmyadmin/phpmyadmin

RUN set -x \
    && apk add --no-cache ca-certificates wget \
    && update-ca-certificates

RUN wget -O fallen.zip https://files.phpmyadmin.net/themes/fallen/0.7/fallen-0.7.zip && \
		mkdir -p /thm && \
		unzip fallen.zip -d /thm && \
		rm -rf /www/themes/fallen* && \
		mv /thm/fallen /www/themes && \
		rm -rf /thm

# Get fully-configured file
COPY config.inc.php /etc/phpmyadmin/config.user.inc.php
RUN chmod 777 /etc/phpmyadmin/config.user.inc.php
