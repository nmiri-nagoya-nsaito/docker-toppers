#!/usr/bin/env bash
set -eu

# variables
TMPDIR=/tmp

if [ ! -v TOOLDIR ]; then
  TOOLDIR=$HOME/MyTools
fi
AARCH64_GCCDIR=$TOOLDIR/aarch64-elf-gcc

if [ ! -v WORKDIR ]; then
  WORKDIR=$HOME/workdir
fi

if [ ! -v LIBDIR ]; then
  LIBDIR=/usr/lib/x86_64-linux-gnu
fi

# install aarch64-elf-gcc (from linaro)
cd $TMPDIR
if [ -d $AARCH64_GCCDIR ]; then 
  echo "It seems aarch64-elf-gcc tools exists in $AARCH64_GCCDIR. skip install it."
else
  wget https://releases.linaro.org/components/toolchain/binaries/7.1-2017.08/aarch64-elf/gcc-linaro-7.1.1-2017.08-x86_64_aarch64-elf.tar.xz
  mkdir -p $AARCH64_GCCDIR
  tar xvf gcc-linaro-7.1.1-2017.08-x86_64_aarch64-elf.tar.xz -C $AARCH64_GCCDIR --strip-components 1
  echo export PATH=\"$AARCH64_GCCDIR/bin:'$PATH'\" >> ~/.profile
  . ~/.profile
fi

# go to working direcory (if not exist, it will be made)
if [ ! -d $WORKDIR ]; then
  echo "$WORKDIR doesn't exists. It will be made."
  mkdir -p $WORKDIR
fi
cd  $WORKDIR

# build a TOPPERS configurator(if it doesn't exist)
if [ -e cfg-1.9.6/cfg/cfg ]; then
  echo "cfg-1.9.6 is already exist. skip build it."
else
  wget http://www.toppers.jp/download.cgi/cfg-1.9.6.tar.gz
  mkdir cfg-1.9.6
  tar xvf cfg-1.9.6.tar.gz -C cfg-1.9.6 --strip-components 2
  cd cfg-1.9.6
  nkf -e -Lu --overwrite configure
  ./configure --with-libraries=$LIBDIR
  make
fi

# build a FMP kernel
cd  $WORKDIR
if [ -d RPi64Toppers ]; then
  echo "RPi64Toppers directory already exists, so it will be renamed."
  mv RPi64Toppers RPi64Toppers_renamed.`date -I'seconds'`
fi
git clone https://github.com/YujiToshinaga/RPi64Toppers.git
mkdir -p RPi64Toppers/fmp/cfg/cfg
cd RPi64Toppers/fmp/cfg/cfg
ln -sf ../../../../cfg-1.9.6/cfg/cfg cfg
cd ../..
mkdir build; cd build
perl ../configure -T rpi_arm64_gcc
make fmp.bin

exit 0
