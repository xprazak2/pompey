# Pompey

**Small and simple proxy that forwards your http requests**

Uses macros to generate dynamic routes. That means recompiling is needed when we want to add new routes.
There is a minimal API for adding routes into a file storage, see API docs at `/pompey/swaggerui`

## Installation

For development:

```
mix deps.get
iex -S mix
```

In Docker:

```
podman run -p 4001:80 pompey:latest
```
