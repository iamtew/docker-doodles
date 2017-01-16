#! /usr/bin/env bash

: "${ORG:=iamtew}"
: "${REPO:=doodles}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGES="$( find "$DIR" -type f -name Dockerfile | sed 's/Dockerfile$//' )"

pushd() { command pushd "$@" &> /dev/null; }
popd()  { command popd "$@" &> /dev/null; }

docker_build() {
  [[ -d $1 ]] || return 1
  local image="$( basename $1 )"
  pushd $image

  echo "Building '$image' as '${ORG}/${REPO}:$image' ..."

  docker build --tag "${ORG}/${REPO}:$image" .
  popd
}

docker_push() {
  [[ -d $1 ]] || return 1
  local image="$( basename $1 )"
  pushd $image

  echo "Pushing '$image' as '${ORG}/${REPO}:$image' ..."

  docker push "${ORG}/${REPO}:$image"
  popd
}

if [[ $1 ]]; then
  docker_build "$1"
  docker_push "$1"
else
  for image in $IMAGES ; do
    docker_build "$image"
    docker_push "$image"
  done
fi
