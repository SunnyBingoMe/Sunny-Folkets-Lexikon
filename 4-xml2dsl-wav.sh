#!/bin/bash

if [ $# != 1 ]; then
	echo "ERR: need one parameter: wav or mp3"
	exit 1
fi
xsltproc -o tmp xml2dsl-$1_2012-02-29.xsl folkets_sv_en_public_2012-02-26_solved-amp.xml
echo -n -e \\xEF\\xBB\\xBF > Sunny-Folkets-Lexikon-sv_en-$1-BinSun.dsl
cat tmp >> Sunny-Folkets-sv_en-$1-BinSun.dsl
rm tmp

