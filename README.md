# zdknode : A nodejs dev environment

A node docker based on [official node image][1] to help development.

The goal of this image, is to provide a nodejs dev environment, without complicated install on your machine. You just need to install docker, and pull the image.

The entrypoint of the container is npm, which is much more useful.

Some pkgs has been added to facilitate web development :

  - git : needed for bower or some npm install from git repositories
  - openssh-client : used by git+ssh

The container expose 2 volumes :

 - /app : the directory where your sources will be shared
 - /home/node : the user directory, useful to share ssh keys or other secrets like '.npmrc'

 The image expose by default the follwing ports :

  - 8080 : used to expose a http service
  - 5858 : node debug port
  - 9229 : node inspect port

The container use internally the `node` user ( uid=1000, gid=1000 ) to run the npm scripts commands. So, services started by npm scripts could only use port beyond 1024.

# dev usage

## init : create a new project

    mkdir myAwesomeSite && cd $_
    docker run --rm -it -v $PWD:/app zedesk/zdknode init

> __Nota :__ the `-it` is important in the command above, as `npm init` is interactive

## Adding dependencies

### Project dependencies

Install dependencies as usual, for example :

```bash
docker run --rm -v $PWD:/app zdknode i supervisor -D
```

### Global dependencies

```bash
docker run --rm -v $PWD/test:/app zedesk/zdknode i bower -g
docker run --rm -v $PWD/test:/app zedesk/zdknode ls -g --depth=0
```

Global packages are installed into the `.npm-packages` directory into your shared sources folder.

```
/app/.npm-packages/lib
`-- bower@1.8.0
```

## start

To start a web application, the image exposes the port 8080, so it's recommended to use it.

> __Nota :__ As the default user of the container is `node`, the port 80 is not available, you should use a port number over 1024.

```bash
docker run --rm -v $PWD:/app --name my-app -p 8080:80 zdknode
```

## adding dependencies while running

```
docker exec -it my-app npm i a_package -S
```

if you install devDependencies command line cli like bower, add it as a script into your package.json file.

    script: {
      ...
      "bower":"bower",
      ...
    }

therefore, accessing bower cli could be done for example so :

    docker exec -it my-app npm run bower install

[1]: https://hub.docker.com/_/node/