#!/usr/bin/env bash
set -eu

if [ ! -e asp3 ]; then
  if [ ! -e asp3-3.1.0.tar.gz ]; then
    curl https://www.toppers.jp/download.cgi/asp3-3.1.0.tar.gz -o asp3-3.1.0.tar.gz
  fi
  tar xvf asp3-3.1.0.tar.gz
fi

if [ ! -e ssp_ruby ]; then
  if [ ! -e ssp-1.3.0.tar.gz ]; then
    curl http://www.toppers.jp/download.cgi/ssp-1.3.0.tar.gz -o ssp-1.3.0.tar.gz
  fi
  mkdir ssp_ruby
  tar xvf ssp-1.3.0.tar.gz -C ssp_ruby --strip-components 2
fi

for i in `find ssp_ruby -type f` ; do nkf --overwrite --oc=UTF-8 $i; done
cp -a asp3/sample/Makefile ssp_ruby/sample

svn co http://dev.toppers.jp/svn_user/contrib/rubycfg_ssp/trunk rubycfg_ssp
rubycfg_ssp/install.sh ssp_ruby

cd ssp_ruby
ln -s ../asp3/configure.rb configure.rb
ln -s ../asp3/cfg cfg

# build a kernel with the ruby configurator 
mkdir build
cd build
../configure.rb -T cq_frk_fm3_gcc -w
make

exit 0

