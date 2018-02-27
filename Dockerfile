FROM java:8-jre-alpine

RUN apk --update add curl
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x /usr/local/bin/digdag \
  && curl -o /usr/local/bin/embulk --create-dirs -L "https://dl.embulk.org/embulk-latest.jar" \
  && chmod +x /usr/local/bin/embulk
RUN apk del curl

ENV PATH /usr/local/bin:$PATH

COPY etl_apps/ /usr/local/etl_apps/

RUN mkdir /usr/local/output && mkdir /usr/local/system_info
VOLUME /usr/local/output /usr/local/system_info

RUN digdag --version

RUN embulk --version