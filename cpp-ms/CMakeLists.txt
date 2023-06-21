# CMakeの最小バージョンを指定 : CMake 3.20以上が必要
cmake_minimum_required(VERSION 3.20)

# プロジェクトの名前とバージョンを設定
project(myproject VERSION 1.0.0)

# C++の標準をC++17に設定
set(CMAKE_CXX_STANDARD 17)

# C++の標準を要求 : C++17がサポートされていないコンパイラではエラーが発生する
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# C++のコンパイラ固有の拡張を無効 : 標準C++のみが使用される
set(CMAKE_CXX_EXTENSIONS OFF)

# ビルドタイプが設定されていない場合、デフォルトのビルドタイプをDebugに設定
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "ビルドタイプを選択" FORCE)
endif()

# 現在のビルドタイプを表示
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# コンパイルオプションを追加
add_compile_options(-march=native -Wall -Wextra -pedantic -Wshadow)

# src/sample1ディレクトリをサブディレクトリとして追加 : このディレクトリには独自のCMakeLists.txtが必要
add_subdirectory(src/sample1)

# src/sample2ディレクトリをサブディレクトリとして追加 : このディレクトリには独自のCMakeLists.txtが必要
add_subdirectory(src/sample2)

# サブディレクトリの追加をした場合にやること
add_subdirectory(src/sample3)
# 1. サブディレクトリ内に"CMakeLists.txt"ファイルを用意する
#  1.1 add_executable(<プロジェクト名> <ソースファイル>)でコンパイル対象のファイルを指定
#
# 2. デバッグできるよう".vscode/launch.json"に、構成の追加
#  2.1 [変更箇所]の部分を変更すればとりあえず動く
#
# 3. 下部のCMake拡張機能のステータスバー"build"ボタンや
#    ctrl+shift+P でコマンドパレットで、CMake Build を選択してビルドする
#
# *. ディレクトリ内のファイル構成を変更した場合、buildディレクトリを削除して再構成する必要がある
#    ctrl+shift+P でコマンドパレットを開き、Task : Run Task [タスクの実行]を選択
#    .vscode/tasks.json 内に用意してある build タスクを実行すると
#    build ディレクトリの削除 -> cmakeの設定 -> ビルド の一連のタスクを実行する
