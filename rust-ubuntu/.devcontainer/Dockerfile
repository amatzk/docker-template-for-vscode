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
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    gcc \
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

# USER - https://docs.docker.jp/engine/reference/builder.html#user
# コンテナ内で実行されるコマンドのユーザーを、指定された$USERNAMEに切り替え
USER $USERNAME
# WORKDIR - https://docs.docker.jp/engine/reference/builder.html#workdir
# コンテナ内のワーキングディレクトリを、指定されたユーザーのホームディレクトリ（/home/$USERNAME/）に設定
WORKDIR /home/$USERNAME/


# Rustのインストールスクリプトをダウンロードして実行
# https://forge.rust-lang.org/infra/other-installation-methods.html
#  * curl コマンドのオプション
#   * --proto '=https': 通信プロトコルをHTTPSに制限
#   * --tlsv1.2       : TLS v1.2を使用して通信
#   * -s              : サイレントモードで実行し、プログレスバーを非表示
#   * -S              : エラーが発生した場合にメッセージを表示
#   * -f              : サーバーがエラーを返した場合（404 Not Foundなど）に、処理を中止
#  * ダウンロードしたスクリプトはパイプでshコマンドに渡され実行
#  * sh コマンドのオプション
#   * -s: スクリプトを標準入力から読み込んで実行
#   * --: オプションの終わりを示します。以降の引数はオプションとして解釈されない
#   * -y: インストールプロセスでのプロンプトに自動で「yes」を回答し、インストールを進める
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
