FROM nginx:latest

# 环境变量
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    NGINX_PORT="8091" \
    NGINX_SSL_PORT="8095" \
    REPO_URL="https://github.com/bpking1/embyExternalUrl.git" \
    SSL="true" \
    AUTO_UPDATE="true" \
    SERVER="emby"

# 安装git
RUN apt-get update && apt-get install -y git wget && \
    cd /tmp && \
    wget https://github.com/go-acme/lego/releases/download/v3.7.0/lego_v3.7.0_linux_amd64.tar.gz && \
    tar zxvf lego_v3.7.0_linux_amd64.tar.gz && \
    chmod 755 lego && \
    mv lego / && \
    rm -rf *

# 拉取代码
RUN git clone $REPO_URL /embyExternalUrl

COPY entrypoint /entrypoint

RUN chmod +x /entrypoint

ENTRYPOINT [ "/entrypoint" ]
