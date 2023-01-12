# Registry Mirror Server With Nginx
It can be used ro bypass docker-hub & gcr limitations for iranian developers. just run this services on server with access to free internet.

## Usage
Either pass the `--registry-mirror` option when starting `dockerd` manually, or edit `/etc/docker/daemon.json` and add the `registry-mirrors` key and value, to make the change persistent.
```json
{
  "registry-mirrors": ["https://<my-docker-mirror-host>"]
}
```

>  You **must** enable **https** on installation if you want pull images without setting `registry-mirrors`, for example something like this:
``` bash
docker pull registry-docker.example.com/curlimages/curl
```
> If you enabled auth credentials on installation you have to login to repository on your machine by executing:
```bash
docker login registry-docker.example.com
docker login registry-k8s.example.com
# etc
```

## Supported Repository
- **`registry-1.docker.io`** as `registry-docker.example.com`
- **`k8s.gcr.io`** as `registry-k8s.example.com`
- **`quay.io`** as `registry-quay.example.com`
- **`gcr.io`** as `registry-gcr.example.com`
- **`ghcr.io`** as `registry-ghcr.example.com`

## Requirements
- docker
- docker-compose


## installation
```bash
# Just run 
./install.sh # it will ask everything needs...
```
--------------
read more :
[Registry as a pull through cache](https://docs.docker.com/registry/recipes/mirror/)