A node docker based on mhart/alpine-node

the entrypoint of the container is npm

some pkgs has been added to facilitate web development :

  - git : needed for bower


# dev usage

## init : create a new project

    mkdir myAwesomeSite && cd $_
    docker run --rm -it -v $PWD:/home/web zdknode init

the flag `-i` is important here, as the npm init command is interactive

## adding dependencies

    docker run --rm -it -v $PWD:/home/web zdknode i supervisor -D

the `-t` flag could be useful here, to follow the installation of the package. Without this flag, you will see only the result after the installation, which could be long with npm...

## start

    docker run --rm -v $PWD:/home/web zdknode start
