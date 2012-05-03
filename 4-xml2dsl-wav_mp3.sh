#!/bin/bash
thisScriptFilename=`basename $0`
usage="Usage: ./$thisScriptFilename [-t mp3|wav|spx|mdict]. mp3 by default." 

	dbug=0
	dbugOk=0
	vbose=0
	function say(){
		echo $1
	}
	function debug(){
		if [ $dbug == 1 ] ; then
			echo $1
		fi
	}
	function debugOk(){
		if [ $dbugOk == 1 ] ; then
			echo $1
		fi
	}
	function verbose(){
		if [ $vbose == 1 ]; then
			echo $1
		fi
	}


	#char types
	function echoBold(){
		echo $2 -e "\033[1m$1\033[0m"
		tput sgr0
	}
	#colored char (with bold, with bg). 47: white bg 
	function echoRedAndWhite(){
		echo $2 -e '\E[47;31m'"\033[1m$1\033[0m" #31: red char
		tput sgr0
	}
	function echoGreenAndWhite(){
		echo $2 -e '\E[47;32m'"\033[1m$1\033[0m" # 32: green char
		tput sgr0
	}
	#colored char (with bold)
	function echoRed(){
		echo $2 -e "\E[33;31m""\033[1m$1\033[0m" # 31: red char
		tput sgr0
	}
	function echoGreen(){
		echo $2 -e "\E[33;32m""\033[1m$1\033[0m" # 32: green char
		tput sgr0
	}
	function echoYellow(){
		echo $2 -e "\E[33;33m""\033[1m$1\033[0m" # 33: yellow char
		tput sgr0
	}
	function echoBlue(){
		echo $2 -e "\E[33;34m""\033[1m$1\033[0m" # 34: blue char
		tput sgr0
	}


opcode=
mediaType=mp3
directory=.
vbose=0
if $(test $# -gt 0);then 
	debugOk "$# greater than 0"
	i=1
	for tmp in $@; do 
		parameterList[$i]=$tmp
		i=`expr $i + 1`
	done 
	for tParameterIndex in $(seq 1 $#) ; do
		tParameter=${parameterList[$tParameterIndex]}
		debugOk "tParameter is '$tParameter'."
		if [ ${#tParameter} == 2 ] ; then 
			tParameterIndexNext=`expr $tParameterIndex + 1`
			debugOk "tParameterIndexNext=$tParameterIndexNext"
			tParameterNext=${parameterList[$tParameterIndexNext]}
			debugOk "tParameterNext=$tParameterNext."
			parameterList[`expr $tParameterIndex+1`]=$(printf "%s%s" $tParameter $tParameterNext)
			continue
		fi 
		opcode=${tParameter:0:2}
		case $opcode in
			-d )
				directory=${tParameter#-d}
				directory=${directory%/}
				if [ ! -d $directory ];then
					echoRedAndWhite "ERR: directory '$directory' does not exit."
					exit 1
				fi 
				;; 
			-t )
			mediaType=${tParameter#-t}
			case $mediaType in 
				mp3 )
					;;
				wav )
					;;
				mdict )
					;;
				spx )
					mediaType=mdict
					;;
				*)
					say "ERR: unknow media type: $mediaType."
					exit 1
			esac 
			;; 
			-v )
				vbose=1 
				;;
			-h )
				say "$usage."
				;;
			*)
				say "ERR: unknown option: $opcode."
				say "$usage."
				exit 1
		esac 
	done
else 
	say "using default type: mp3."
fi 
say "mediaType = $mediaType."
dslFileName="Sunny-Folkets-Lexikon-sv_en-$mediaType-BinSun.dsl"
echo -n -e \\xEF\\xBB\\xBF > $dslFileName
if [ $mediaType == mp3 ] ; then
	mediaType=MP3
fi 
xsltproc --stringparam type $mediaType xml2dsl_2012-02-29.xsl folkets_sv_en_public_2012-02-26_solved-amp.xml >> $dslFileName

