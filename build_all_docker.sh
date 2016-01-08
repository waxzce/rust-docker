#!/bin/bash
echo "build Dockerfile"

sed "s;££DATE££;$(date +%D);" template_Dockerfile_ubuntu > Dockerfile_ubuntu

docker build -t waxzce/ubuntu -f Dockerfile_ubuntu
docker push -f waxzce/ubuntu

sed "s;££DATE££;$(date +%D);" template_Dockerfile > Dockerfile

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
  docker build --rm=false -t waxzce/rust-$RUST_VERSION .
  echo "push this tag : $RUST_VERSION"
  docker push -f waxzce/rust-$RUST_VERSION
  docker tag waxzce/rust-$RUST_VERSION waxzce/rust:$RUST_VERSION
  docker push -f waxzce/rust:$RUST_VERSION
  export REAL_RUST_VERSION=`docker run waxzce/rust:$RUST_VERSION cat /rust_version | tr " " _ | tr "(" _ | tr ")" _`
  docker tag waxzce/rust:$RUST_VERSION waxzce/rust:specific-$REAL_RUST_VERSION
  echo "push this tag : $REAL_RUST_VERSION"
  docker push -f waxzce/rust:specific-$REAL_RUST_VERSION
  docker tag waxzce/rust-$RUST_VERSION waxzce/rust-$RUST_VERSION:specific-$REAL_RUST_VERSION
  docker push -f waxzce/rust-$RUST_VERSION:specific-$REAL_RUST_VERSION
  if [ -z "$MORE_TAGS" ]
  then
	   echo "no more tags"
  else
	   echo "now theses tags $MORE_TAGS"
     for TAG in `echo $MORE_TAGS | tr "," "\n"`
     do
       echo "push this tag : $TAG"
       docker tag waxzce/rust:$RUST_VERSION waxzce/rust:$TAG
       docker push -f waxzce/rust:$TAG
     done
  fi
  rm generated/builder.sh
done
