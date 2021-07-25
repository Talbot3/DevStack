#!/bin/bash
# 
# Created by L.STONE <web.developer.network@gmail.com>
# Mod By Ryan.L <github-benzBrake@woai.ru>
# -------------------------------------------------------------
# 自动创建 Docker TLS 证书
# -------------------------------------------------------------

# 以下是配置信息
# Config start
PASSWORD="20192019Wc"
COUNTRY="CN"
STATE="Beijing"
CITY="ShangHai"
ORGANIZATION="org"
ORGANIZATIONAL_UNIT="dev"
COMMON_NAME="docker.internal"
EMAIL="1796560392@qq.com"
DOCKER_CERT="/Users/lilisi/.docker/certs.d"
DOCKER_CONFIG="/Users/lilisi/.docker/"
# Config end
# 工作目录
cd ~/.docker/certs.d
# 停止 docker
# service docker stop
# 生成 CA 密钥
if [[ ! -f ca-key.pem ]]; then
    echo " - 生成 CA 密钥"
    openssl genrsa -aes256 -passout "pass:$PASSWORD" -out "ca-key.pem" 4096
fi
# 生成 CA
if [[ ! -f ca.pem ]]; then
    echo " - 生成 CA"
    openssl req -new -x509 -days 365 -key "ca-key.pem" -sha256 -out "ca.pem" -passin "pass:$PASSWORD" -subj "/C=$COUNTRY/ST=$STATE/L=$CITY/O=$ORGANIZATION/OU=$ORGANIZATIONAL_UNIT/CN=$COMMON_NAME/emailAddress=$EMAIL"
fi
# 生成服务器密钥 & 服务器证书
if [[ ! -f server-key.pem ]]; then
    echo " - 生成服务器密钥"
    openssl genrsa -out "server-key.pem" 4096
fi
if [[ ! -f server.csr ]]; then
     openssl req -subj "/CN=$COMMON_NAME" -sha256 -new -key "server-key.pem" -out server.csr
fi
if [[ ! -f server-cert.pem ]]; then
    echo " - 生成服务器证书"
    echo "subjectAltName = IP:$IP,IP:127.0.0.1" >> extfile.cnf
    echo "extendedKeyUsage = serverAuth" >> extfile.cnf
    openssl x509 -req -days 365 -sha256 -in server.csr -passin "pass:$PASSWORD" -CA "ca.pem" -CAkey "ca-key.pem" -CAcreateserial -out "server-cert.pem" -extfile extfile.cnf
fi
rm -f extfile.cnf
# 生成客户端证书
if [[ ! -f key.pem ]]; then
    openssl genrsa -out "key.pem" 4096
fi
if [[ ! -f cert.pem ]]; then
    openssl req -subj '/CN=client' -new -key "key.pem" -out client.csr
    echo extendedKeyUsage = clientAuth >> extfile.cnf
    openssl x509 -req -days 365 -sha256 -in client.csr -passin "pass:$PASSWORD" -CA "ca.pem" -CAkey "ca-key.pem" -CAcreateserial -out "cert.pem" -extfile extfile.cnf
fi

chmod -v 0400 "ca-key.pem" "key.pem" "server-key.pem"
chmod -v 0444 "ca.pem" "server-cert.pem" "cert.pem"

# 打包客户端证书
echo " - 打包客户端证书为 tls-client-certs.tar.gz"
mkdir -p "tls-client-certs"
cp -f "ca.pem" "cert.pem" "key.pem" "tls-client-certs/"
cd "tls-client-certs"
tar zcf "tls-client-certs.tar.gz" *
mv "tls-client-certs.tar.gz" ../
cd ..
rm -rf "tls-client-certs"

# 拷贝服务端证书
# mkdir -p /etc/docker/certs.d
# cp -f "ca.pem" "server-cert.pem" "server-key.pem" /etc/docker/certs.d/
# echo " - 修改 /etc/docker/daemon.json 文件"
# if [[ -f /etc/docker/daemon.json ]]; then
#     grep "/etc/docker/certs.d/server-key.pem" /etc/docker/daemon.json > /dev/null
#     if [[ ! $? -eq 0 ]]; then
#         cat >/etc/docker/daemon.json<<EOF
# {
#   "tlsverify": true,
#   "tlscacert": "/etc/docker/certs.d/ca.pem",
#   "tlscert": "/etc/docker/certs.d/server-cert.pem",
#   "tlskey": "/etc/docker/certs.d/server-key.pem",
#   "hosts": ["tcp://0.0.0.0:2376", "unix:///var/run/docker.sock"]
# }
# EOF
#     fi
# else
#     cat >/etc/docker/daemon.json<<EOF
# {
#   "tlsverify": true,
#   "tlscacert": "/etc/docker/certs.d/ca.pem",
#   "tlscert": "/etc/docker/certs.d/server-cert.pem",
#   "tlskey": "/etc/docker/certs.d/server-key.pem",
#   "hosts": ["tcp://0.0.0.0:2376", "unix:///var/run/docker.sock"]
# }
# EOF
# fi
# 覆盖启动参数，解决 docker 启动失败
# if [[ ! -z $(command -v systemctl) ]];then
#     mkdir -p /etc/systemd/system/docker.service.d
#     if [[ ! -f /etc/systemd/system/docker.service.d/override.conf ]]; then
#         cat >/etc/systemd/system/docker.service.d/override.conf<<EOF
# [Service]
# ExecStart=
# ExecStart=/usr/bin/dockerd
# EOF
#     systemctl daemon-reload
#     fi
# fi
# 清理
# rm -vf client.csr server.csr extfile.cnf ca.srl server-cert.pem server-key.pem cert.pem
# 启动 docker
# service docker start
# 客户端远程连接
# echo "Connect to server via docker-cli:"
# echo "docker -H $IP:2376 --tlsverify --tlscacert ~/.docker/ca.pem --tlscert ~/.docker/cert.pem --tlskey ~/.docker/key.pem ps -a"

# 客户端使用 cURL 连接
# echo "Connect to server via curl:"
# echo "curl --cacert ~/.docker/ca.pem --cert ~/.docker/cert.pem --key ~/.docker/key.pem https://$IP:2376/containers/json"

# echo -e "\e[1;32mAll be done.\e[0m"