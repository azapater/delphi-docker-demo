# This script is executed as a post-build event to build and prepare a Docker image for the Delphi application.
# It handles cleanup of old Docker resources, sets up permissions, and builds a new Docker image.

# Define the image name and tag
$imageName = "delphi-docker-demo"
$imageTag = "latest"

# Clean up old containers, images, and volumes
wsl docker ps -a --filter "ancestor=$imageName`:$imageTag" -q | ForEach-Object { wsl docker stop $_; wsl docker rm $_ }
wsl docker images "$imageName`:$imageTag" -q | ForEach-Object { wsl docker rmi -f $_ }
wsl docker volume prune -f

# Get the directory where the script is located
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# Create logs directory if it doesn't exist
$logsPath = Join-Path $scriptPath "logs"
if (-not (Test-Path $logsPath)) {
    New-Item -ItemType Directory -Path $logsPath | Out-Null
}

# Verify Linux64 directory exists
$linux64Path = Join-Path $scriptPath "Linux64"
if (-not (Test-Path $linux64Path)) {
    exit 1
}

# Verify the executable exists
$executablePath = Join-Path $linux64Path "Docker\DockerDemo"
if (-not (Test-Path $executablePath)) {
    exit 1
}

# Set executable permissions using WSL
$wslExecutablePath = wsl wslpath -u ($executablePath -replace '\\', '/')
wsl chmod +x $wslExecutablePath

# Convert Windows path to WSL path
$wslPathInput = $scriptPath -replace '\\', '/'
$wslPath = wsl wslpath -u $wslPathInput

# Build command using WSL with --no-cache to force a clean build
$buildCommand = "docker build --no-cache -t $($imageName):$($imageTag) $($wslPath)"
Invoke-Expression -Command "wsl $buildCommand"

if ($LASTEXITCODE -eq 0) {
    # Optional: Run the container after a successful build
    # $runCommand = "docker run -d -p 8080:8080 -v $($logsPath -replace '\\', '/'):/app/logs --name=delphi-demo $imageName`:$imageTag"
    # Invoke-Expression -Command "wsl $runCommand"
} 