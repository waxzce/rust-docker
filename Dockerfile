
FROM debian:wheezy
MAINTAINER Quentin ADAM "quentin.adam@waxzce.org"

# needed by cargo
ENV USER root

RUN apt-get update
RUN apt-get install -y curl gdb g++-multilib lib32stdc++6 libssl-dev libncurses5-dev

RUN curl -sL https://static.rust-lang.org/dist/rust-beta-x86_64-unknown-linux-gnu.tar.gz | tar xvz -C /tmp
RUN /tmp/rust-beta-x86_64-unknown-linux-gnu/install.sh

RUN apt-get remove --purge -y curl
RUN apt-get autoclean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rustc -V
RUN cargo -V

RUN mkdir /source

VOLUME ["/source"]
WORKDIR /source
CMD ["bash"]
