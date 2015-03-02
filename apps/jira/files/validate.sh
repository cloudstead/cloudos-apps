#!/bin/bash

CHEF_DIR="${1}"
if [ -z "${CHEF_DIR}" ] ; then
  echo "No CHEF_DIR argument provided"
  exit 1
fi

PORT=$(cat ${CHEF_DIR}/data_bags/jira/ports.json | cos json -o read -p primary)
if [ -z "${PORT}" ] ; then
  echo "Error determining port"
  exit 1
fi

NUM_PROCS=$(ps auxwwww | grep jira | grep org.apache.catalina.startup.Bootstrap | grep -v grep  | wc -l)
FOUND_PORT=$(netstat -nlp | grep jsvc | awk '{print $4}' | awk -F ':' '{print $2}' | grep ${PORT} | wc -l)

TIMEOUT=$(expr 60 \* 30)

LOG=/tmp/j.log
cat /dev/null > ${LOG}

if [[ ${NUM_PROCS} -eq 0 && ${FOUND_PORT} -eq 0 ]] ; then
  echo "Jira not running or on wrong port, restarting it now...." | tee -a ${LOG}
  service jira restart
  echo "service jira restart completed" | tee -a ${LOG}
fi

start=$(date +%s)
while [ $(expr $(date +%s) - ${start}) -lt ${TIMEOUT} ] ; do
  echo "trying curl..." | tee -a ${LOG}
  curl --max-time 10 http://127.0.0.1:${PORT}/ > /dev/null 2>&1
  if [ $? -eq 0 ] ; then
    echo "Jira is running" | tee -a ${LOG}
    exit 0
  else
    echo "Still waiting for jira to start..." | tee -a ${LOG}
    sleep 5s
  fi
done

echo "Jira failed to start" | tee -a ${LOG}
exit 1
