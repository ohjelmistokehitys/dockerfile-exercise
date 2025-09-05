# see https://hub.docker.com/_/rust
FROM rust:latest

# We recommend using /sanuli as the working directory:
WORKDIR /sanuli

# TODO: copy the sanuli submodule to the /sanuli directory


# Copy the script for fetching words and populate word lists:
COPY fetch-words.sh ./
RUN chmod +x fetch-words.sh
RUN ./fetch-words.sh


# TODO: follow the quick start instructions of Sanuli readme
# (the `rustup` and `cargo` steps in quick start)

# TODO: expose the development server port
# (check Sanuli readme for the dev server port)

# Run the `trunk` development server, and accept connections
# from outside the container:
CMD ["trunk", "serve", "--address", "0.0.0.0"]
