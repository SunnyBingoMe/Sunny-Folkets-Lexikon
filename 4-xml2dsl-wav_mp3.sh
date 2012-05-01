#!/bin/bash

if [ $# != 1 ]; then
	echo "ERR: need one parameter: wav or mp3"
	exit 1
fi
echo -n -e \\xEF\\xBB\\xBF > Sunny-Folkets-Lexikon-sv_en-$1-BinSun.dsl
xsltproc xml2dsl-$1_2012-02-29.xsl folkets_sv_en_public_2012-02-26_solved-amp.xml >> Sunny-Folkets-Lexikon-sv_en-$1-BinSun.dsl

