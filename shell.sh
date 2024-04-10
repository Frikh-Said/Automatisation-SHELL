#!/bin/bash

# GitHub repository URL
GITHUB_REPO="https://github.com/Frikh-Said/Automatisation-SHELL.git"
# Docker Hub username
DOCKERHUB_USER="suzuya8"
# Docker image name
IMAGE_NAME="todo-app"
# Docker Hub repository
DOCKERHUB_REPO="todo-app"

# Define initial version

VERSION="1.0"

# Clone the GitHub repository
git pull $GITHUB_REPO
cd ~/app

# Build the Docker image
docker build -t $IMAGE_NAME .

# Log in to Docker Hub
cat my_password.txt | docker login --username $DOCKERHUB_USER --password-stdin

# Tag the Docker image
docker tag $IMAGE_NAME $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION

# Push the Docker image to Docker Hub
docker push $DOCKERHUB_USER/$DOCKERHUB_REPO:$VERSION

VERSION=$((VERSION + 1))



