FROM postgres:9.4.1
MAINTAINER Hortonworks

ENV REPONAME cloudbreak-server-db
ENV DBNAME cbdb
ENV VERSION 1.3.0
ENV BACKUP_TGZ /initdb/$DBNAME-$VERSION.tgz

ADD https://github.com/hortonworks/docker-${REPONAME}/releases/download/${VERSION}/${DBNAME}-${VERSION}.tgz $BACKUP_TGZ
ADD /start /

ENTRYPOINT [ "/start" ]
CMD ["postgres"]
