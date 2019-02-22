FROM golang as builder

RUN go get github.com/mholt/caddy/caddy
RUN go get github.com/caddyserver/builds

WORKDIR /$GOPATH/src/github.com/mholt/caddy/caddy
RUN go run build.go
RUN ls -l
RUN chmod +x caddy
RUN mv caddy /caddy

FROM ubuntu:18.04

COPY --from=builder /caddy /usr/local/bin
COPY entrypoint.sh /

WORKDIR /www
COPY www .

ENV PORT=8080
ENTRYPOINT [ "/entrypoint.sh" ]
