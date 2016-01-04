
curl -sL $RUST_DL_URL | tar xvz -C /tmp
/tmp/rust-*/install.sh

apt-get remove --purge -y curl
apt-get autoclean
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

mkdir /source
