FROM mhart/alpine-node:6.9.5

LABEL maintainer "fabrice.lecoz@zedesk.net"

RUN apk add -U --virtual tools git sudo bash openssh-client && \
    adduser -D web -s /bin/bash && \
    install -d /app -m 744 -o web && \
    npm install -g yarn && \
    echo "web   ALL=(ALL:ALL)	NOPASSWD:	ALL " > /etc/sudoers.d/web

# Drop privileges
USER web
WORKDIR "/app"

VOLUME ["/app","/home/web"]

EXPOSE 8080

ENTRYPOINT ["npm"]
CMD ["start"]
