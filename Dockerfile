FROM postgres:9.4.1

ENV CBDB_VERSION 0.5.32
ADD https://github.com/sequenceiq/docker-cbdb/releases/download/v${CBDB_VERSION}/cbdb-${CBDB_VERSION}.tgz /initdb/
ADD /start /

ENTRYPOINT [ "/start" ]
CMD ["postgres"]
