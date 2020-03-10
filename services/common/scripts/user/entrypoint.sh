#!/usr/bin/env bash
set -eu

work_dir=/home/$user/workdir

mkdir -p $work_dir
sudo chown $user:$user $work_dir

/bin/bash

