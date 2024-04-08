if ! docker image inspect jenkins/inbound-agent:alpine3.19-jdk21 >/dev/null 2>&1; then
    docker pull jenkins/inbound-agent:alpine3.19-jdk21
fi

if ! docker ps -a | grep jenkins/inbound-agent >/dev/null 2>&1; then
    echo "<secret> such as 46740012b74ff964fc7b5d14ec0711d4014301d533fd46ededafafc66bd1424f create from jenkins server"
    echo "after created agent, secret and agent name can be generated"
    docker run  --init jenkins/inbound-agent:alpine3.19-jdk21 -url http://192.168.3.10:8080   46740012b74ff964fc7b5d14ec0711d4014301d533fd46ededafafc66bd1424f jenkins-agent
fi