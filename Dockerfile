FROM alpine:3.15
COPY conf /webapp/conf
RUN apk update && apk upgrade && \
    apk --no-cache add supervisor nginx nano less curl composer nodejs yarn && \
    adduser -D -g 'www' www && \
    mkdir /webapp/web && mkdir /webapp/api && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /etc/nginx/http.d && \
    rm /etc/nginx/http.d/default.conf && \
    chmod +x /webapp/conf/entrypoint.sh
ENV WEB_PORT 8080
ENV API_PORT 8081
ENV API_PATH api
ENV COMMAND_START_NODE "yarn install && yarn serve"
ENV COMMAND_START_COMPOSER "composer update && composer start"
EXPOSE 80
STOPSIGNAL SIGTERM
ENTRYPOINT [ "/webapp/conf/entrypoint.sh" ]