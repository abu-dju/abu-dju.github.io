#!/bin/bash
#######################################################################
#This program  is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program  is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with This program .  If not, see <http://www.gnu.org/licenses/>.
#
#
# This script is a quick and "dirty" way to reformat and convert the
#+ Salmone Arabic-English Lexicon to various dictionary formats.
#
# Copyright 2015 Abu Djuwairiyyah Karim Mohammad Karimou

FILENAME_XML=salmone-lexicon.xml

join_files(){
	cp -rfv ../salmone/usalmone.xml $FILENAME_XML
}

first_Cleanup(){
	perl -p -i -e \
		's|<entryFree.*?[^<\n\r]>|\n\n_____\n\n|g; \
		s|<text lang="en">||g; \
		s|<body>||g; \
		s|<\?xml version="1.0" encoding="utf-8"\?><TEI.2>||g; \
		s|<teiHeader status="new" type="text">||g; \
		s|<fileDesc>||g; \
		s|<titleStmt>||g; \
		s|<title>||g; \
		s|</authority>||g;
		s|</monogr>||g;
		s|</entryFree>||g;
		s|</colloc>||g;
		s|<gram.*?[^<\n\r]>||g;
		s|</title>||g; \
		s|<title type="sub">||g; \
		s|<author>||g; \
		s|<funder n="org:NSF">||g; \
		s|</author>||g; \
		s|</funder>||g; \
		s|</titleStmt>||g; \
		s|<publicationStmt>||g; \
		s|<publisher>||g; \
		s|</publisher>||g; \
		s|<pubPlace>||g; \
		s|</pubPlace>||g; \
		s|<authority>||g; \
		s|</publicationStmt>||g; \
		s|<sourceDesc>||g; \
		s|<biblStruct>||g; \
		s|<monogr>||g; \
		s|<imprint>||g; \
		s|<date>||g; \
		s|</date>||g; \
		s|</imprint>||g; \
		s|<idno type="ISBN">|ISBN: |g; \
		s|</idno>||g; \
		s|</biblStruct>||g; \
		s|</sourceDesc>||g; \
		s|</fileDesc>||g; \
		s|<encodingDesc>||g; \
		s|<refsDecl doctype="TEI.2">||g; \
		s|<state unit="entry"/>||g; \
		s|</refsDecl>||g; \
		s|<state unit="alphabetic letter"/>||g; \
		s|<state n="chunk" unit="root"/>||g; \
		s|</encodingDesc>||g; \
		s|<profileDesc>||g; \
		s|<langUsage>||g; \
		s|<language id="[a-z]+">||g; \
		s|</language>||g; \
		s|</langUsage>||g; \
		s|</profileDesc>||g; \
		s|<revisionDesc>||g; \
		s|<change>||g; \
		s|<respStmt>||g; \
		s|<name>||g; \
		s|</name>||g; \
		s|<resp>||g; \
		s|</respStmt>||g; \
		s|</resp>||g; \
		s|<item>||g; \
		s|</item>||g; \
		s|</change>||g; \
		s|</revisionDesc>||g; \
		s|</teiHeader>||g; \
		s|<pb n="1"/>||g; \
		s|<div1 part="N" n="ا" org="uniform" sample="complete" type="alphabetic letter">||g; \
		s|<head lang="ar">ا</head>||g; \
		s|<div2 part="N" n="ا" org="uniform" sample="complete" type="root">||g; \
		s|</form>||g; \
		s|<form>||g; \
		s|<orth.*?[^<\n\r]>||g; \
		s|</orth>||g; \
		s|<sense.*?[^<\n\r]>||g; \
		s|</sense>||g; \
		s|<foreign.*?[^<\n\r]>||g; \
		s|</foreign>||g; \
		s|<dictScrap>||g; \
		s|</dictScrap>||g; \
		s|<def>||g; \
		s|</def>||g; \
		s|</div2>||g; \
		s|<div2.*?[^<\n\r]>||g; \
		s|<itype.*?[^<\n\r]>||g; \
		s|</itype>||g; \
		s|<mood>||g; \
		s|</mood>||g; \
		s|<form.*?[^<\n\r]>||g; \
		s|<number>||g; \
		s|</number>||g; \
		s|<gramGrp>||g; \
		s|</gramGrp>||g; \
		s|<lbl>||g; \
		s|</lbl>||g; \
		s|<subc>||g; \
		s|</subc>||g; \
		s|<usg>||g; \
		s|</usg>||g; \
		s|<xr>||g; \
		s|</xr>||g; \
		s|<ref.*?[^<\n\r]>||g; \
		s|</ref>||g; \
		s|<colloc>||g; \
		s|<pb.*?[^<\n\r]>||g; \
		s|<lang>||g; \
		s|</lang>||g; \
		s|<case>||g; \
		s|</case>||g; \
		s|<gen>||g; \
		s|</gen>||g; \
		s| <colloc.*?[^<\n\r]>||g; \
		s|</gram>||g; \
		s|<usg.*?[^<\n\r]>||g; \
		s|</div1>||g; \
		s|<div1.*?[^<\n\r]>||g; \
		s|<head.*?[^<\n\r]>||g; \
		s|</head>||g; \
		s|<hi.*?[^<\n\r]>||g; \
		s|</hi>||g; \
		s|</body>||g; \
		s|</text>||g; \
		s|</TEI.2>||g; \
		s|=| |g; \
		s|\r|\n|g; \
		s|\f|\n|g; \
		s|\n\n\n|\n|g; \
		s|\n\n|\n|g; \
		s|_____|\n\n\n_____\n|g; \
		s|^\s+||g;' $FILENAME_XML		
		#editpadpro7 $FILENAME_XML
}

