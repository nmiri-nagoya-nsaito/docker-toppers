#!/usr/bin/env bash

set -eu

SERVICE=cli
SCRIPT_DIR=$(cd $(dirname $0);pwd)

if [ $# -ge 1 ]; then
  SERVICE=$1
fi

echo "specified service: ${SERVICE}"

if [ ! -d ${SCRIPT_DIR}/services/${SERVICE} ]; then
  echo start_shell.sh: service \"${SERVICE}\" is not available.
  echo "  available services:"
  echo "    $(for i in $(ls services); do printf "\t%s\n" $i; done)"
  exit 1
fi

if [ "x$(docker-compose ps -q ${SERVICE})" = "x" ]; then
  docker-compose build ${SERVICE}
fi
docker-compose up -d ${SERVICE}
docker exec -i -t `docker-compose ps -q ${SERVICE}` bash --login

exit 0
