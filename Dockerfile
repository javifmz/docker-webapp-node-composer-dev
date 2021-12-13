FROM alpine:3.11
RUN apk update && apk upgrade && \
    echo @3.11 http://nl.alpinelinux.org/alpine/v3.11/community >> /etc/apk/repositories && \
    echo @3.11 http://nl.alpinelinux.org/alpine/v3.11/main >> /etc/apk/repositories && \
    apk --no-cache add nginx nano less curl composer nodejs yarn
COPY ./docker-entrypoint.sh /
COPY ./docker-nginx.conf /webapp/nginx.conf
RUN mv /docker-entrypoint.sh /entrypoint.sh && \
    adduser -D -g 'www' www && \
    mkdir /webapp/web && mkdir /webapp/api && mkdir /run/nginx/ && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /etc/nginx/conf.d && \
    rm /etc/nginx/conf.d/default.conf && \
    chmod +x /entrypoint.sh
ENV WEB_PORT 8080
ENV API_PORT 8081
ENV API_PATH api
ENV COMMAND_START_NODE "yarn install && yarn serve"
ENV COMMAND_START_NODE "composer update && composer start"
EXPOSE 80
STOPSIGNAL SIGTERM
ENTRYPOINT [ "/entrypoint.sh" ]