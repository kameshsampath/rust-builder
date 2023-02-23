#syntax=docker/dockerfile:1.3-labs

FROM --platform=$TARGETPLATFORM cgr.dev/chainguard/git AS git

WORKDIR /src

RUN  git clone --depth=1 https://github.com/chainguard-dev/melange 

FROM --platform=$TARGETPLATFORM cgr.dev/chainguard/sdk AS sdk

FROM --platform=$TARGETPLATFORM alpine:3.17

RUN apk add -U bash file bubblewrap \
    && apk add -U go-task -X https://dl-cdn.alpinelinux.org/alpine/edge/community \
    && mkdir -p /usr/share/melange

COPY --from=git /src/melange/pkg/build/pipelines /usr/share/melange/

COPY --from=sdk /usr/bin/melange /usr/bin/apko /usr/bin/

CMD ["bash","-l"]
