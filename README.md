# zdknode : A nodejs dev environment

A node docker based on mhart/alpine-node to help development.

The goal of this image, is to provide a nodejs dev environment, without complicated install on your machine. You just need to install docker.

the entrypoint of the container is npm

some pkgs has been added to facilitate web development :

  - git : needed for bower or some npm install from git repositories
  - openssh-client : used by git+ssh
  - sudo : to do some operation as root ( only for dev purpose )
  - bash : a more useful shell

The container expose 2 volumes :

 - /app : the directory where your sources will be shared
 - /home/web : the user directory, useful to share ssh keys or other secrets like '.npmrc'

# dev usage

## init : create a new project

    mkdir myAwesomeSite && cd $_
    docker run --rm -it -v $PWD:/app /home/web zdknode init

the flag `-i` is important here, as the npm init command is interactive

## adding dependencies

    docker run --rm -it -v $PWD:/app zdknode i supervisor -D

the `-t` flag could be useful here, to follow the installation of the package. Without this flag, you will see only the result after the installation, which could be long with npm...

## start

    docker run --rm -v $PWD:/app --name my-app -p 8080:80 zdknode

There's no port explicitly exposed by the zdknode image. It's your convenience to publish the port of your application.

## adding dependencies while running

    docker exec -it my-app npm i a_package -S

    or you can also use yarn

    docker exec -it my-app yarn add a_package

if you install devDependencies command line cli like bower, add it as a script into your package.json file.

    script: {
      ...
      "bower":"bower",
      ...
    }

therefore, accessing bower cli could be done for example so :

    docker exec -it my-app npm run bower install
