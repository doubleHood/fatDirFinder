┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘
## README.md
###                   20250205 double_hood
┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘┘

---------------------------------------
## How to use?
---------------------------------------
### 0.シンボリックリンクの作成
```
cd [install_dir]
ln -s ../fatDirFinder/bin/fatDirFinder.sh boot_fatDirFinder.sh
```

### 1.実行
```
bash [install_dir]/fatDirFinder/boot_fatDirFinder.sh
[実行例:/home/user配下に配置している場合]
 bash /home/user/fatDirFinder/boot_fatDirFinder.sh
```

### 2.差分を取る
 * fatDirFinder/data配下にtsvが蓄積していくため、Excel等で差分が取れます

### Ex.自動で差分を取得させる
 * boot_fatDirFinder.sh打鍵時に"autoDiff"を引数として渡しておくと、
  * 自動でデータ蓄積先ディレクトリに前回実行時との差分を出力します
```
[実行例] bash /home/user/fatDirFinder/boot_fatDirFinder.sh autoDiff
```

---------------------------------------
## fatDirFinderの構造
---------------------------------------

```
/fatDirFinder
	|-- /bin	:シェルディレクトリ
	|	|-- /config.sh	:コンフィグ用シェル-設定変更はココで
	|	 `-- /fatDirFinder.sh	:本体
	|-- /data	:デフォルトデータ蓄積先ディレクトリ
	|-- /log	:シェルログ蓄積先ディレクトリ
	|-- /boot_fatDirFinder.sh > ../fatDirFinder/bin/fatDirFinder.sh	:起動用シンボリックリンク
	`-- /README.txt
```

---------------------------------------
