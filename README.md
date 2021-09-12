# Pompey

Small and simple proxy that forwards http requests and served me well when exploring various Elixir concepts. It uses macros to generate handlers for the dynamic routes. So even though there is a minimal API for adding routes into a file storage (see API docs at `/pompey/swaggerui`), recompiling is needed for the new routes to show. My conclusion is that for the same feature in a real-life scenarions, [rule 1](https://medium.com/pragmatic-programmers/macro-rules-21e7e79a4179) of macros should be applied ;-).


## Installation

For development:

```
mix deps.get
iex -S mix
```

In Docker:

```
podman run -p 4001:4001 pompey:latest
```
