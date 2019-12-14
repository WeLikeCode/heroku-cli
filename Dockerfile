FROM alpine:3.9

RUN set -ex && \
 apk add --no-cache --virtual .fetch-deps \
 curl

RUN set -ex && \
 apk add --no-cache --virtual .needed-deps \
 bash \
 git \
 nodejs

RUN curl https://cli-assets.heroku.com/install.sh | sh

RUN adduser -D herokuser

ENV HEROKUDATA /var/lib/heroku/data
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
RUN mkdir -p "$HEROKUDATA" && chown -R herokuser:herokuser "$HEROKUDATA" && chmod 777 "$HEROKUDATA"
VOLUME /var/lib/heroku/data

WORKDIR /var/lib/heroku/data

#RUN set -ex && \
#      apk del .fetch-deps

## Export the Python environment variables in .profile.d
#RUN echo 'export PATH=$HOME/.heroku/python/bin:$PATH PYTHONUNBUFFERED=true PYTHONHOME=/app/.heroku/python LIBRARY_PATH=/app/.heroku/vendor/lib:/app/.heroku/python/lib:$LIBRARY_PATH LD_LIBRARY_PATH=/app/.heroku/vendor/lib:/app/.heroku/python/lib:$LD_LIBRARY_PATH LANG=${LANG:-en_US.UTF-8} PYTHONHASHSEED=${PYTHONHASHSEED:-random} PYTHONPATH=${PYTHONPATH:-/app/user/}' > /app/.profile.d/python.sh
#RUN chmod +x /app/.profile.d/python.sh
#
#ONBUILD ADD requirements.txt /app/user/
#ONBUILD RUN /app/.heroku/python/bin/pip install -r requirements.txt
#ONBUILD ADD . /app/user/

COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN set -ex && \
 apk add --no-cache --virtual \
 shadow

RUN ["usermod", "-s", "/bin/bash", "herokuser"]

RUN set -ex && \
 apk del shadow

USER herokuser

ENTRYPOINT ["docker-entrypoint.sh"]

RUN heroku --version