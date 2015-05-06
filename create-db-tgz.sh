#!/bin/bash


start_db(){
  cbd startdb
  cbd migrate cbdb up
  if cbd migrate cbdb status|grep "MyBatis Migrations SUCCESS" ; then
      echo Migration: OK
  else
      echo Migration: ERROR
      exit 1
  fi
}

db_backup() {
    local ver=$(cbd env export|grep DOCKER_TAG_CLOUDBREAK|sed "s/.*=//")

    mkdir -p release
    docker exec  cbreak_cbdb_1 tar cz -C /var/lib/postgresql/data . > release/cbdb-${ver}.tgz
}

main() {
    start_db
    db_backup
}

[[ "$0" ==  "$BASH_SOURCE" ]] && main "$@"
