# Delphi Docker Demo

A demonstration project showcasing how to containerize a Delphi WebBroker application using Docker. This project serves as a practical example of running Delphi applications in containers, with a focus on cross-platform compatibility and modern deployment practices.

## Features

- Simple WebBroker application with two endpoints:
  - Root endpoint (`/`): Serves a welcome page
  - Health endpoint (`/health`): Returns application health status in JSON format
- Logging system with configurable log levels
- Cross-platform support (Windows and Linux)
- Docker containerization with proper signal handling
- Automated Docker image building through post-build events
- Volume support for persistent logging

## Prerequisites

- Delphi 11 or later
- Windows 10/11 with WSL2 installed
- Docker Desktop with WSL2 integration or Docker cli installed in WSL2

## Project Structure

```
.
├── Linux64/                # Linux build output directory
│   └── Docker/             # Contains the Linux executable
├── WebModuleUnit1.pas      # Main web module with endpoints
├── LoggerU.pas             # Logging implementation
├── Dockerfile              # Docker configuration
└── build_docker_image.ps1  # PowerShell script for Docker build
```

## Building and Running

### Local Development

1. Open the project in Delphi IDE
2. Select the "Docker" build configuration
3. Build the project (F9 or Build > Build)
4. The post-build event will automatically:
   - Clean up old Docker resources
   - Build a new Docker image
   - Set up proper permissions

### Running the Container

```bash
docker run -d -p 8080:8080 -v $(pwd)/logs:/app/logs --name=delphi-demo delphi-docker-demo:latest
```

### Accessing the Application

- Main page: http://localhost:8080
- Health check: http://localhost:8080/health

## Docker Image

The Docker image is available on [DockerHub](https://hub.docker.com/r/thony/delphi-docker-demo):
```bash
docker pull thony/delphi-docker-demo:latest
```

## Logging

The application implements a basic logging system:
- Logs are written to the `logs` directory
- Logs can be persisted through Docker volumes

## Development Notes

- The project uses a post-build PowerShell script to automate Docker image creation
- Signal handling is implemented for graceful container shutdown
- The application detects whether it's running in a container or interactive mode
- Cross-platform compatibility is maintained through conditional compilation

## Contributing

Feel free to submit issues and enhancement requests!

