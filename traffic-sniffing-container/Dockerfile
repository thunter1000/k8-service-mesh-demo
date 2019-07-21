FROM alpine:3.9
RUN apk add --no-cache tcpdump
CMD touch tcpdump && ( tcpdump -i any -s 65535 -w tcpdump -n port 80& )  && tail -f tcpdump