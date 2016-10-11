# nginx-dumb-proxy

This proxy blindly forwards all HTTP traffic to a hostname specified using the `TARGET_HOSTNAME` environment variable. The HTTP `Host` header is rewritten to match the `TARGET_HOSTNAME` value, but the `pathname` and other properties are preserved.

By default, the traffic will be redirected using HTTPS. In some cases, the redirected traffic will be within some private network and it will make more sense to use HTTP. This can be achieved by setting the `TARGET_PROTOCOL` to http. You probably
shouldn't do this if the end-user is expecting their traffic to be encrypted unless the forwarded request has some other form of network security, such as in a private network.

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

- [ ] Map original request ip to `x-forwarded-for`
