#!/usr/bin/env bash

set -eu

echo export LANG=ja_JP.UTF-8 >> ${HOME}/.profile
echo export LANGUAGE=ja_JP:ja >> ${HOME}/.profile
echo LV="-Au8" >> ${HOME}/.profile
cat << EOS >> ${HOME}/.vimrc
:set fenc=utf-8
:set fencs=iso-2022-jp,euc-jp,cp932,utf-8
:set enc=utf-8
EOS

exit 0
