FROM node:6.10.3-alpine

RUN apk add -U --no-cache git openssh-client

LABEL MAINTAINER="fabrice.lecoz@zedesk.net" \
      NODE_VERSION="6.10.3" \
      NPM_VERSION="3.10.10"

USER node
ENV PATH /app/.npm-packages/bin:$PATH
RUN echo "prefix=/app/.npm-packages" > ~/.npmrc

WORKDIR "/app"

VOLUME ["/app","/home/web"]

EXPOSE 8080

ENTRYPOINT ["npm"]
CMD ["start"]