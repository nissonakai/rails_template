FROM ruby:2.6-alpine

ENV LANG C.UTF-8

RUN apk update && \
    apk upgrade && \
    apk --update --no-cache add shadow sudo busybox-suid mariadb-connector-c-dev tzdata alpine-sdk postgresql-client postgresql-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

ENV ENTRYKIT_VERSION 0.4.0

RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

RUN mkdir /app
WORKDIR /app

ENTRYPOINT [ "prehook", "bundle install -j4", "--"]
