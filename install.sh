#!/bin/bash
read -p "Enter your domain: " domain
echo "DOMAIN=$domain" >.env

function run() {
  echo "TYPE=default" >>.env
  docker-compose up -d
  exit 0
}

function auth() {
  read -p "Enter username: " username
  read -p "Enter password: " password
  docker run --rm -ti xmartlabs/htpasswd $username $password >nginx/conf/nginx.htpasswd
  echo 'AUTH_BASIC="Registry realm"' >.env
}

function noauth() {
  echo 'AUTH_BASIC="off"' >.env
  echo "" >nginx/conf/nginx.htpasswd
}

function run_ssl() {
  echo "TYPE=ssl" >>.env
  docker-compose up -d
  exit 0
}

read -p "Enable auth credentials? (y/N): " auth && [[ $auth == [yY] || $auth == [yY][eE][sS] ]] && auth || noauth
read -p "Enable https? (y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || run

echo "Starting to requesting a certificate for *.$domain"
read -p "Enter your email: " email

docker-compose run certbot certonly --preferred-challenges=dns --agree-tos --email $email --manual -d *.$domain --server https://acme-v02.api.letsencrypt.org/directory && run_ssl || exit 1
