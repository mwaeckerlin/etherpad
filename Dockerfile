FROM mwaeckerlin/base
MAINTAINER mwaeckerlin

EXPOSE 9001

ENV TITLE            "Etherpad"
ENV DEFAULT_PAD_TEXT "Welcome to Etherpad!\n\nThis pad text is synchronized as you type, so that everyone viewing this page sees the same text. This allows you to collaborate seamlessly on documents!\n\nGet involved with Etherpad at http:\/\/etherpad.org\n"

ENV CONTAINERNAME    "etherpad"
ENV NODE_ENV         "production"
RUN apk add curl nodejs npm \
 && mkdir /etherpad-lite /db \
 && curl -sL https://github.com/$(curl -sL https://github.com/ether/etherpad-lite/releases/latest  | sed -n 's,.*href="\([^"]*.tar.gz\)".*,\1,p') \
  | tar xz -C /etherpad-lite --strip-components=1 \
 && cd /etherpad-lite \
 && npm install --save comment-json \
 && bin/installDeps.sh \
 && adduser -S ether \
 && chown -R ether /db /etherpad-lite

USER ether
WORKDIR /etherpad-lite
VOLUME /db
