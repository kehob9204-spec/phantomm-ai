FROM golang:1.24-alpine AS build
WORKDIR /src
COPY go.mod .
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags='-s -w' -o phantom-ai main.go

FROM alpine:3.22
RUN adduser -D -H -s /sbin/nologin phantom
WORKDIR /app
COPY --from=build /src/phantom-ai /app/phantom-ai
COPY phantom_config.json.example /app/phantom_config.json.example
USER phantom
ENV PORT=8080
EXPOSE 8080
CMD ["/app/phantom-ai"]
