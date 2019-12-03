FROM golang:1.13-alpine3.10 as dependencies

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

FROM dependencies as build

WORKDIR /app
COPY . .
RUN go build -o ./bin/main ./src

EXPOSE 8080

FROM alpine:3.10
WORKDIR  /app
COPY --from=build /app/bin/main .

CMD ["./main"]