#!/bin/sh

PROJECT=expressjs-couchdb-boilerplate

# COLOR Definition
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

if [[ $# -ne 3  ]] ; then
  echo 'Invalid call, The proper call format is:'
  echo './run.sh environment service argument'
  echo 'Available env: dev, prod'
  echo 'Available service: check docker-compose.yml.* for the services available'
  exit 1
fi
# echo "Environment is: [$1]"
# echo "Service is: [$2]"
# echo "Command is: [$3]"

online_env=`docker ps --format "{{.Names}}" | grep ${PROJECT} | cut -d '_' -f 2,3 | uniq`;
running_containers=` docker ps --format "{{.Names}}" | grep ${PROJECT} | cut -d '_' -f 2,3,4 | uniq`

if echo $online_env | grep -e "\b$1" >> /dev/null;
then
  if echo $running_containers  | grep -e "$1_$2" >> /dev/null; then
    echo '---------------------------------------'
    docker exec -it "${PROJECT}_$1_$2_1" sh -c "$3"
    status=$?
    exit $status
  else
    printf "${YELLOW}Container $2 in env $1 is not found running.${NC}\n"
    exit 1
  fi
else
  printf "${YELLOW}The Docker Environment $1 is not online.${NC}\n"
  exit 2
fi
