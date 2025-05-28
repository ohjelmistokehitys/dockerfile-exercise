FROM rust

COPY ./sanuli /sanuli
WORKDIR /sanuli

RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked trunk
RUN cargo install wasm-bindgen-cli

COPY common-words.txt /sanuli/common-words.txt
COPY full-words.txt /sanuli/full-words.txt
RUN touch daily-words.txt
RUN touch full-words.txt
RUN touch profanities.txt
RUN touch easy-words.txt

RUN trunk build

EXPOSE 8080

CMD ["trunk", "serve", "--address", "172.17.0.2"]