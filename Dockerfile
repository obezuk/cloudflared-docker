FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl
RUN curl https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz -o /cloudflared.tgz
RUN tar -xzvf /cloudflared.tgz

FROM alpine:latest
COPY --from=0 /cloudflared /usr/bin/cloudflared
RUN apk add --no-cache libc6-compat
RUN chmod +x /usr/bin/cloudflared

ENTRYPOINT ["cloudflared"]