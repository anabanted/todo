FROM rust AS builder

WORKDIR /todo
COPY Cargo.toml Cargo.toml
RUN mkdir src
RUN echo "fn main(){}" > src/main.rs
RUN cargo build --release
COPY ./src ./src
COPY ./templates ./templates
RUN rm -f target/release/deps/todo*
RUN cargo build --release

FROM debian

COPY --from=builder /todo/target/release/todo /usr/local/bin/todo
CMD ["todo"]
