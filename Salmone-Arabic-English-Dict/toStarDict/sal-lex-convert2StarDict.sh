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
FILENAME_CSV=salmone-lexicon.csv

0_xml_merge(){
	cp -rfv ../salmone/usalmone.xml $FILENAME_XML
}

1_firstCleanup(){
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
		s|<dictScrap>|DICTSCRAPOPEN|g; \
		s|</dictScrap>|DICTSCRAPCLOSE|g; \
		s|<def>||g; \
		s|</def>||g; \
		s|</div2>||g; \
		s|<div2.*?[^<\n\r]>||g; \
		s|<itype.*?[^<\n\r]>|\nITYPEOPEN|g; \
		s|</itype>|\nITYPECLOSE|g; \
		s|<mood>|\nMOODOPEN|g; \
		s|</mood>|\nMOODCLOSE|g; \
		s|<form.*?[^<\n\r]>||g; \
		s|<number>|NUMBEROPEN|g; \
		s|</number>|NUMBERCLOSE|g; \
		s|<gramGrp>|GRAMGRPOPEN|g; \
		s|</gramGrp>|GRAMPGRPCLOSE|g; \
		s|<lbl>|LBLOPEN|g; \
		s|</lbl>|LBLCLOSE|g; \
		s|<subc>|SUBCOPEN|g; \
		s|</subc>|SUBCCLOSE|g; \
		s|<usg>||g; \
		s|</usg>||g; \
		s|<xr>|XROPEN|g; \
		s|</xr>|XRCLOSE|g; \
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

2_convert2_dictd(){
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
	cat salmone-lexicon-no-tashkeel.txt salmone-lexicon-tashkeel.txt > salmone-lexicon.csv
}

4_second_cleanup(){
	perl -p -i -e \
		's|\t|#####_____#####_____#####|g; \
		s|\\n|<br>|g; \
		s|<k>||g; \
		s|</k>||g; \
		s|moodopenn||g; \
		s|pmoodclose||g; \
		s|acmoodclose||g; \
		s|agmoodclose||g; \
		s|itypeopen[a-z]+?typeclose||g; \
		s|itypeopen||g; \
		s|<br>| |g;' $FILENAME_CSV
		#editpadpro7 $FILENAME_CSV
}

5_putSomeColors(){
	perl -p -i -e \
		's|DICTSCRAPOPEN||g; \
		s|DICTSCRAPCLOSE||g; \	
		s|ITYPEOPEN||g; \
		s|ITYPECLOSE||g; \
		s|MOODOPEN|<I><FONT COLOR="DarkGreen">|g; \
		s|MOODCLOSE|</FONT></I>|g; \
		s|NUMBEROPEN|<B>|g; \
		s|NUMBERCLOSE|</B>|g; \
		s|GRAMGRPOPEN||g; \
		s|GRAMPGRPCLOSE||g; \		
		s|LBLOPEN|<FONT COLOR="Purple">|g; \
		s|LBLCLOSE|</FONT>|g; \
		s|SUBCOPEN|<b><FONT COLOR="DarkMagenta">|g; \
		s|SUBCCLOSE|</FONT></b>|g; \
		s|XROPEN|<I><B><FONT COLOR="DarkSlateGray">|g; \
		s|XRCLOSE|</FONT></B></I>|g; \
		s|― - |―|g; \
		s#((―|-)*b[0-9]+(―|-)+)#<br><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g; \
		s#((―|-)*a[0-9]+(―|-)+)#<br><b><FONT COLOR="Teal">[$1]</FONT></b>#g; \
		s|[ ]{2,}| |g;' $FILENAME_CSV
}

#6_convert2STARDICTwithLINGUAE(){
#	dict=`readlink --no-newline --quiet --silent -f $FILENAME_CSV`
#
#	# Restore the tab Character
#	perl -p -i -e 's|#####_____#####_____#####|\t|g' $FILENAME_CSV
#	
#	python linguae/linguae.py "$dict"
#}

6_convert2STARDICTwith_tabfile(){
	dict=`readlink --no-newline --quiet --silent -f $FILENAME_CSV`

	# Restore the tab Character
	perl -p -i -e 's|#####_____#####_____#####|\t|g' $FILENAME_CSV

	# Convert to StarDict
	../../deps/tabfile "$dict"
}

clean_up(){
	echo "Will delete junk files in 10 seconds;"
	echo "interrupt the script if you want to keep them."

	sleep 10 && rm -rfv $FILENAME_XML salmone-lexicon-tashkeel.txt salmone-lexicon-no-tashkeel.txt salmone-lexicon-no-tashkeel.index salmone-lexicon-no-tashkeel.dict salmone-lexicon-tashkeel.index salmone-lexicon-tashkeel.dict stardict-salmone-lexicon-2.4.2
}

convert2otherFormats(){
	# Unzip dict
	dictunzip salmone-lexicon.dict.dz
	# Convert to xdxf
	../../deps/makedict -i stardict -o xdxf salmone-lexicon.ifo
	# Fix color problems
	./fix_xdxd_dicts_colors.sh salmone-lexicon/dict.xdxf
	# Prepare convertion to slob format (Aard2)
	source ../../deps/env-slob/bin/activate
	# cleanup
	rm -rfv salmone-lexicon.slob
	xdxf2slob -c lzma2 -o salmone-lexicon.slob -a abu-dju.github.io salmone-lexicon/dict.xdxf
	
	mkdir -p DIST StarDict-Salmone-Lexicon salmone-lexicon-slob CSV-Salmone-Lexicon
	mv -vf salmone-lexicon.idx salmone-lexicon.ifo salmone-lexicon.dict StarDict-Salmone-Lexicon/
	mv -vf salmone-lexicon salmone-lexicon-xdxf
	mv -vf salmone-lexicon.csv CSV-Salmone-Lexicon
	mv -vf salmone-lexicon.slob salmone-lexicon-slob
	mv -vf salmone-lexicon-slob salmone-lexicon-xdxf StarDict-Salmone-Lexicon CSV-Salmone-Lexicon DIST/
}

# Execute fonctions

echo Stage 0 0_xml_merge
0_xml_merge

echo Stage 1 1_firstCleanup
1_firstCleanup

echo Stage 2 2_convert2_dictd
2_convert2_dictd

echo Stage 3 3_convert2CSVwithPYGLOSSARY
3_convert2CSVwithPYGLOSSARY

echo Stage 4 4_second_cleanup
4_second_cleanup

echo Stage 5 5_putSomeColors
5_putSomeColors

echo Stage 6 6_convert2STARDICTwith_tabfile
6_convert2STARDICTwith_tabfile

echo Stage 11: Final: clean_up
clean_up

echo Stage 12: Converting to other formats
convert2otherFormats

exit $?
