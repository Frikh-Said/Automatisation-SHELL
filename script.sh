#!/bin/bash

# Log file
LOG_FILE="/home/ubuntu/Automatisation-SHELL/deployment.log"

# Function to log messages
log_message() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" >> $LOG_FILE
}

# Log start of deployment
log_message "Starting deployment process..."

# GitHub repository URL
GITHUB_REPO="https://github.com/Frikh-Said/Automatisation-SHELL.git"
# Docker Hub username
DOCKERHUB_USER="suzuya8"
# Docker Hub repository
DOCKERHUB_REPO="todo-app"
# Docker image name
IMAGE_NAME="todo-app"
# File to store the version
ERSION_FILE="home/ubuntu/Automatisation-SHELL/version.txt"

# Read the current version from the file
if [ -f $VERSION_FILE ]; then
    VERSION=$(cat $VERSION_FILE)
else
    # If the file doesn't exist, start with version 1.0
    VERSION="1.0"
fi

# Pull the GitHub repository
log_message "Pulling GitHub repository..."
git pull >> $LOG_FILE
cd ./app

# Build the Docker image
log_message "Building Docker image..."
sudo docker build -t $IMAGE_NAME . >> $LOG_FILE
cd ..

# Log in to Docker Hub
log_message "Logging in to Docker Hub..."
sudo cat my_password.txt | docker login --username $DOCKERHUB_USER --password-stdin >> $LOG_FILE

# Tag the Docker image
log_message "Tagging Docker image..."
sudo docker tag $IMAGE_NAME $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION >> $LOG_FILE

# Push the Docker image to Docker Hub
log_message "Pushing Docker image to Docker Hub..."
sudo docker push $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION >> $LOG_FILE

# Increment version for next build and write to file
NEXT_VERSION=$(echo "$VERSION + 0.1" | bc)
log_message "Incrementing version to $NEXT_VERSION..."
echo $NEXT_VERSION > $VERSION_FILE

# Run the Docker container
log_message "Running Docker container..."
sudo docker run -p 3000:3000 $IMAGE_NAME >> $LOG_FILE

# Log end of deployment
log_message "Deployment process complete."

