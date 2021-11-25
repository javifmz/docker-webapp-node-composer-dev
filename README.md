# DNC Webapp

`📖 DNC = Docker-Node-Composer`

A minimal **Docker** image to run or develop web apps with **Node.js** for the front-end (_web_) and **Composer** for the back-end (_api_).

### Configuring the webapp

To work with this image, put your _web_ files in the `/webapp/web` directory and your _api_ files in the `/webapp/api` directory.

If the _web_ and _api_ ports of your webapp are different from the default ones (`8080` for _web_ and `8081` for _api_), they can be overriden using the `WEB_PORT` and `API_PORT` environment variables respectively.

### Accesing the webapp

The _web_ is accesible at the root path (`localhost`), and the _api_ at the `/api` path (`localhost/api`). This path can also be overriden using the `API_PATH` enviroment variable.

> If the desired path for the _api_ is `/rest`, set the `API_PATH` environment variable to `rest` without slashes (`API_PATH=rest`).

The exposed port is `80`.

### Example of usage with docker-compose

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

### Usage without docker-compse

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
  javifmz/webapp-dnc
```

## Image at Docker Hub

This image is available at Docker Hub as [javifmz/webapp-dnc](https://hub.docker.com/repository/docker/javifmz/webapp-dnc).
