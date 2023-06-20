# DevContiner公式イメージ
# * Docker Hub | VS Code Remote : https://hub.docker.com/_/microsoft-vscode-devcontainers
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 最新の Clang/LLVM, CMake をインストール
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get upgrade -y \
    && apt-get -y install --no-install-recommends ca-certificates gpg wget lsb-release valgrind software-properties-common \
    && wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
    && bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" \
    && LLVM_VERSION=$(ls /usr/bin | grep -P '^clang-\d+$' | sort --version-sort | tail -1 | grep -o -P '\d+$') \
    && apt-get -y install cmake clang-format-$LLVM_VERSION clang-tidy-$LLVM_VERSION libc++-$LLVM_VERSION-dev \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-$LLVM_VERSION 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-$LLVM_VERSION 100 \
    && update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-$LLVM_VERSION 100 \
    && update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-$LLVM_VERSION 100 \
    && update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-$LLVM_VERSION 100 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# [Option] 他に必要なパッケージのインストール
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install <install packages>
#     && apt-get clean && rm -rf /var/lib/apt/lists/*
