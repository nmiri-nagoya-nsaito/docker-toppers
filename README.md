# docker-toppers
Docker project for TOPPERS software development

# これは何か
[TOPPERSプロジェクト](http://www.toppers.jp/) 向け開発環境のベースを提供するための Docker プロジェクトです．

# 必要なもの

Dockerが必要です．事前にインストールしておく必要があります．

https://www.docker.com/

# 使い方

## このプロジェクトのファイルをダウンロード

```
$ git clone https://github.com/nmiri-nagoya-nsaito/docker-toppers.git
```
カレントディレクトリに docker-toppers という名称のディレクトリができます．

## Dockerイメージをビルドしてbashシェルを起動

```
$ cd docker-toppers
$ ./start_shell.sh 
Building cli
Step 1/16 : FROM ubuntu:xenial
 ---> 0ef2e08ed3fa
Step 2/16 : MAINTAINER Naoki Saito <saito.naoki@nmiri.city.nagoya.jp>
 ---> Using cache
 ---> 1bec673845d0
Step 3/16 : RUN apt-get update
 ---> Using cache
 ---> 2dd9e0f61959
(中略)
Step 16/16 : RUN chmod -R +x ./scripts     && sync     && ./scripts/setup_user.sh
 ---> Running in d9b928e37d60
Removing intermediate container d9b928e37d60
 ---> f77b5e071680
Successfully built f77b5e071680
Successfully tagged docker-toppers_cli:latest
Creating docker-toppers_cli_1 ... done
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

saito@fbd67644c60e:~$ 
```
これで開発用の Linuxコンテナが作られ，その中のbashシェルに入ります．

### (注)イメージのビルド途中でエラーが発生する場合

Ubuntu Xenial のイメージをベースにしてイメージを構築していますが，
古いイメージがマシンに残っている状態で実行するとイメージのビルド過程でエラーが発生することがあります．
その場合は --no-cache オプションをつけてイメージの再作成をしてください．
その上で start_shell.sh を実行します．

```
# エラーが発生する場合はこれを試してみる
$ docker-compose build --no-cache
$ ./start_shell.sh
```

## Linuxコンテナから抜ける

シェルを終了すればコンテナから出ることができます．
再度コンテナに入る場合も start_shell.sh スクリプトを実行します．

```
saito@fbd67644c60e:~$ exit
ログアウト
$ 
```
## ホスト-コンテナ間のファイル共有

コンテナを起動するとホームディレクトリ直下に workdir というディレクトリができます．
またホスト上のカレントディレクトリ直下に workdir というディレクトリもできます．
それら2つのディレクトリは同じ場所を指しているため，両者でファイルを共有するのに使用することができます．
