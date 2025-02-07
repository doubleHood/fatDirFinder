#!/bin/bash
# ┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘
# fatDirFinder.sh
#                    20250205 double_hood
# ┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘
# コンフィグ読み込み,コンフィグ内容を出力
source $(dirname $0)/bin/config.sh
echo "$(date +%Y/%m/%d-%T) [INFO] fatDirFinder is Started" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] BASE_DIR: ${BASE_DIR}" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] OUTPUT_DIR: ${OUTPUT_DIR}" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] TARG_DIR: ${TARG_DIR}" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] MAX_DEPTH: ${MAX_DEPTH}" >> ${FDF_LOG_FILE}


# 設定したディレクトリおよび深さにduしテンポラリファイル作成
echo "$(date +%Y/%m/%d-%T) [INFO] du start" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] command du ${TARG_DIR} --max-depth ${MAX_DEPTH} > ${OUTPUT_DIR}/temp_$(date -I).tsv" >> ${FDF_LOG_FILE}
du -m ${TARG_DIR} --max-depth ${MAX_DEPTH} > ${OUTPUT_DIR}/temp_$(date -I).tsv
echo "$(date +%Y/%m/%d-%T) [INFO] du is completed" >> ${FDF_LOG_FILE}

# 出力したdu結果をサイズ\tパスからパス\tサイズに入れ替えてソートし主キーに
# 念のためduの"/./"を"/"に変換してゴミ掃除
# 結果を${OUTPUT_DIR}配下へ
echo "$(date +%Y/%m/%d-%T) [INFO] making result file..." >> ${FDF_LOG_FILE}
cat ${OUTPUT_DIR}/temp_$(date -I).tsv \
 | sed 's/\(.*\)\t\(.*\)/\2\t\1/g' \
 | sed 's@\/\.@@g' \
 | sort > ${OUTPUT_DIR}/result_$(date -I).tsv
echo "$(date +%Y/%m/%d-%T) [INFO] making result is completed" >> ${FDF_LOG_FILE}
echo "$(date +%Y/%m/%d-%T) [INFO] result file is here -> ${OUTPUT_DIR}/result_$(date -I).tsv" >> ${FDF_LOG_FILE}

# 引数指定がある場合、直前実行分と自動差分取得
if [ "$2" = "autoDiff" ]; then
	# 前回実施のファイルを探索
	echo "$(date +%Y/%m/%d-%T) [INFO] finding last time result..." >> ${FDF_LOG_FILE}
	LAST_TIME_RESULT=$(ls -t ${OUTPUT_DIR} | grep -v total | grep -v $(date -I) | grep -v '^\s*$' | grep result | head -1)
	if [ -n LAST_TIME_RESULT ]; then
		echo "$(date +%Y/%m/%d-%T) [INFO] last time result is here! -> ${LAST_TIME_RESULT}" >> ${FDF_LOG_FILE}
		echo -e "path\tresult_$(date -I).tsv\t${LAST_TIME_RESULT}" > ${OUTPUT_DIR}/AutoDiff_$(date -I).tsv
		join -t "$(printf '\011')" \
		-1 1 -2 1 \
		-a 1 -a 2 \
		-o 0 1.2 2.2 \
		-e 'NULL' \
		${OUTPUT_DIR}/result_$(date -I).tsv ${OUTPUT_DIR}/${LAST_TIME_RESULT} >> ${OUTPUT_DIR}/AutoDiff_$(date -I).tsv
		echo "$(date +%Y/%m/%d-%T) [INFO] AutoDiff is ready" >> ${FDF_LOG_FILE}
	else
		echo "$(date +%Y/%m/%d-%T) [WARN] cannot found last time result" >> ${FDF_LOG_FILE}
	fi
fi

# tempファイルの削除
echo "$(date +%Y/%m/%d-%T) [INFO] remove temp file" >> ${FDF_LOG_FILE}
rm ${OUTPUT_DIR}/temp_$(date -I).tsv

echo "$(date +%Y/%m/%d-%T) [INFO] Finish!" >> ${FDF_LOG_FILE}
