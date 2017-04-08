#!/usr/bin/env bash
#
# Run a test for all images.

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

  info "Testing NodeJS version $tag..."
  docker run hypriot/rpi-node:$tag node --version

  if [[ $? -gt 0 ]]; then
    fatal "Test of $tag failed!"
  else
    info "Test of $tag succeeded."
  fi

  info "Testing Yarn..."
  docker run hypriot/rpi-node:$tag yarn --version

  if [[ $? -gt 0 ]]; then
    fatal "Test of $tag failed!"
  else
    info "Test of $tag succeeded."
  fi

  variants=( slim onbuild )

  for variant in "${variants[@]}"; do
    info "Testing NodeJS version $tag-$variant variant..."
    docker run hypriot/rpi-node:$tag-$variant node --version

    if [[ $? -gt 0 ]]; then
      fatal "Test of $tag-$variant failed!"
    else
      info "Test of $tag-$variant succeeded."
    fi

    info "Testing Yarn-$variant variant..."
    docker run hypriot/rpi-node:$tag yarn --version

    if [[ $? -gt 0 ]]; then
      fatal "Test of $tag failed!"
    else
      info "Test of $tag succeeded."
    fi

  done

done

info "All tests successful!"

exit 0
