FROM node:8.0.0-slim AS builder
WORKDIR /build
COPY ./ ./
RUN ["npm", "install"]
RUN ["npm", "run", "build"]

FROM nginx/unit:1.29.1-minimal
LABEL MAINTAINER="Oleksii Yakivchik"
LABEL VERSION="1.0.0"
WORKDIR /www/static/
COPY --from=builder /build/dist ./
COPY --from=builder /build/nginx-unit.json /docker-entrypoint.d/
EXPOSE 80
