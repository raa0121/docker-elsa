FROM golang:1.15-alpine AS build
ENV GO111MODULES true
RUN apk add --update curl make gcc git musl-dev && \
    go get -u github.com/go-bindata/go-bindata/...
WORKDIR /app
RUN curl -LO https://github.com/elsaland/elsa/archive/master.tar.gz && \
    tar xf master.tar.gz && \
    rm -f master.tar.gz && \
    cd elsa-master && \
    make build
FROM alpine AS runtime
COPY --from=build /app/elsa-master/elsa /usr/local/bin/elsa
CMD ["/usr/local/bin/elsa"]
