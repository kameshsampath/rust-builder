#syntax=docker/dockerfile:1.3-labs

ARG RUST_VERSION=1.67.1

## Use to get the taskfile tool, which will be used in 
## other stages
FROM --platform=$TARGETPLATFORM alpine:3.17 AS tasker

RUN apk add -U go-task

## Zig is cross compilation tool that can be used to cross compile 
## Rust applications https://github.com/rust-cross/cargo-zigbuild
FROM --platform=$TARGETPLATFORM  messense/cargo-zigbuild:0.16.0 AS zig

## The core builder that can be used to build rust applications
FROM --platform=$TARGETPLATFORM rust:$RUST_VERSION-alpine3.17

ARG TARGETPLATFORM
ARG TARGETARCH

ARG user_id=1001
ARG user=builder

ENV USER_ID=$user_id
ENV USER=$user

COPY --from=tasker /usr/bin/go-task /usr/bin/task

COPY --from=zig /usr/local/cargo/bin/cargo-zigbuild /usr/local/cargo/bin/

COPY tasks/Taskfile.root.yaml ./Taskfile.yaml

RUN task

USER $USER
