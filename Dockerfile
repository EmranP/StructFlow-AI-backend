FROM golang:1.25.5-alpine

WORKDIR /app

RUN apk add --no-cache git build-base

RUN go install github.com/air-verse/air@v1.64.5

COPY go.mod go.sum ./
RUN go mod download

EXPOSE 8080

CMD ["air", "-c", ".air.toml"]