# wireguard-vanity docker

this just dockerizes [warner/wireguard-vanity-address](https://github.com/warner/wireguard-vanity-address)

## why?
it took longer to install cargo than it did to find a key

## usage
```
docker run -it ghcr.io/mchangrh/wg-vanity dave --in 10

docker run -it mchangrh/wg-vanity dave --in 10
```