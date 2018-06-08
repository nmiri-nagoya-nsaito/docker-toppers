#!/usr/bin/env bash

set -eu

DEBIAN_FRONTEND=noninteractive apt-get install -y language-pack-ja lv nkf tzdata
echo "Asia/Tokyo" > /etc/timezone
rm /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
update-locale LANGUAGE=ja_JP:ja LANG=ja_JP.UTF-8

exit 0
