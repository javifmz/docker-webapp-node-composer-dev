# DNC Webapp

`📖 DNC = Docker-Node-Composer`

A minimal **Docker** image to develop web apps with **Node.js** for the front-end (_web_) and **Composer** for the back-end (_api_).

To work with this image, it is mandatory to mount the _web_ directory as a volume in `/webapp/web` and the _api_ directory as a volume in `/webapp/api`. 

_Web_ and _api_ development ports can be also overrided using the `WEB_PORT` and `API_PORT` respectively.

The exposed port is `80`. If this port is published (for example) to port `8080`, the _web_ would be accessible at the URL `localhost:8080` and the _api_ at the URL `localhost:8080/api/`.

Optionally, the `node_modules` and `vendor` folders can also be mounted as volumes. The `docker-compose.yml` shows an example of its usage.

## Usage with docker-compose

```yml
services:

  webapp:
    image: javifmz/webapp-dnc
    volumes:
      - ./api:/webapp/api
      - ./web:/webapp/web
      - /webapp/vendor
      - /webapp/node_modules
    ports:
      - 8080:80
    environment:
      - API_PATH=api
      - API_PORT=8081
      - WEB_PORT=8080
```

```bash
docker-compose up -d
docker-compose down
```


## Usage without docker-compse

```bash
docker run --rm -it \
  -v "$PWD/web:/webapp/web" \
  -v "$PWD/api:/webapp/api" \
  -v "/webapp/web/node_modules" \
  -v "/webapp/api/vendor" \
  -e "API_PATH=api" \
  -e "API_PORT=8081" \
  -e "WEB_PORT=8080" \
  -p "8080:80"
  webapp-dnc
```

## Image at Docker Hub

This image is available at Docker Hub as [javifmz/webapp-dnc](https://hub.docker.com/repository/docker/javifmz/webapp-dnc).
