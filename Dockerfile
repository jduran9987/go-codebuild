# syntax=docker/dockerfile:1

FROM golang:1.17 

WORKDIR /app 
COPY go.mod ./
COPY go.sum ./ 

RUN go mod download

COPY *.go ./ 

RUN go build -o /docker-gs-ping

CMD ["/docker-gs-ping"]