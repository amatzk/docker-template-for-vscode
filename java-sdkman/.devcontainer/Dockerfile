# Debian - DevContiner公式イメージ
# * Docker Hub | VS Code Remote : https://hub.docker.com/_/microsoft-vscode-devcontainers
FROM mcr.microsoft.com/devcontainers/base:debian

# [オプション] 追加パッケージのインストール
#
# 使い方 :
#  * 「&& apt-get -y install --no-install-recommends <install packages>\」
#    のコメントアウトを外し、<install packages>の部分にパッケージを追加
#
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get upgrade -y \
    # && apt-get -y install --no-install-recommends <install packages>\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
