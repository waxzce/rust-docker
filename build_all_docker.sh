#!/bin/bash


for version in `ls versions/*`
do
  echo "<---------------------------------------------------->"
  echo "build for $version"
  cat $version
  source $version
  echo "#!/bin/bash" > generated/builder.sh
  cat $version >> generated/builder.sh
  cat builder.sh >> generated/builder.sh
  chmod +x generated/builder.sh
  docker build --rm=false -t waxzce/rust:$RUST_VERSION .
  docker push waxzce/rust:$RUST_VERSION
  export REAL_RUST_VERSION=`docker run waxzce/rust:$RUST_VERSION cat /rust_version | tr " " _ | tr "(" _ | tr ")" _`
  docker tag waxzce/rust:$RUST_VERSION waxzce/rust:specific-$REAL_RUST_VERSION
  docker push waxzce/rust:specific-$REAL_RUST_VERSION
  rm generated/builder.sh
done
