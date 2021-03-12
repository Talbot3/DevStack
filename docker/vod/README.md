# 视频点播系统

## nginx Vod module 原生安装步骤

> [源码地址](https:/s/github.com/kaltura/nginx-vod-module)
0. 下载源码并切换到执行目录

```bash
//一般通过源码安装的方式，将nginx模块编译安装。
//首先安装nginx源码，如果安装了nginx需要与当前版本一致。
git clone https://github.com/kaltura/nginx-vod-module;
./travis_build.sh && cd /tmp/builddir/
```

1. 如果已经安装了nginx, configure后面的参数根据`nginx -V`确定，并增加适当的配置`--add-dynamic-module=/opt/nginx-1.16.0/nginx-vod-module`。如果未安装，根据官方建议配置生产环境编译参数、开发环境参数等。然后执行`make` `make install`
2. 根据官方模块特性配置/etc/nginx.conf,然后验证模块特性`nginx -t`.若`success`,则执行`nginx -s reload`

### 比较两个文件是否一致

> 用于查看插件是否为最新编译文件

```bash
md5sum file1
md5sum file2
# 观察生成的hash
```

### 查看参数配置

```bash
nginx -V
```

### 卸载

```bash
    sudo apt-get remove nginx nginx-common
    # 卸载删除除了配置文件以外的所有文件。

    sudo apt-get purge nginx nginx-common
    # 卸载所有东东，包括删除配置文件。

    sudo apt-get autoremove
    # 在上面命令结束后执行，主要是卸载删除Nginx的不再被使用的依赖包。

    sudo apt-get remove nginx-full nginx-common #卸载删除两个主要的包。

　　 sudo service nginx restart
　　#重启nginx
```

### 配置静态hls服务

> 为mp4服务，动态生成hls视频流
> /etc/nginx/nginx.conf

```
server {
        listen 4444;
        location /static/ {
          alias /home/dp/data/out/;
          expires 7d;
          log_not_found off;
          access_log off;
          client_max_body_size 1G;
          client_body_buffer_size 1280k;
          proxy_connect_timeout 900;
          proxy_buffer_size 40000k;
          proxy_buffers 4000 32000k;
          proxy_busy_buffers_size 64000k;
          proxy_temp_file_write_size 64000k;
        }
        location /hls {
          vod hls;
          add_header Access-Control-Allow-Headers '*';
          add_header Access-Control-Expose-Headers 'Server,range,Content-Length,Content-Range';
          add_header Access-Control-Allow-Methods 'GET, HEAD, OPTIONS';
          add_header Access-Control-Allow-Origin '*';
          alias /home/dp/data/out/;
        }
}
```

### 动态生成视频封面图片

> 配置如下

```
       location /thumb {
          vod thumb;
          alias /home/dp/data/out;
          add_header Access-Control-Expose-Headers 'Server,range,Content-Length,Content-Range';
          add_header Access-Control-Allow-Origin '*';
          add_header Access-Control-Allow-Headers '*';
          add_header Access-Control-Allow-Methods 'GET, HEAD, OPTIONS';
       }
```

#### 定义缩略图大小

thumb-1000-w150-h100.jpg在视频中捕获缩略图1秒，并将其大小调整为150x100。如果省略其中一个尺寸，则设置其值以使得生成的图像保持视频帧的纵横比

#### 示例

http://180.167.172.54:4444/thumb/wrong_video/2019-09-18/camera_1/1_wrong_time20190918081807.mp4/thumb-15.jpg
