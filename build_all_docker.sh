for version in `ls versions/*`
do
  echo "build for $version"
  cat $version
  source $version
  echo "#!/bin/bash" > generated/builder.sh
  cat $version >> generated/builder.sh
  cat builder.sh >> generated/builder.sh
  chmod +x generated/builder.sh
  docker build -t waxzce/rust:$RUST_VERSION .
  docker push waxzce/rust:$RUST_VERSION
  rm generated/builder.sh
done
