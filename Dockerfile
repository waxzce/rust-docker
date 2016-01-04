
FROM debian:wheezy
MAINTAINER Quentin ADAM "quentin.adam@waxzce.org"

# needed by cargo
ENV USER root

RUN apt-get update
RUN apt-get install -y curl gdb g++-multilib lib32stdc++6 libssl-dev libncurses5-dev

ADD generated/builder.sh builder.sh
RUN chmod +x builder.sh
RUN ./builder.sh
RUN rm builder.sh

RUN rustc -V
RUN cargo -V

VOLUME ["/source"]
WORKDIR /source
CMD ["bash"]
