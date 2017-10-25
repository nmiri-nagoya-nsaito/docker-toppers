#!/usr/bin/env bash
set -eu

cd $HOME/workdir
wget https://releases.linaro.org/components/toolchain/binaries/latest/aarch64-elf/gcc-linaro-7.1.1-2017.08-x86_64_aarch64-elf.tar.xz
mkdir aarch64-elf-gcc
tar xvf gcc-linaro-7.1.1-2017.08-x86_64_aarch64-elf.tar.xz -C aarch64-elf-gcc --strip-components 1
echo 'export PATH=$HOME/workdir/aarch64-elf-gcc/bin:$PATH' > ~/.bash_profile
source ~/.bash_profile

wget http://www.toppers.jp/download.cgi/cfg-1.9.6.tar.gz
mkdir cfg-1.9.6
tar xvf cfg-1.9.6.tar.gz -C cfg-1.9.6 --strip-components 2
cd cfg-1.9.6
nkf -e -Lu --overwrite configure
./configure --with-libraries=/usr/lib/x86_64-linux-gnu/
make
cd ..
echo $PATH
# build a FMP kernel
git clone https://github.com/YujiToshinaga/RPi64Toppers.git
cd RPi64Toppers/fmp/cfg/cfg
ln -s ../../../../cfg-1.9.6/cfg/cfg cfg
cd ../../
mkdir build; cd build
perl ../configure -T rpi_arm64_gcc
make

exit 0
