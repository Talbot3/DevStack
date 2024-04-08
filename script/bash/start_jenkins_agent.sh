if ! docker image inspect jenkins/inbound-agent:alpine3.19-jdk21 >/dev/null 2>&1; then
    docker pull jenkins/inbound-agent:alpine3.19-jdk21
fi

# if ! docker ps -a | grep jenkins/inbound-agent >/dev/null 2>&1; then
#     docker run --init jenkins/inbound-agent -url http://localhost:8080 <(cat /var/jenkins_home/secrets/initialAdminPassword)> jenkins-agent
# fi