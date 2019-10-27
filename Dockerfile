FROM phpmyadmin/phpmyadmin:4.9

# Env vars (theme downloaded in run.sh)
ENV CUSTOM_THEME=fallen
ENV CUSTOM_THEME_VERSION=0.7.1

# Add packages
RUN apt-get update && apt-get install zip gzip unzip -y
# RUN apk add --no-cache nginx supervisor zip gzip unzip

# Get fully-configured file
COPY config.inc.php /etc/phpmyadmin/config.user.inc.php
RUN chmod 775 /etc/phpmyadmin/config.user.inc.php

# Copy main script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["apache2-foreground"]
# CMD ["supervisord" "-n" "-j" "/supervisord.pid"]