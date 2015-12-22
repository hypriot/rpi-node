#!/usr/bin/env bash
#
# Run a test build for all images.

set -uo pipefail

info() {
  printf "%s\n" "$@"
}

fatal() {
  printf "**********\n"
  printf "%s\n" "$@"
  printf "**********\n"
  exit 1
}

cd $(cd ${0%/*} && pwd -P);

versions=( "$@" )
if [ ${#versions[@]} -eq 0 ]; then
  versions=( */ )
fi
versions=( "${versions[@]%/}" )

for version in "${versions[@]}"; do

  echo $version
  tag=$(cat $version/Dockerfile | grep "ENV NODE_VERSION" | cut -d' ' -f3)
  minor_tag=$(echo $tag | cut -d "." -f 1-2)
  major_tag=$(echo $tag | cut -d "." -f 1)

  info "Building $tag..."
  docker build -q -t hypriot/rpi-node:$tag $version

  if [[ $? -gt 0 ]]; then
    fatal "Build of $tag failed!"
  else
    info "Build of $tag succeeded."
  fi

  docker tag -f hypriot/rpi-node:$tag hypriot/rpi-node:$minor_tag
  docker tag -f hypriot/rpi-node:$tag hypriot/rpi-node:$major_tag

  if [ "$major_tag" -eq "4" ]; then
    docker tag -f hypriot/rpi-node:$major_tag hypriot/rpi-node:argon
  fi

  variants=( onbuild slim wheezy )

  for variant in "${variants[@]}"; do
    info "Building $tag-$variant variant..."
    docker build -q -t hypriot/rpi-node:$tag-$variant $version/$variant

    if [[ $? -gt 0 ]]; then
      fatal "Build of $tag-$variant failed!"
    else
      info "Build of $tag-$variant succeeded."
    fi

    docker tag -f hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$minor_tag-$variant
    docker tag -f hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$major_tag-$variant

    if [ "$major_tag" -eq "4" ]; then
      docker tag -f hypriot/rpi-node:$major_tag-$variant hypriot/rpi-node:argon-$variant
    fi
  done

done

if [ "$major_tag" -eq "5" ]; then
  docker tag -f hypriot/rpi-node:$major_tag hypriot/rpi-node:latest
fi

info "All builds successful!"

exit 0
