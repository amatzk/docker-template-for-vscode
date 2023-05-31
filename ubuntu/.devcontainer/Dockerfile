# written by amatzk

# docker hub の ubuntu (docker 公式) イメージを指定
# rolling = 最新のリリース
# latest = 最新のLTS
# FROM - https://docs.docker.jp/engine/reference/builder.html#from
# ubuntu:rolling - https://hub.docker.com/_/ubuntu
FROM ubuntu:rolling

# SHELL - https://docs.docker.jp/engine/reference/builder.html#shell
# BuildにBashを使う
# /bin/bash     使用するbash
#  -c           文字列をコマンドとして実行
SHELL ["/bin/bash", "-c"]

# RUN - https://docs.docker.jp/engine/reference/builder.html#run
# パッケージの更新とインストール
# apt-get update                  更新を取得
# apt-get install -y <packages>   パッケージをインストール ここで必要なパッケージを指定
# apt-get clean                   aptキャッシュをクリーン
# rm -rf /var/lib/apt/lists/*     キャッシュされている全パッケージリストを削除
# https://docs.docker.jp/engine/articles/dockerfile_best-practice.html
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ARG - https://docs.docker.jp/engine/reference/builder.html#arg
# ユーザー名、ユーザID、グループIDの変数
ARG USERNAME=vscode
ARG USER_ID=1000
ARG GROUP_ID=$USER_ID
# 1. groupadd --gid $GROUP_ID $USERNAME
#  * 新しいグループを作成
#  * groupadd <オプション> <グループ名>
#     -g           : グループIDを$GROUP_IDに指定
# 2. useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID -G sudo $USERNAME
#  * 新しいユーザーを作成
#  * useradd <オプション> <ユーザー名>
#     -m           : ホームディレクトリを作成
#     -s /bin/bash : ログインシェルに/bin/bashを設定
#     -u $USER_ID  : ユーザーIDを$USER_IDに設定
#     -g $GROUP_ID : プライマリグループIDを$GROUP_IDに設定
#     -G sudo      : セカンダリグループにsudoを追加
# 3. echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
#  * /etc/sudoers.d/$USERNAMEファイルに、新しいユーザーがパスワード入力なしで
#    sudoを実行できるようにする設定を追加
# 4. chmod 0440 /etc/sudoers.d/$USERNAME
#  * /etc/sudoers.d/$USERNAMEファイルのパーミッションを0440に設定し、書き込み権限を制限
#    設定ファイルが誤って変更されるのを防ぐ
RUN groupadd --gid $GROUP_ID $USERNAME && \
    useradd -m -s /bin/bash -u $USER_ID -g $GROUP_ID -G sudo $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME
