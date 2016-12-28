#!/usr/bin/env bash
#
# Push all images.

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

  info "Tagging $tag..."
  v=( ${tag//./ }  )
  tag_major="${v[0]}"
  tag_minor="${v[0]}.${v[1]}"
  tag_patch="${v[0]}.${v[1]}.${v[2]}"
  if [ $tag_major == "4" ]; then
    name="argon"
  fi
  if [ $tag_major == "6" ]; then
    name="boron"
  fi
  if [ $tag_major == "7" ]; then
    name=""
  fi
  docker tag hypriot/rpi-node:$tag hypriot/rpi-node:$tag_major
  docker tag hypriot/rpi-node:$tag hypriot/rpi-node:$tag_minor
  docker tag hypriot/rpi-node:$tag hypriot/rpi-node:$tag_patch
  docker push hypriot/rpi-node:$tag_major
  docker push hypriot/rpi-node:$tag_major
  docker push hypriot/rpi-node:$tag_minor
  docker push hypriot/rpi-node:$tag_patch
  if [ -z $name ]; then
    docker tag hypriot/rpi-node:$tag hypriot/rpi-node:latest
    docker push hypriot/rpi-node:latest
  else
    docker tag hypriot/rpi-node:$tag hypriot/rpi-node:$name
    docker push hypriot/rpi-node:$name
  fi

  if [[ $? -gt 0 ]]; then
    fatal "Tag of $tag failed!"
  else
    info "Tag of $tag succeeded."
  fi

  variants=( slim onbuild )

  for variant in "${variants[@]}"; do
    info "Tagging $tag-$variant variant..."
    docker tag hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$tag_major-$variant
    docker tag hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$tag_minor-$variant
    docker tag hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$tag_patch-$variant
    docker push hypriot/rpi-node:$tag-$variant
    docker push hypriot/rpi-node:$tag_major-$variant
    docker push hypriot/rpi-node:$tag_minor-$variant
    docker push hypriot/rpi-node:$tag_patch-$variant
    if [ -z $name ]; then
      docker tag hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$variant
      docker push hypriot/rpi-node:$variant
    else
      docker tag hypriot/rpi-node:$tag-$variant hypriot/rpi-node:$name-$variant
      docker push hypriot/rpi-node:$name-$variant
    fi

    if [[ $? -gt 0 ]]; then
      fatal "Tag of $tag-$variant failed!"
    else
      info "Tag of $tag-$variant succeeded."
    fi

  done

done

info "All builds successful!"

exit 0
