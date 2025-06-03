# see https://hub.docker.com/_/rust
FROM rust:latest

# We recommend using /sanuli as the working directory and
# copying the application code there. If you use a different
# path, you need to adjust the instructions in the later parts
# of the exercise accordingly.
WORKDIR /sanuli

# TODO: copy the source code to the working directory

# TODO: follow the quick start instructions of Sanuli readme

# TODO: fetch or create word lists
# hint: see the readme.md and fetch-words.sh

# TODO: expose the development server port

# TODO: run the development server
# hint: see the readme.md for information on accepting
# connections from outside the container