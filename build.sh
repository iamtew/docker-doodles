#! /usr/bin/env bash

: "${ORG:=iamtew}"
: "${REPO:=doodles}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGES="$( find "$DIR" -type f -name Dockerfile | sed 's/Dockerfile$//' )"

pushd() { command pushd "$@" &> /dev/null; }
popd()  { command popd "$@" &> /dev/null; }

build_and_push() {
  [[ -d $1 ]] || return 1
  local image="$1"
  pushd $image

  echo "Building and pushing '$image' as '${ORG}/${REPO}:$image' ..."

  docker build --tag "${ORG}/${REPO}:$image" .
  docker push "${ORG}/${REPO}:$image"
  popd
}


if [[ $1 ]]; then
  build_and_push "$1"
else
  for image in $IMAGES ; do
    build_and_push "$image"
  done
fi
