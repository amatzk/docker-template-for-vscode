#!/bin/bash
mamba update python -qy # Pythonを最新にアップデート
mamba install ruff -qy  # Ruffをインストール
mamba update -qy --all  # 全パッケージのアップデート
mamba clean -qafy       # キャッシュ等を削除
