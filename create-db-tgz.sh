#!/bin/bash

: ${VERSION:=0.5.32}

start_db(){
  echo 'export PUBLIC_IP=1.1.1.1'>Profile
  echo "export DOCKER_TAG_CLOUDBREAK=$VERSION" >> Profile
  cbd init
  #cbd pull
  
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

    # for gracefull shutdown: run another containe with --volumes from
    # docker exec cbdb bash -c 'kill -INT $(head -1 /var/lib/postgresql/data/postmaster.pid)'
    
    mkdir -p release
    docker exec  cbreak_cbdb_1 tar cz -C /var/lib/postgresql/data . > release/cbdb-${ver}.tgz
}

main() {
    start_db
    db_backup
}

[[ "$0" ==  "$BASH_SOURCE" ]] && main "$@"
