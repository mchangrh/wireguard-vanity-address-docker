FROM rust:latest as builder
# clone 12-count-scalars branch
RUN git clone https://github.com/warner/wireguard-vanity-address.git -b 12-count-scalars --depth 1
# target statically compiled build with unknown linux
RUN rustup target add x86_64-unknown-linux-musl
WORKDIR /wireguard-vanity-address
# build with rust
RUN cargo build --release --target=x86_64-unknown-linux-musl
# add tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static /tini
RUN chmod +x /tini

FROM scratch
COPY --from=builder /wireguard-vanity-address/target/x86_64-unknown-linux-musl/release/wireguard-vanity-address /wireguard-vanity-address
COPY --from=builder /tini /tini
ENTRYPOINT ["/tini","--","/wireguard-vanity-address"]