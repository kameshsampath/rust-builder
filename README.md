# Rust Builder

[![Docker](https://github.com/kameshsampath/rust-builder/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/kameshsampath/rust-builder/actions/workflows/docker-publish.yml)

A [rust-lang](https://rust-lang.org) builder docker container that can be used for development and CI.

## Pre-requisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Use Docker Image

The pre-built docker image is available on [Docker Hub](https://hub.docker.com/repository/docker/kameshsampath/rust-builder). All images are signed by [cosign](https://sigstore.dev).

You can verify the signatures using the commands:

```shell
export COSIGN_EXPERIMENTAL=1
cosign verify docker.io/kameshsampath/rust-zig-builder:main
```

## Build Locally

```shell
docker buildx build -t my-rust-builder --load -f Dockerfile.
```

## Example Projects

Checkout <https://github.com/kameshsampath/rust-hello-world> for an example of how to use this image with [Drone](https://docs.drone.io/cli/install/).

## References

- <https://ziglang.org/>
- <https://github.com/rust-cross/cargo-zigbuild>
