FROM rust:latest as builder
RUN echo ${RUST_TARGET}
# clone 12-count-scalars branch
RUN git clone https://github.com/warner/wireguard-vanity-address.git -b 12-count-scalars --depth 1
# target statically compiled build with unknown linux
RUN rustup target add ${RUST_TARGET}
WORKDIR /wireguard-vanity-address
# build with rust
RUN cargo build --release --target=${RUST_TARGET}
# add tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-static /tini
RUN chmod +x /tini

FROM scratch
COPY --from=builder /wireguard-vanity-address/target/${RUST_TARGET}/release/wireguard-vanity-address /tini /
ENTRYPOINT ["/tini","--","/wireguard-vanity-address"]