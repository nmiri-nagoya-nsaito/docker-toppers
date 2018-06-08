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
$ cd docker-toppers-fmp-rpi64
$ ./start_shell.sh
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
$ exit
```
## ホスト-コンテナ間のファイル共有

コンテナを起動するとホームディレクトリ直下に workdir というディレクトリができます．
またホスト上のカレントディレクトリ直下に workdir というディレクトリもできます．
それら2つのディレクトリは同じ場所を指しているため，両者でファイルを共有するのに使用することができます．
