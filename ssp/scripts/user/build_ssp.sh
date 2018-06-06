#!/usr/bin/env bash
set -eu

# build a configurator
if [ ! -e cfg-1.8.0 ]; then
  if [ ! -e cfg-1.8.0.tar.gz ]; then
    curl http://www.toppers.jp/download.cgi/cfg-1.8.0.tar.gz -o cfg-1.8.0.tar.gz
  fi
  mkdir cfg-1.8.0
  tar xvf cfg-1.8.0.tar.gz -C cfg-1.8.0 --strip-components 2
fi

cd cfg-1.8.0
./configure --with-libraries=/usr/lib/x86_64-linux-gnu/
make
cd ..

# build a SSP kernel
if [ ! -e ssp ]; then
  if [ ! -e ssp-1.3.0.tar.gz ]; then
    curl http://www.toppers.jp/download.cgi/ssp-1.3.0.tar.gz -o ssp-1.3.0.tar.gz
  fi
  tar xvf ssp-1.3.0.tar.gz
fi

cd ssp
ln -s ../cfg-1.8.0 cfg

mkdir build; cd build
perl ../configure -T cq_frk_fm3_gcc
make depend
make

exit 0

