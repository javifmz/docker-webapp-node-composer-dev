#!/bin/sh

echo 'Starting nginx...'
cat /webapp/nginx.conf \
 | sed "s|API_PORT|${API_PORT}|g" \
 | sed "s|WEB_PORT|${WEB_PORT}|g" \
 | sed "s|API_PATH|${API_PATH}|g" \
 > /etc/nginx/conf.d/nginx.conf
nginx -g 'daemon on;'

echo 'Starting node...'
cd /webapp/web && yarn serve &

echo 'Starting composer...'
cd /webapp/api && composer start &

echo 'Wait for any process to exit'
wait -n
  
echo 'Exit with status of process that exited first'
exit $?