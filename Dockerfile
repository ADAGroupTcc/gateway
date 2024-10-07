# Use the official Kong image (v3.8.0 as specified)
FROM kong:3.8.0

# Set environment variables for DB-less mode
ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml
ENV KONG_PROXY_ACCESS_LOG=/dev/stdout
ENV KONG_ADMIN_ACCESS_LOG=/dev/stdout
ENV KONG_PROXY_ERROR_LOG=/dev/stderr
ENV KONG_ADMIN_ERROR_LOG=/dev/stderr
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001, 0.0.0.0:8444 ssl"
ENV KONG_PREFIX=/var/run/kong

RUN mkdir /kong/declarative /tmp /var/run/kong

COPY ./declarative/kong.yml /kong/declarative/kong.yml

EXPOSE 8000 8443 8001 8444

# Run Kong in DB-less mode
CMD ["kong", "docker-start"]
