# Use the official Kong image (v3.8.0)
FROM kong:3.8.0

# Switch to root to create directories with elevated permissions
USER root

# Create the necessary directories with proper permissions
RUN mkdir -p /kong/declarative /var/run/kong \
  && chown -R kong:kong /kong /var/run/kong

# Switch back to the kong user for the rest of the operations
USER kong

# Set environment variables for DB-less mode
ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml
ENV KONG_PROXY_ACCESS_LOG=/dev/stdout
ENV KONG_ADMIN_ACCESS_LOG=/dev/stdout
ENV KONG_PROXY_ERROR_LOG=/dev/stderr
ENV KONG_ADMIN_ERROR_LOG=/dev/stderr
ENV KONG_ADMIN_LISTEN="0.0.0.0:8001, 0.0.0.0:8444 ssl"
ENV KONG_PREFIX=/var/run/kong

# Copy the declarative configuration file
COPY ./declarative/kong.yml /kong/declarative/kong.yml

# Expose the necessary ports
EXPOSE 8000 8443 8001 8444

# Start Kong in DB-less mode
CMD ["kong", "docker-start"]
