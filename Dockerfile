# build image
FROM elixir:1.11.4-alpine AS builder

ARG MIX_ENV=prod
WORKDIR /build

ENV MIX_ENV=${MIX_ENV} \
    STORAGE_PATH=/opt/pompey/route_list.json

COPY . .

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache build-base && \
    mix local.hex --force && \
    mix local.rebar --force && \
    rm -rf _build && \
    mix do deps.get, deps.compile, compile, release

# production image
FROM alpine:3.14.2

ARG STORAGE_LOCATION="examples/route_list.json"
WORKDIR /opt/pompey

RUN apk update && \
    apk add --no-cache bash ncurses-libs && \
    addgroup -S -g 1001 pompey && \
    adduser -S pompey -u 1001 -G pompey

USER pompey

COPY --from=builder --chown=pompey:pompey /build/_build/prod/rel/pompey .
# copy the route list
COPY --from=builder --chown=pompey:pompey /build/${STORAGE_LOCATION} ./route_list.json
CMD ["bin/pompey", "start"]
