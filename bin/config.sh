#!/bin/bash
# ┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘
# config.sh
#       20250205 double_hood
# ┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘
# fatDirFinderの配置先を取得
BASE_DIR=$(dirname $0)
FDF_LOG_FILE=$(dirname $0)/log/fatDirFinder.log
# 結果の出力先データを蓄積するディレクトリを指定
# 初期値はbase_dir配下dataディレクトリ
OUTPUT_DIR="${BASE_DIR}/data"
# duを仕掛けるディレクトリを指定
TARG_DIR="/home/user/test"
# duを仕掛ける深さを指定
MAX_DEPTH="3"
