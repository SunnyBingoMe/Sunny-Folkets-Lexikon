#!/bin/bash

if [ $# -gt 0 ]; then
	xsltproc -o tmp xml2dsl-wav_2012-02-29.xsl dict-example.xml
else 
	xsltproc -o tmp xml2dsl-wav_2012-02-29.xsl folkets_sv_en_public_2012-02-26.xml
fi
echo -n -e \\xEF\\xBB\\xBF > Sunny-Folkets-sv_en-by-BinSun.dsl
cat tmp >> Sunny-Folkets-sv_en-by-BinSun.dsl
rm tmp

