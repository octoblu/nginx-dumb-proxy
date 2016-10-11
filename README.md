# nginx-dumb-proxy

This proxy blindly forwards all HTTP traffic to a hostname specified using the `TARGET_HOSTNAME` environment variable. The HTTP `Host` header is rewritten to match the `TARGET_HOSTNAME` value, but the `pathname` and other properties are preserved.

## Usage

To run interactively:

```shell
docker run \
  --rm \
  --name nginx-dumb-proxy \
  --publish 80:80 \
  --interactive \
  --tty \
  --env TARGET_HOSTNAME=foo.example.com \
  octoblu/nginx-dumb-proxy:v1.x.x
```

## TODO

- [ ] Map original request `Host` to `x-forwarded-for`
