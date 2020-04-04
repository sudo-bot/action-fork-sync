FROM alpine

RUN apk add --no-cache openssh-client git bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
