# GR-LYCHEE オフライン開発環境 Dockerfile
基本的に[公式情報](https://developer.mbed.org/users/dkato/notebook/offline-development-lychee-langja/)の手順通りです。デバッグ環境は含みません。

## コンテナのビルド

```
docker build -t lychee .
```
名前はご自由に。

## コンテナの起動
```
docker run --rm -it -v ~/projects:/mbed/projects lychee
```
volumeを使っているのでプロジェクトを格納するディレクトリを指定してください。
例では、ホームディレクトリあるprojectsを指定しています。

## 使い方
Lチカサンプルをコピーして使い回しても構わないのですが、プロジェクト毎にmbed-os等を持ってくるとディスクを喰うのでシンボリックリンクがオススメです。

1. Lチカサンプル
```
$ cd /mbed/projects
$ git clone https://github.com/d-kato/blinky-for-lychee
$ cd blinky-for-lychee
$ ln -s /mbed/blinky-for-lychee/mbed-os ./mbed-os
$ mbed compile -m GR_LYCHEE -t GCC_ARM --profile debug
```

2. カメラサンプル
```
$ cd /mbed/projects
$ git clone https://github.com/d-kato/GR-Boads_Camera_LCD_sample
$ cd GR-Boads_Camera_LCD_sample
$ touch .mbed
$ ln -s /mbed/blinky-for-lychee/mbed-os ./mbed-os
$ mbed add http://mbed.org/users/dkato/code/DisplayApp/
$ git clone https://github.com/d-kato/mbed-gr-libs
$ mbed compile -m GR_LYCHEE -t GCC_ARM --profile debug
```
※mbed-gr-libsやDisplayAppはサンプルに含まれないので取ってくる必要あり

3. 自作プロジェクトの場合
```
$ cd /mbed/projects
$ mkdir myproj
$ cd myproj
$ touch .mbed
$ ln -s /mbed/blinky-for-lychee/mbed-os ./mbed-os
$ git clone https://github.com/d-kato/mbed-gr-libs
main.cppにプログラム作成
$ mbed compile -m GR_LYCHEE -t GCC_ARM --profile debug
```

