#!/bin/bash
export RUST_VERSION=1.5
export RUST_DL_URL=https://static.rust-lang.org/dist/rust-1.5.0-x86_64-unknown-linux-gnu.tar.gz

curl -sL $RUST_DL_URL | tar xvz -C /tmp
/tmp/rust-*/install.sh

apt-get remove --purge -y curl
apt-get autoclean
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

mkdir /source
