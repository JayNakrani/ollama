#!/bin/sh

set -eu

export VERSION=${VERSION:-0.0.0}
export GOFLAGS="'-ldflags=-w -s \"-X=github.com/jmorganca/ollama/version.Version=$VERSION\" \"-X=github.com/jmorganca/ollama/server.mode=release\"'"

rm -rf dist
mkdir -p dist

for TARGETARCH in arm64 amd64; do
    GOOS=darwin GOARCH=$TARGETARCH go generate ./...
    GOOS=darwin GOARCH=$TARGETARCH go build -o dist/ollama-darwin-$TARGETARCH
done
