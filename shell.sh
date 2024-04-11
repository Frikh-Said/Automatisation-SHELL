#!/bin/bash

# GitHub repository URL
GITHUB_REPO="https://github.com/Frikh-Said/Automatisation-SHELL.git"
# Docker Hub username
DOCKERHUB_USER="suzuya8"
# Docker Hub repository
DOCKERHUB_REPO="todo-app"
# Docker image name
IMAGE_NAME="todo-app"
# File to store the version
VERSION_FILE="./version.txt"

# Read the current version from the file
if [ -f $VERSION_FILE ]; then
    VERSION=$(cat $VERSION_FILE)
else
    # If the file doesn't exist, start with version 1.0
    VERSION="1.0"
fi

# Clone the GitHub repository
git pull
cd ./app

# Build the Docker image
sudo docker build -t $IMAGE_NAME .

cd ..
# Log in to Docker Hub
sudo cat my_password.txt | docker login --username $DOCKERHUB_USER --password-stdin
#sudo docker login docker.io

# Tag the Docker image
sudo docker tag $IMAGE_NAME $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION

# Push the Docker image to Docker Hub
sudo docker push $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION

# Increment version for next build and write to file
NEXT_VERSION=$(echo "$VERSION + 0.1" | bc)
echo $NEXT_VERSION > $VERSION_FILE

docker run -p 3000:3000 $IMAGE_NAME

