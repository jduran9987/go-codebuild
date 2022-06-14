# syntax=docker/dockerfile:1

FROM public.ecr.aws/docker/library/golang:1.17-buster

WORKDIR /app 
COPY go.mod ./
COPY go.sum ./ 

RUN go mod download

COPY *.go ./ 

RUN go build -o /docker-gs-ping

CMD ["/docker-gs-ping"]
