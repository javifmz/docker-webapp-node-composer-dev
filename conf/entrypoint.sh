#!/bin/sh

echo 'Configuring nginx...'
echo "- API_PATH: ${API_PATH}"
echo "- API_PORT: ${API_PORT}"
echo "- WEB_PORT: ${WEB_PORT}"
cat /webapp/conf/nginx.conf \
 | sed "s|API_PATH|${API_PATH}|g" \
 | sed "s|API_PORT|${API_PORT}|g" \
 | sed "s|WEB_PORT|${WEB_PORT}|g" \
 > /etc/nginx/http.d/nginx.conf

echo 'Starting nginx...'
nginx -g 'daemon on;'

echo 'Configuring supervisor...'
echo "- COMMAND_START_COMPOSER: ${COMMAND_START_COMPOSER}"
echo "- COMMAND_START_NODE: ${COMMAND_START_NODE}"
COMMAND_START_COMPOSER=${COMMAND_START_COMPOSER//"&"/"\\&"}
COMMAND_START_NODE=${COMMAND_START_NODE//"&"/"\\&"}
cat /webapp/conf/supervisord.conf \
 | sed "s|COMMAND_START_COMPOSER|${COMMAND_START_COMPOSER}|g" \
 | sed "s|COMMAND_START_NODE|${COMMAND_START_NODE}|g" \
 > /etc/supervisord.conf

echo 'Starting supervisor...'
supervisord -c /etc/supervisord.conf