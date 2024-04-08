#!/bin/bash

# Check if Jenkins is already running
if [ "$(docker ps -a | grep jenkins)" ]; then
  echo "Jenkins is already running, exiting..."
  exit 0
fi
jenkins_image="jenkins/jenkins:jdk21"

# Check if the Jenkins image has been pulled
if [ ! "$(docker images | grep jenkins/jenkins" ]; then
  echo "Pulling Jenkins image..."
  docker pull $jenkins_image
fi

# Create a new container for Jenkins
docker run -d --name jenkins -p 8080:8080 -p 50000:50000 $jenkins_image

# Wait for Jenkins to start
echo "Waiting for Jenkins to start..."
until [ "$(docker ps -a | grep jenkins)" ]; do
  sleep 1
done

# Check if Jenkins is running
if [ ! "$(docker ps -a | grep jenkins)" ]; then
  echo "Jenkins failed to start, exiting..."
  exit 1
fi

# Jenkins is running, print the URL
echo "Jenkins is running at http://localhost:8080"
