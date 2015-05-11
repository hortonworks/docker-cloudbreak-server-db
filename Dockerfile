FROM postgres:9.4.1

ENV DBNAME cbdb
ENV VERSION 0.5.34
ENV BACKUP_TGZ /initdb/$DBNAME-$VERSION.tgz

ADD https://github.com/sequenceiq/docker-${DBNAME}/releases/download/v${VERSION}/cbdb-${VERSION}.tgz $BACKUP_TGZ
ADD /start /

ENTRYPOINT [ "/start" ]
CMD ["postgres"]
