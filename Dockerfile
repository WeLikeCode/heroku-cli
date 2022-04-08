FROM ubuntu:20.04

RUN set -ex && \
 apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y  apt-transport-https ca-certificates gnupg curl git nodejs sudo --no-install-recommends && \
    apt autoclean && \
    apt autoremove

RUN update-ca-certificates
RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN adduser herokuser

ENV HEROKUDATA /var/lib/heroku/data
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
RUN mkdir -p "$HEROKUDATA" && chown -R herokuser:herokuser "$HEROKUDATA" && chmod 777 "$HEROKUDATA"
VOLUME /var/lib/heroku/data

WORKDIR /var/lib/heroku/data

# Cleanup
ENV SUDO_FORCE_REMOVE=yes
RUN  apt purge -yq sudo && apt-get clean && \
  rm -rf /var/lib/apt

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN ["usermod", "-s", "/bin/bash", "herokuser"]

USER herokuser

ENTRYPOINT ["docker-entrypoint.sh"]

RUN heroku --version