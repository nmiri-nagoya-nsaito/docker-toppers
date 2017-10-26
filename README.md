# docker-toppers-fmp-rpi64
Docker project for TOPPERS/FMP on Raspberry Pi with AArch64

# これは何か
Raspberry Pi3 向け TOPPERS/FMP カーネルのための開発環境を構築するためのDockerプロジェクトです．

# 使い方

## このプロジェクトのファイルをダウンロード

```
$ git clone https://github.com/nmiri-nagoya-nsaito/docker-toppers-fmp-rpi64.git
```
カレントディレクトリに docker-toppers-fmp-rpi64 という名称のディレクトリができます．

## Dockerイメージをビルドしてbashシェルを起動

```
$ cd docker-toppers-fmp-rpi64
$ ./start_shell.sh
```
これでTOPPERS/FMP開発用の Linuxコンテナが作られ，その中のbashシェルに入ります．

Ubuntu Xenial のイメージをベースにしてイメージを構築していますが，
古いイメージがマシンに残っている状態で実行するとイメージのビルド過程でエラーが発生することがあります．
その場合は --no-cache オプションをつけてイメージの再作成をしてください．
その上で start_shell.sh を実行します．

```
$ docker-compose build --no-cache
$ ./start_shell.sh
```


シェルを終了すればコンテナから出ることができます．
再度コンテナに入る場合も start_shell.sh スクリプトを実行します．

```
$ exit
```

## TOPPRERS/FMPカーネルのビルド

```
$ cd workdir
$ ../scripts/build_fmp.sh
```

ビルドに成功すると， workdir/RPi64Toppers/fmp/build/fmp.bin ができます．

コンテナを起動するとホームディレクトリ直下に workdir というディレクトリができます．
またホスト上のカレントディレクトリ直下に workdir というディレクトリもできます．
それら2つのディレクトリはコンテナとホストとで同じ場所をさしており，ファイルを両者で共有するのに使うことができます．

Raspberry Pi を起動する場合， ホスト上から見える workdir/RPi64Toppers/fmp/build/fmp.bin をSDカードにコピーして使います．
使い方について詳細は https://github.com/YujiToshinaga/RPi64Toppers を参照してください．
