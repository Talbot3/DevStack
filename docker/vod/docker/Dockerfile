FROM alpine:3.10.1 AS base_image

FROM base_image AS build

RUN apk add --no-cache curl build-base openssl openssl-dev zlib-dev linux-headers ffmpeg ffmpeg-dev gd-dev pcre-dev
# --repository http://mirrors.ustc.edu.cn/alpine/v3.10/main/ --allow-untrusted
RUN mkdir nginx nginx-vod-module

ARG NGINX_VERSION=1.16.1
ARG VOD_MODULE_VERSION=2b36aea4f35bf9d302328c09b572980b78cf6fa8

RUN curl -sL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -C /nginx --strip 1 -xz
RUN curl -sL https://github.com/kaltura/nginx-vod-module/archive/${VOD_MODULE_VERSION}.tar.gz | tar -C /nginx-vod-module --strip 1 -xz

WORKDIR /nginx
RUN ./configure --prefix=/usr/local/nginx \
	--add-module=../nginx-vod-module \
	--prefix=/usr/local/nginx \
	--with-debug \
	--with-http_ssl_module \
	--with-http_realip_module \
	--with-http_image_filter_module \
	--with-http_gunzip_module \
	--with-http_gzip_static_module \
	--with-http_stub_status_module \
	--with-file-aio \
	--with-threads \
	--with-http_image_filter_module \
	--with-cc-opt="-O3"
RUN make
RUN make -j $(grep 'processor' /proc/cpuinfo | wc -l) install
RUN rm -rf /usr/local/nginx/html /usr/local/nginx/conf/*.default
# FROM base_image
# RUN apk add --no-cache ca-certificates openssl pcre zlib ffmpeg ffmpeg-dev gd-dev pcre-dev 
# COPY --from=build /usr/local/nginx /usr/local/nginx
ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]
CMD ["-g", "daemon off;"]
