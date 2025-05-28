# Containerizing web applications with Docker

This exercise will guide you through the process of containerizing a web application using Docker. You will learn how to create a Dockerfile, build a Docker image, and run a container from that image.

The application to be containerized this exercise is Sanuli, "A finnish version of a popular word guessing game implemented in Rust." [(Sanuli at GitHub)](https://github.com/Cadiac/sanuli) You can try the game online at [sanuli.fi](https://sanuli.fi/).

Although the game is [written in Rust](https://www.rust-lang.org/), **you do not need to know Rust nor install any Rust tools in your host system**. Instead, you will use [a Docker base image](https://hub.docker.com/_/rust) that contains the necessary tools to build and run the application.

We assume that you have completed previous exercises in this course and are familiar with basic concepts of Docker.


## How to complete this exercise

First, make sure you are working on your personal copy of the repository. You can find more information about that in the course assignment. Complete the exercises while reading the course materials and the [Docker documentation](https://docs.docker.com/). You will also need to read the documentation for specific containers and commands used in the exercises.


## The Sanuli *submodule*

Sanuli has its own [Git repository](https://github.com/Cadiac/sanuli), which we have included as a submodule in this repository for convenience. This allows you to easily access the Sanuli code without needing to clone it separately. You will not need to make any changes in the Sanuli code.

Initially after you have cloned this repository, the submodule [/sanuli](./sanuli) will be empty. To populate it with the code from the upstream Sanuli repository, you need to initialize and update the submodule.

Initialize and update the [/sanuli](./sanuli/) submodule by running the following commands in your terminal:

```bash
git submodule init
git submodule update
```

When the submodule is initialized, familiarize yourself with [Sanuli's readme file](./sanuli/README.md), which contains instructions on how to build and run the application. There are also instructions on how to prepare the word lists that the game uses, which we will cover later in the exercise.

If you want to learn more about Git submodules, we recommend watching the video [Git Submodules Tutorial (YouTube)](https://youtu.be/gSlXo2iLBro?si=Q_srt86bHf767323) or reading the [Git documentation on submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules). However, the two commands above are all you need in this exercise.


## Creating the Dockerfile

This repository contains a [Dockerfile](./Dockerfile) that you will use to build the Docker image for Sanuli. The Dockerfile is a text file that contains instructions for building a Docker image.

Dockerfiles are used to create container images, which are the executable packages that contain everything needed to run an application, including the code, runtime, libraries, and dependencies.

Images are based on base images, which provide the operating system and other necessary components. In this exercise, we recommend using the official [Rust base image](https://hub.docker.com/_/rust) as the base image, as it already contains the necessary command line tools:

* [`rustup` for toolchain management](https://www.rust-lang.org/tools/install).
* [`cargo` for package management](https://doc.rust-lang.org/cargo/).
* Sanuli also uses the [`trunk` web application bundler](https://github.com/trunk-rs/trunk), which is installed with `cargo`.

The [Sanuli readme file](./sanuli/README.md) already contains all the commands needed to build and run the application. Note that you don't need to install Rust, if you use a base image with Rust already installed.

Further steps in creating the Dockerfile include applying the `WORKDIR`, `COPY`, `RUN`, `EXPOSE` and `CMD` instruction. These instructions are described in practically every Docker tutorial and they are typically used very similarly regardless of the technology being used, so there are lots of resources to utilize. Take note of the quick start instructions in the Sanuli readme and apply them in the Dockerfile.

We recommend referring to the [Dockerfile reference documentation](https://docs.docker.com/reference/dockerfile/) for a detailed explanation of each instruction. The [Docker workshop (docker.com)](https://docs.docker.com/get-started/workshop/) also provides a good introduction to Dockerfiles and how to use them.

Take note about when each instruction should be executed. For example, building the application should happen in the build phase using `RUN` instructions, while running the application should be done in the run phase using `CMD` (or `ENTRYPOINT`) instructions.

## Running the containerized application


## Ignoring files with `.dockerignore`

The container seems to be running nicely, but there are some files in there that we would not like to copy into the container. Typically such files include local build artifacts or *npm_modules* that are not needed in the container. In Sanuli's case, we would like to ignore the README.md file.

You can use a `.dockerignore` file to specify which files and directories should be ignored when building the Docker image. Add a `.dockerignore` file to the alongside your Dockerfile and add the `README.md` file to it. Then add and commit your changes to the repository.


## Submitting your work

Add, commit and push your solutions to your repository to invoke the automated grading. You can and should commit your solutions after each step to keep track of your progress and to make it easier to debug any issues that may arise. The automated grading will check your solutions and provide feedback on your progress.

Automated grading is implemented using GitHub actions and GitHub classroom. After each commit, you can see the autograding results as well as each test and their outputs in the *actions* tab under *Classroom Autograding Workflow*. You can push new solutions as many times as necessary until the deadline of the exercise.

## Optional: remove the container(s) and image(s)

If you wish, you can remove the containers and images created during this exercise. Use the commands `docker container ls --all` and `docker image ls` to list all containers and images. You will need to stop and remove containers before you can remove the images. To remove a container, use the `docker container rm` command, and to remove an image, use the `docker image rm` command.

* [`docker container` documentation](https://docs.docker.com/reference/cli/docker/container/)
* [`docker image` documentation](https://docs.docker.com/reference/cli/docker/image/)


## About the exercise

This exercise has been created by Teemu Havulinna and is licensed under the [Creative Commons BY-NC-SA license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

AI tools such as ChatGPT and GitHub Copilot have been used in the implementation of the task description, source code, data files and tests.