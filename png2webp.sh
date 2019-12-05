#!/usr/bin/bash

basedir=`cd $(dirname $0);pwd -P`

TYPE_PNG="png"
TYPE_NAMED=""

LOCAL_CWEBP_PATH="/usr/local/bin/cwebp"

echo $basedir

# 打印指令是否执行成功
printResult() {
	if [[ "$1" = "0" ]]; then
		echo -e "\033[32m 命令执行成功$2 \033[0m"
	else 
		echo -e "\033[31m 命令执行失败 \033[0m"
	fi
}

#png 转换为webp 
toWebp() {
	filePath=`echo $1 |sed 's/ /\ /g'`
	fileName=${filePath##*/}
	fileName=`echo $fileName|sed 's/ /_/g'`
	fileName=${fileName%.*}

	# 静默模式 转换时将不会打印转换日志
	if [[ -e $LOCAL_CWEBP_PATH  ]]; then
		echo "bendi"
		 cwebp -quiet "$filePath" -o $newFilePath$fileName.webp
	else  $basedir/bin/cwebp -quiet "$filePath" -o $newFilePath$fileName.webp
	fi

	#普通模式 转换指令，会逐一打印转换结果
	#$basedir/bin/cwebp "$filePath" -o $newFilePath$fileName.webp
	echo $filePath
	printResult $? "${filePath##*/} ☑ $newFilePath$fileName.webp"
}

# 判断文件夹是否存在，不存在则创建文件夹
createDir() {
	if [[ -d $1 ]]; then
		echo "文件夹已存在: $1"
	else 
		mkdir $1
		echo "文件夹创建成功: $1"
	fi
}

# 轮询文件夹中的文件 判断是否png格式
readDir(){
	for file in $1/*; do
		# 如果命令输入的是文件夹路径，则先创建文件夹
		if [[ -d $file ]]; then
			readDir $file
		fi
		# 判断命令输入的路径是否单个文件，如果是单个文件则进行转换操作
		if [[ "${file##*.}" = "$TYPE_PNG" ]]; then
			# 判断文件中是否包含关键字 如@3x
			if [[ "${file}" == *$TYPE_NAMED* ]]; then
				toWebp "${file}"
			else echo "未发现文件名中包含 ${TYPE_NAMED}的文件"
			fi
		else echo "${file##*.} hshsh  $TYPE_PNG"
		fi
	done
}

enterPath="$1"

main(){
	# 在macOs 10.15 系统开始对权限进行严格控制，导致./cwebp 指令授权无效，
	# 初步解决方案为：在macOs中 运行brew install webp 安装webp命令工具 
	# 正在努力寻找更合适的解决方案中
	# 判断webp 是否安装  --
	# if ! [ -x "$(command -v webp)" ]; then
	#   echo 'Error: webp is not installed.' >&2
	#   exit 1
	# fi
	# 判断文件路径是否存在
	chmod +x $basedir/bin/cwebp
	if [[ -e $1 ]]; then
		# 输入路径是否普通文件路径
		if [[ -f $1 ]]; then
			# 判断是否指定的格式 ，如png格式
			if [[ $1 == *$TYPE_PNG ]]; then
				# 截取输入的路径，从尾部截取/之前的地址，获得文件所在的文件夹地址
				newFilePath=`echo ${enterPath%/*}/`
				createDir "$newFilePath"
				toWebp "$1"
			else echo "输入的文件格式不是${TYPE_PNG}格式请重新检查"
			fi
		elif [[ -d "$1" ]]; then
			newFilePath=${enterPath}/webp/
			createDir "$newFilePath"
			readDir "$1"
		else echo "输入的文件地址无效，请检查输入的文件地址是否正确~~~"
		fi
		else echo "请输入需要转换的文件/文件夹地址\n"
	fi
}

main $1
