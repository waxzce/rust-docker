
curl -sL $RUST_DL_URL | tar xz -C /tmp
/tmp/rust-*/install.sh
cp /tmp/rust-*/version /rust_version

apt-get remove --purge -y curl
apt-get autoclean
apt-get clean
rm -rf /tmp/* /var/tmp/*

mkdir /source
