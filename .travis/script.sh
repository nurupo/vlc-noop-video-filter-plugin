#!/usr/bin/env bash
set -euxo pipefail

if [ "$TARGET" = "Windows" ]; then
  sudo apt-get update
  sudo apt-get install -y tree zip
  # use our own docker image for testing building of Windows binaries
  # makes sure that our docker image is not broken too
  sudo docker build -t vlc-pause-click-plugin-windows-build docker
  sudo docker run --rm -v `pwd`:/repo -v `pwd`/build:/build vlc-pause-click-plugin-windows-build $VLC_VERSION 32
  sudo docker run --rm -v `pwd`:/repo -v `pwd`/build:/build vlc-pause-click-plugin-windows-build $VLC_VERSION 64
  tree build -s --si --du
  # there should be exactly two dlls built, one for 32-bit VLC and another for 64-bit
  [ $(find ./build -name "*.dll" | wc -l) = "2" ] || false
  cd build
  ./zip-it.sh
fi
