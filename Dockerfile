FROM openjdk:8-jre-alpine

LABEL maintainer="darethas@gmail.com"

# gerrit needs openssh-keygen to generate keys
RUN   apk update && \
      apk add --no-cache \
      openssh-keygen

# git is used to config stuff
RUN apk add git

RUN adduser -S gerrit

USER gerrit

ADD --chown=gerrit:nogroup https://gerrit-releases.storage.googleapis.com/gerrit-2.16.7.war /home/gerrit/gerrit.war

WORKDIR /home/gerrit

RUN java -jar gerrit.war init --batch --install-all-plugins
RUN java -jar gerrit.war reindex

RUN git config -f etc/gerrit.config --add container.javaOptions "-Djava.security.edg=file:/dev/./urandom"

EXPOSE 29418 8080

VOLUME ["/home/gerrit/git", "/home/gerrit/index", "/home/gerrit/cache", "/home/gerrit/db", "/home/gerrit/etc"]

CMD  git config -f etc/gerrit.config noteDb.changes.autoMigrate true && \
    bin/gerrit.sh run