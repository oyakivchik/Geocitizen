FROM maven:3.6.2-jdk-11-slim AS builder
WORKDIR /build
COPY ./ ./
RUN ["mvn", "install"]

FROM nginx/unit:1.29.1-jsc11
WORKDIR /app
COPY --from=builder /build/target/citizen.war ./
COPY --from=builder /build/nginx-unit.json /docker-entrypoint.d/

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

EXPOSE 8080
