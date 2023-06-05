
## セットアップ

### Docker for Macのインストール

Dockerアプリをインストールします。

```
$ brew install --cask docker
...
Password: 
```

アプリのインストールとなるので、途中パスワードの入力が求められます。
インストールが終わったら起動して、バックグラウンドで動かしておきましょう。

### ホスト(Mac)側の設定

Mac側で動くX11アプリをHomebrewでインストールします。

```
$ brew install --cask xquartz
...
Password: 
```

アプリのインストールとなるので、途中パスワードの入力が求められます。

インストールが終了したら、一回、MacでQuartzを起動します。起動したら、以下の設定を行いましょう。

* XQuartzの環境設定を開く
* セキュリティ設定タブに移動する
* ネットワーク・クライアントからの接続を許可 にチェックを入れておく

ここまでできたら、一旦、XQuartzを再起動する。再度、立ち上がったら、XQuartzの画面で、
xtermというターミナルが開く。xterm上で、以下を設定

```
$ xhost +
```

Macのターミナル画面に戻り、自身のホスト名を環境変数に設定しておく。

```
$ export HOSTNAME=$(hostname)
```

ここまででホストの設定は終了。

## Docker-Composeでopencvインストール済みのコンテナを開く

Dockerイメージを起動して、opencvのスクリプトを動かします。

```
$ docker-compose up -d
...
[+] Running 2/2
 ✔ Network opencv-local_default  Created
 ✔ Container cv                  Started
```

初回にイメージビルドができていない時はイメージの作成から始めるので、時間がかかります。
その後は、数秒で起動するようになります。

```
$ docker exec -it cv /bin/bash
```

起動したubuntuのコンテナにアクセスして、以下を実行します。

```
root@20e3e201f755:~# python3 ./sample.py
```

うまくいけば、xwindowで、lenaの画像が表示されます。

## トラブルシューティング

毎回環境変数の設定が嫌な場合は、docker-compose.yamlのDISPLAY環境変数の設定を書き換えましょう。

```docker-compose.yaml
version: '3'
services:
  cv:
    image: ubuntu-opencv
    build: .
    container_name: cv
    entrypoint: ["/bin/tail", "-f", "/dev/null"]
    privileged: true
    environment:
      - DISPLAY=${HOSTNAME}:0 ## <= ${HOSTNAME}を自分のMacのホスト名、もしくはIPアドレスに直しましょう
      - QT_X11_NO_MITSHM=1
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw
      - ./sample/:/root/
```






