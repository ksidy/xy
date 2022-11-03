FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
RUN git clone --progress https://github.com/XTLS/Xray-core.git && cd Xray-core && go mod download && \
    CGO_ENABLED=0 go build -o xy -trimpath -ldflags "-s -w -buildid=" ./main

FROM alpine
COPY --from=builder /go/Xray-core/xy /usr/bin

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
