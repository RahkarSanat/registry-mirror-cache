#!/bin/bash
read -p "Enter username: " username
read -p "Enter password: " password
docker run --rm -ti xmartlabs/htpasswd $username $password >nginx/conf/nginx.htpasswd
