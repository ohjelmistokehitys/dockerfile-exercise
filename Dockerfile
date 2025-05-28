FROM rust

COPY ./sanuli /sanuli
WORKDIR /sanuli

RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked trunk
RUN cargo install wasm-bindgen-cli

RUN touch common-words.txt
RUN touch daily-words.txt
RUN touch full-words.txt
RUN touch profanities.txt
RUN touch easy-words.txt

EXPOSE 8080

CMD ["trunk", "serve"]