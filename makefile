#!/bin/bash

z=`pwd`

cd mysql/
docker build -t yousramagdy/mysql .

cd wordpress/
docker build -t yousramagdy/downloader .

cd php-fpm/
docker build -t yousramagdy/phpfpm .

cd nginx/
docker build -t yousramagdy/nginx .

#cd $z


docker run -d  --name mysql yousramagdy/mysql
docker run -i -t  --name downloader yousramagdy/downloader
docker run -d  --name app1 --volumes-from downloader --link mysql:db yousramagdy/phpfpm
docker run -d  --name app2 --volumes-from downloader --link mysql:db yousramagdy/phpfpm
docker run -d -p 8060:80 --name nginx --volumes-from downloader --link app1:app1 --link app2:app2 yousramagdy/nginx













