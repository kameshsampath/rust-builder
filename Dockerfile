#syntax=docker/dockerfile:1.3-labs

FROM --platform=$TARGETPLATFORM rust:1.67-alpine3.17 AS bins

ARG TARGETPLATFORM

RUN apk add -U --no-cache alpine-sdk gcompat go-task \
   && cargo install cargo-zigbuild

## The core builder that can be used to build rust applications
FROM --platform=$TARGETPLATFORM alpine:3.17

ARG TARGETPLATFORM
ARG rust_version=1.67.1
ARG rustup_version=1.25.2
ARG user_id=1001
ARG user=builder

ENV USER_ID=$user_id \
    USER=$user \
    RUST_VERSION=$rust_version \
    RUSTUP_VERSION=$rustup_version \
    RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.67.1

COPY --from=bins /usr/bin/go-task /usr/local/bin/task

COPY --from=bins /usr/local/cargo/bin/cargo-zigbuild /usr/local/cargo/bin/

COPY tasks/Taskfile.root.yaml ./Taskfile.yaml

RUN task

USER $USER

ENV PATH=/usr/local/cargo/bin:$PATH
