# docker-template-for-vscode

## devcontainer.json の構成例

```json
// devcontainer.json リファレンス
// https://containers.dev/implementors/json_reference/
{
    // UIに表示されるDevContainer名
    "name": "ubuntu-container",
    "build": {
        "dockerfile": "Dockerfile"
    },
	// Dockerイメージの指定（Dockerfileを指定しない場合）
    // 
    // 次の３つのコンテナレジストリをサポート
    // 1. DockerHub (https://hub.docker.com)
    // 2. GitHub Container Registry (https://docs.github.com/ja/packages/learn-github-packages/introduction-to-github-packages)
    // 3. Azure Container Registry (https://azure.microsoft.com/ja-jp/products/container-registry)
	//
	// ex) Microsoft DevContainer: Ubuntu 最新
	// "image": "mcr.microsoft.com/vscode/devcontainers/base:ubuntu",
    "customizations": {
        // VSCodeや拡張機能の設定
        "vscode": {
            // 設定（コンテナ内全体で有効）
            "settings": {
                // ここに設定を記述
            },
            // 拡張機能（コンテナ内全体で有効）
            "extensions": [
                // 欲しい拡張機能IDを記述
            ]
        }
    },
    // コンテナ内で実行するユーザーを上書き
    "remoteUser": "vscode",
    // Features
    // ツール、ランタイム、ライブラリの「機能」を開発コンテナに迅速かつ簡単に追加し、自分や共同作業者が使用できるようにする「機能」
    // 公開 Features 一覧：https://containers.dev/features
    "features": {
        // Git
        // https://github.com/devcontainers/features/tree/main/src/git
        "ghcr.io/devcontainers/features/git:1": {
            "version": "latest",
            "ppa": true
        }
    },
    // ランタイム引数
    "runArgs": [
        // 開発コンテナ内のプロセスが、ptraceシステムコールを使用して
		// 他のプロセスをトレースすることができるようにするための設定
        // デバッガなどのツールが正常に動作するために必要な場合がある
        "--cap-add=SYS_PTRACE",
        // 開発コンテナ内のプロセスが、seccompフィルターによる制限を受けずに実行されるようにするための設定
        // 特定のシステムコールが必要な場合や、デバッグ目的で使用される
        "--security-opt",
        "seccomp=unconfined"
    ],
    // ポートフォワード
    "forwardPorts": [
        // 8080
    ]
    // ワークスペースの設定
    // 開発コンテナ内で使用するワークスペースのパスを指定する
    // デフォルトは /workspace/ 配下
    // Dockerfileに指定したRustは、コンテナ内の/home/vscode配下にある
    // "workspaceFolder": "/home/vscode",
}
```

## Requirements (必要なもの)

- Visual Studio Code
    - Dev Containers
- Docker

## DevContainer 一覧

### ubuntu

Ubuntu に Git を入れただけ

- docker image
	- ubuntu : rolling (latest release)
- Installed Tools
	- Git  (latest release)
- VSCode Extentions
	- None

### rust-ubuntu

OS が Ubuntu の Rust 開発環境

- docker image
	- ubuntu : rolling (latest release)
- Installed Tools
	- Git  (latest release)
	- Rust (Profile: default)
- VSCode Extentions
	- [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
	- [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
	- [crates](https://marketplace.visualstudio.com/items?itemName=serayuzgur.crates)
	- [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)

### rust-ms

Microsoft が用意している [Rust 開発環境](https://github.com/devcontainers/images/blob/main/src/rust/history/dev.md)

- docker image
	- debian (latest release)
- Installed Tools
	- Git  (latest release)
	- Rust (Profile: default)
	- Zsh
- VSCode Extentions
	- [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer)
	- [Even Better TOML](https://marketplace.visualstudio.com/items?itemName=tamasfe.even-better-toml)
	- [crates](https://marketplace.visualstudio.com/items?itemName=serayuzgur.crates)
	- [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb)

### python-mamba

Microsoft の [Debianイメージ](https://github.com/devcontainers/images/blob/main/src/base-debian/history/dev.md)に [Manbaforge](https://github.com/rocker-org/devcontainer-features/tree/main/src/miniforge) を入れた Python 開発環境

- docker image
	- debian (latest release)
- Installed Tools
	- Git  (latest release)
	- Mambaforge
- VSCode Extentions
	- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
	- [Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)
	- [Python Indent](https://marketplace.visualstudio.com/items?itemName=KevinRose.vsc-python-indent)
	- [autoDocstring - Python Docstring Generator](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring)
    - [Black Formatter](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)
    - [Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)

#### setup.sh (mamba のセットアップ)

```bash
#!/bin/bash
mamba update python -qy # Pythonを最新にアップデート
mamba install ruff -qy  # Ruffをインストール
mamba update -qy --all  # 全パッケージのアップデート
mamba clean -qafy       # キャッシュ等を削除
```

他にパッケージをインストールしたければ、`mamba install ruff -qy`のところに追加してください


## Reference

- [Dev Container metadata reference](https://containers.dev/implementors/json_reference/)
- [devcontainer.json Reference](https://containers.dev/implementors/json_reference/)
- [Docker extension for Visual Studio Code](https://code.visualstudio.com/docs/containers/overview)
- [ubuntu - Official Image | Docker Hub](https://hub.docker.com/_/ubuntu)
