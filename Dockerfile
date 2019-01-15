FROM phpmyadmin/phpmyadmin:latest

# Env vars (theme downloaded in run.sh)
ENV CUSTOM_THEME=fallen
ENV CUSTOM_THEME_VERSION=0.7

# Get fully-configured file
COPY config.inc.php /etc/phpmyadmin/config.user.inc.php
RUN chmod 775 /etc/phpmyadmin/config.user.inc.php

# Copy main script
COPY run.sh /run.sh
RUN chmod +x /run.sh
