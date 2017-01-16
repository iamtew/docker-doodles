#! /usr/bin/env bash

: "${ORG:=iamtew}"
: "${REPO:=doodles}"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IMAGES="$( find "$DIR" -type f -name Dockerfile | sed 's/Dockerfile$//' )"

pushd() { command pushd "$@" &> /dev/null; }
popd()  { command popd "$@" &> /dev/null; }

docker_build() {
  [[ -d $1 ]] || return 1
  local tag="$( basename $1 )"
  pushd $tag

  echo "Building '$tag' as '${ORG}/${REPO}:$tag' ..."

  docker build --tag "${ORG}/${REPO}:$tag" .
  popd
}

docker_push() {
  [[ -d $1 ]] || return 1
  local tag="$( basename $1 )"
  pushd $tag

  echo "Pushing '$tag' as '${ORG}/${REPO}:$tag' ..."

  docker push "${ORG}/${REPO}:$tag"
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
