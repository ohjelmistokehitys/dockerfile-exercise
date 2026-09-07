FROM rust:latest AS builder-base
# This base step should have the instructions that are required by other stages,
# such as installing dependencies.
#
# TODO: Move your previous COPY, RUN and WORKDIR instructions here, so they are completed
# before the next stages. If the WORKDIR is set to something other than `/sanuli`,
# make sure to update the COPY instruction in the release stage below to match.
#
# You can leave out the CMD instruction, as this stage is not meant to produce a
# runnable application, but to prepare a reusable environment.
# We recommend using /sanuli as the working directory:
WORKDIR /sanuli

# TODO: copy the sanuli source code to the /sanuli directory
COPY ./sanuli/Cargo.* .

RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked trunk
RUN cargo install wasm-bindgen-cli

# TODO: copy the script for fetching words and populate word lists
COPY ./fetch-words.sh .

RUN chmod +x fetch-words.sh
RUN /sanuli/fetch-words.sh

COPY ./sanuli/src ./src
COPY ./sanuli/static ./static
COPY ./sanuli/index.html ./


FROM builder-base AS dev
# This stage is used for development, and it uses the previous builder-base as its
# base, so the code and dependencies are already in place.
#
# TODO: add the CMD and EXPOSE instructions from your initial solution to expose
# the port and to start the development server.
# TODO: expose the development server port
EXPOSE 8080

# TODO: run the `trunk` development server (accept connections from outside the container)
CMD ["trunk", "serve", "--address", "0.0.0.0"]



FROM builder-base AS build
# In this stage, we will build the production artifacts. The stage uses the
# same base as the dev stage, so the environment should be ready. You should
# not need to modify this stage, as we already added the build command from
# the Sanuli readme file:
#
ENV RUSTFLAGS="--cfg=web_sys_unstable_apis --remap-path-prefix \$HOME=~"
RUN trunk build --release
#
# No CMD instruction is needed here, as there is no need to run a container
# from this stage. Instead, we will copy and serve the built artifacts from
# this stage in the next stage.



FROM nginx:alpine AS release
# This is the final stage, which uses the nginx base image to serve the built app.
# See https://hub.docker.com/_/nginx for information about the nginx base image.
#
# You should not need to modify this stage.
#
# Note that this stage is not based on the previous stages, which produced very
# large images containing the Rust toolchain and development server. Instead, it
# is based on a lightweight nginx image, which has nothing to do with Rust or
# the previous development tools. This is the key to reducing the size of the
# final image to just megabytes.
#
# We can now copy the artifacts from the `build` stage to the public directory of nginx:
COPY --from=build /sanuli/dist /usr/share/nginx/html
#
# Nginx listens to port 80 by default, so we expose that port:
EXPOSE 80
#
# A CMD instruction is not needed here, as the nginx base image already has a CMD,
# which will be inherited. The nginx server will start when this container is run.