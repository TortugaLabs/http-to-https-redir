# http-to-https-redirector

A minimal HTTP → HTTPS redirector written in Go. It issues a `301 Moved Permanently` redirect for every incoming request, preserving the host, path, and query string.

## How it works

Any request arriving on port 80 is redirected to the same URL with `https://` as the scheme:

```
http://example.com/foo?bar=1  →  https://example.com/foo?bar=1
```

## Container image

Pre-built images are published to the GitHub Container Registry on every push to `main` and on every semver tag:

```
ghcr.io/tortugalabs/http-to-https-redir:latest
ghcr.io/tortugalabs/http-to-https-redir:v1.2.3
```

## Usage

### Docker

```bash
docker run -d -p 80:80 ghcr.io/tortugalabs/http-to-https-redir:latest
```

### Docker Compose

```yaml
services:
  redirector:
    image: ghcr.io/tortugalabs/http-to-https-redir:latest
    ports:
      - "80:80"
    restart: unless-stopped
```

## Building locally

**Go:**
```bash
go build -o redirector main.go
./redirector
```

**Docker:**
```bash
docker build -t http-to-https-redirector .
docker run -p 80:80 http-to-https-redirector
```

## Publishing

The GitHub Actions workflow in `.github/workflows/docker-publish.yml` builds and pushes the image to GHCR automatically:

| Event | Tags produced |
|---|---|
| Push to `main` | `main`, `sha-<short-sha>` |
| Tag `v1.2.3` | `v1.2.3`, `1.2`, `1`, `sha-<short-sha>` |
| Pull request | image is built but **not** pushed |

## License

MIT
