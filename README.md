# zdknode

A node docker container for dev based on mhart/alpine-node

the entrypoint of the container is npm

some pkgs has been added to facilitate web development :

  - git : needed for bower

the container expose the port 8080

# dev usage

## init : create a new project

    mkdir myAwesomeSite && cd $_
    docker run --rm -it -v $PWD:/app zdknode init

the flag `-i` is important here, as the npm init command is interactive

## dependencies

### install

    docker run --rm -v $PWD:/app zdknode i

### adding dependencies

    docker run --rm -it -v $PWD:/app zdknode i supervisor -D

the `-t` flag could be useful here, to follow the installation of the package. Without this flag, you will see only the result after the installation, which could be long with npm...


## start

    docker run --rm -v $PWD:/app zdknode
