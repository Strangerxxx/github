FROM golang:1.15.5-alpine as builder

RUN apk add --no-cache gcc musl-dev git

ADD . /go/src/github.com/inextensodigital/github
RUN cd /go/src/github.com/inextensodigital/github && go build -a -installsuffix cgo -ldflags "-s -w" -o /go/bin/github

FROM alpine:latest

RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/github /usr/local/bin/

ENTRYPOINT ["github"]