2_convert2_dictd_and_mix_tashkeel_and_tasheel_less_dicts(){
	# this will enable us to search for tashkeel-less words
	dictfmt --utf8 -u dfmcreator@gmail.com -s "Salmone Arabic-English Lexicon" \
	-c5 salmone-lexicon-no-tashkeel < $FILENAME_XML
	# delete inconsistencies from index file
	sed -e '1,1390d' -i salmone-lexicon-no-tashkeel.index
	
	# this will enable us to search for words with tashkeel
	dictfmt --utf8 --allchars -u dfmcreator@gmail.com -s "Salmone Arabic-English Lexicon" \
	-c5 salmone-lexicon-tashkeel < $FILENAME_XML
	# delete inconsistencies from index file
	sed -e '1,1389d' -i salmone-lexicon-tashkeel.index
}

3_convert2CSVwithPYGLOSSARY(){
	python2.7 ../../deps/pyglossary/pyglossary.py salmone-lexicon-no-tashkeel.index salmone-lexicon-no-tashkeel.txt	
	python2.7 ../../deps/pyglossary/pyglossary.py salmone-lexicon-tashkeel.index salmone-lexicon-tashkeel.txt
	# Join the two files
	cat salmone-lexicon-no-tashkeel.txt salmone-lexicon-tashkeel.txt > salmone-lexicon.txt
	#editpadpro7 salmone-lexicon.txt
}

further_Cleanup(){
	perl -p -i -e \
		's|\\n| |g; \
		s|[ ]{2,}| |g;' salmone-lexicon.txt
}

convert_2_dictd(){
	python2.7 ../../deps/pyglossary/pyglossary.py salmone-lexicon.txt salmone-lexicon.index
}

cleanup(){
	rm -rfv $FILENAME_XML
	mkdir -p dictd-salmone_ara_eng-lexicon && \
	dictunzip salmone-lexicon.dict.dz
	mv -vf salmone-lexicon.dict salmone-lexicon.index dictd-salmone_ara_eng-lexicon/
	rm -rfv salmone-lexicon.txt salmone-lexicon-no-tashkeel.dict salmone-lexicon-no-tashkeel.index salmone-lexicon-no-tashkeel.txt salmone-lexicon-tashkeel.dict salmone-lexicon-tashkeel.index salmone-lexicon-tashkeel.txt
}

echo Stage 0 join_files
join_files

echo Stage 1 first_Cleanup
first_Cleanup

echo Stage 2 2_convert2_dictd_and_mix_tashkeel_and_tasheel_less_dicts
2_convert2_dictd_and_mix_tashkeel_and_tasheel_less_dicts

echo Stage 3 3_convert2CSVwithPYGLOSSARY
3_convert2CSVwithPYGLOSSARY

echo Stage 4 further_Cleanup
further_Cleanup

echo Stage 5 convert_2_dictd
convert_2_dictd

echo Stage 8 cleanup
cleanup

exit $?
