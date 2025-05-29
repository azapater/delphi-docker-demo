FROM gcr.io/distroless/cc

# Set a working directory
WORKDIR /app

# Copy the compiled Delphi application
# Assuming the executable is named DockerDemo and is located in Linux64/Docker relative to the Dockerfile
COPY Linux64/Docker/DockerDemo /app/DockerDemo

# Expose the port the application runs on
EXPOSE 8080

# Set the stop signal
STOPSIGNAL SIGTERM

# Create a volume for logs
VOLUME ["/app/logs"]

# Set environment variables
ENV APP_LOG_PATH=/app/logs/app.log
ENV DOCKER_CONTAINER=1

# Command to run the application
CMD ["/app/DockerDemo"] 