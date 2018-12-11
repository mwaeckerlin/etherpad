FROM mwaeckerlin/nodejs
MAINTAINER mwaeckerlin

EXPOSE 9001

ENV TITLE            "Etherpad"
ENV DEFAULT_PAD_TEXT "Welcome to Etherpad!\n\nThis pad text is synchronized as you type, so that everyone viewing this page sees the same text. This allows you to collaborate seamlessly on documents!\n\nGet involved with Etherpad at http://etherpad.org\n"
ENV FAVICON          "favicon.ico"
ENV DB_TYPE          "sqlite"
ENV DB_SETTINGS      "{\"filename\": \"/db/etherpad.db\"}"
ENV AUTOMATIC_RECONNECTION_TIMEOUT "30"
ENV ADMIN            ""
ENV ADMIN_PWD        ""

ENV CONTAINERNAME    "etherpad"
USER root
ADD start.sh /start.sh
RUN apk add curl \
 && mkdir /db \
 && curl -sL https://github.com/$(curl -sL https://github.com/ether/etherpad-lite/releases/latest  \
                                  | sed -n 's,.*href="\([^"]*.tar.gz\)".*,\1,p') \
  | tar xz -C /app --strip-components=1 \
 && npm install --save comment-json sqlite3 \
 && bin/installDeps.sh \
 && apk del curl \
 && chown -R "${NODE_USER}" /db /app

USER "${NODE_USER}"
WORKDIR /app
VOLUME /db
