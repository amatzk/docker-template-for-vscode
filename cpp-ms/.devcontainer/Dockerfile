# C++ - DevContiner公式イメージ
#
# * Docker Hub | VS Code Remote : https://hub.docker.com/_/microsoft-vscode-devcontainers
# * GitHub | vscode/devcontainer/cpp : https://github.com/microsoft/vscode-dev-containers/tree/main/containers/cpp
# * GitHub | devcontainer/cpp : https://github.com/devcontainers/images/tree/main/src/cpp
FROM mcr.microsoft.com/devcontainers/cpp:latest

# [オプション] 追加パッケージのインストール
#
# 使い方 :
#  * 「&& apt-get -y install --no-install-recommends \」
#    の後に、パッケージを追加
#
# デフォルト指定パッケージ :
#  * clang-foramt : コードフォーマット
#  * clang-tidy : Lint
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get upgrade -y \
    && apt-get -y install --no-install-recommends \
    clang-tidy \
    clang-format \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
