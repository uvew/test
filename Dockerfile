FROM alpine:latest

RUN apk add --no-cache bash curl jq git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
