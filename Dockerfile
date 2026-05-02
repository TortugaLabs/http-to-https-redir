# Stage 1: Build
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY . .
RUN apk add --no-cache upx && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o redirector main.go && \
    upx --best redirector

# Stage 2: Final Image
FROM scratch
COPY --from=builder /app/redirector /redirector
ENTRYPOINT ["/redirector"]
EXPOSE 80
