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
		's|^\s+||g; \
		s|<entryFree|\n\n_____\n\n<entryFree|g; \
		s|<itype>[0-9]+</itype>||g; \
		s|<itype>.*?</itype>||g; \
		s|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g; \
		s|</orth>|\n</orth>|g; \
		s|<|LESSTHAN|g; \
		s|>|GREATERTHAN|g; \
		s|"|QUOTEQUOTE|g; \
		s|=|SIGNEEGAL|g;' $FILENAME_XML
}

2_convert2_dictd(){
	dictfmt --utf8 -u dfmcreator@gmail.com -s "Salmone Arabic-English Lexicon" -c5 salmone-lexicon < $FILENAME_XML
}

3_convert2STARDICTwithMAKEDICT(){
	./makedict -i dictd -o stardict salmone-lexicon.index
}

#4_convert2CSVwithLINGUAE(){
#	dict=`readlink --no-newline --quiet --silent -f stardict-salmone-lexicon-2.4.2/salmone-lexicon.dict`
#	python linguae/linguae.py "$dict"
#}

4_convert2CSVwith_stardict2txt(){
	dict=`readlink --no-newline --quiet --silent -f stardict-salmone-lexicon-2.4.2/salmone-lexicon.ifo`
	./stardict2txt "$dict" $FILENAME_CSV
	
	# Backup tab characters
	perl -p -i -e \
		's|\t|#####_____#####_____#####|g; \
		s|\\n|<br>|g; \
		s|<k>||g; \
		s|</k>||g;' $FILENAME_CSV
}

5_secondCleanup(){
	perl -p -i -e \
		's|LESSTHAN|<|g; \
		s|GREATERTHAN|>|g; \
		s|QUOTEQUOTE|"|g; \
		s|SIGNEEGAL|=|g; \
		s|<br>| |g; \
		s|keysigneegalquotequoteاquotequote[0-9]+typesigneegalquotequotemainquotequotegreaterthan||g; \
		s|typesigneegalquotequotemainquotequotegreaterthan||g; \
		s|idsigneegalquotequoten[0-9]+quotequote||g; \
		s|idsigneegalquotequoten[0-9]+quotequote||g; \
		s|typesigneegalmaingreaterthan||g; \
		s|keysigneegalquotequote||g; \
		s|lessthanentryfree||g; \
		s|typesigneegalmain||g; \
		s|greaterthan||g; \
		s|quotequote||g; \
		s|[a-z]+?="[a-z]+?\s*[a-z]*?"||g; \
		s|n="*"||g; \
		s|[a-z]+?="[a-z]*?[0-9]+?"||g; \
		s|<entryFree\s*?[a-z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g; \
		s|<entryFree\s*?[a-z]+?="(.+?)"\s*?>|<entryFree>$1|g; \
		s|<form\W+?>|<form>|g; \
		s|<head\W+?>|<head>|g; \
		s|<foreign\W+?>|<foreign>|g; \
		s|<hi\W+?>|<hi>|g; \
		s|<orth\W+?[a-z]+?=""\s*>|<orth>|g; \
		s|<orth\W+?>|<orth>|g; \
		s|<itype>[0-9]+</itype>||g; \
		s|<itype>.*?</itype>||g; \
		s|(\s+\s+)+| |g; \
		s|^\s+||g;'  $FILENAME_CSV
		#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|$1\t|g' $FILENAME_CSV
}

6_thirdCleanup(){
	perl -p -i -e \
		's|<analytic/>||g; \
		s|</author>||g; \
		s|<author>||g; \
		s|</authority>||g; \
		s|<authority>||g; \
		s|</availability>||g; \
		s|<availability >||g; \
		s|</biblStruct>||g; \
		s|<biblStruct>||g; \
		s|</body>||g; \
		s|<body>||g; \
		s|</cell>||g; \
		s|<cell >||g; \
		s|</date>||g; \
		s|<date>||g; \
		s|</div1>||g; \
		s|<div1||g; \
		s|</div2>||g; \
		s|<div2 >||g; \
		s|encoding="UTF-8"\?>||g; \
		s|</fileDesc>||g; \
		s|<fileDesc>||g; \
		s|<foreign>|FOREIGNOPEN|g; \
		s|</foreign>|FOREIGNCLOSE|g; \
		s|</dictScrap>|DICTSCRAPCLOSE|g; \
		s|<dictScrap>|DICTSCRAPOPEN|g; \
		s|</form>|FORMCLOSE|g; \
		s|<form>|FORMOPEN|g; \
		s|</orth>|ORTHCLOSE|g; \
		s|<orth>|ORTHOPEN|g; \
		s|</G>|GCLOSE|g; \
		s|<G/>|GCLOSE|g; \
		s|<G>|GOPEN|g; \
		s|<H>165</H>||g; \
		s|</head>|HEADCLOSE|g; \
		s|<head>|HEADOPEN|g; \
		s|</hi>|HICLOSE|g; \
		s|<hi>|HIOPEN|g; \
		s|</itype>|ITYPECLOSE|g; \
		s|<itype>|ITYPEOPEN|g; \
		s|</quote>|QUOTECLOSE|g; \
		s|<quote>|QUOTEOPEN|g; \
		s|</sense>|SENSECLOSE|g; \
		s|<sense>|SENSEOPEN|g; \
		s|</H>||g; \
		s|<H/>||g; \
		s|</imprint>||g; \
		s|<imprint>||g; \
		s|</item> | |g; \
		s|<item>| |g; \
		s|</listBibl>| |g; \
		s|<listBibl>| |g; \
		s|</list>| |g; \
		s|<list>| |g; \
		s|</L>|LCLOSE|g; \
		s|<L>|LOPEN|g; \
		s|</monogr>| |g; \
		s|<monogr>| |g; \
		s|</note>| |g; \
		s|<note >| |g; \
		s|</notesStmt>| |g; \
		s|<notesStmt>| |g; \
		s|<pb>||g; \
		s|<pb >||g; \
		s|<pb />||g; \
		s|<pb/>||g; \
		s|</p>||g; \
		s|<p>||g; \
		s|</publicationStmt>||g; \
		s|<publicationStmt>||g; \
		s|</publisher>||g; \
		s|<publisher>||g; \
		s|</pubPlace>||g; \
		s|<pubPlace>||g; \
		s|</row>||g; \
		s|<row >||g; \
		s|</sourceDesc>||g; \
		s|<sourceDesc>||g; \
		s|</Table>||g; \
		s|<Table>||g; \
		s|</TEI.2>||g; \
		s|<TEI.2>||g; \
		s|</teiHeader>||g; \
		s|<teiHeader >||g; \
		s|</text>||g; \
		s|</text>||g; \
		s|<text>||g; \
		s|</title>||g; \
		s|<title>||g; \
		s|</titleStmt>||g; \
		s|<titleStmt>||g; \
		s|<?xml version="1.0"||g; \
		s|<entryFree>||g; \
		s|</entryFree>||g; \
		s|DICTSCRAPCLOSE||g; \
		s|DICTSCRAPOPEN||g; \
		s|GCLOSE||g; \
		s|GOPEN||g; \
		s|&amp;|\&|g; \
		s|amp;|\&|g; \
		s|&gt;|>|g; \
		s|&lt;|<|g; \
		s|&quot;|"|g; \
		s|&&|\&|g;' $FILENAME_CSV
}

7_putSomeColors(){
	perl -p -i -e \
		's|FOREIGNOPEN|<b><FONT COLOR="DarkGreen">|g; \
		s|FOREIGNCLOSE|</FONT></b>|g; \
		s|HEADOPEN|<i><FONT COLOR="MediumBlue">|g; \
		s|HEADCLOSE|</FONT></i>|g; \
		s|SENSEOPEN|<b><FONT COLOR="DarkGray">|g; \
		s|SENSECLOSE|</FONT></b>|g; \
		s|QUOTEOPEN|<I>|g; \
		s|QUOTECLOSE|</I>|g; \
		s|HIOPEN|<i><b><FONT COLOR="Black">|g; \
		s|HICLOSE|</FONT></b></i>|g; \
		s|ORTHOPEN|<b><FONT COLOR="DarkMagenta">|g; \
		s|ORTHCLOSE|</FONT></b>|g; \
		s|ITYPEOPEN|<FONT COLOR="DarkOliveGreen">|g; \
		s|ITYPECLOSE|</FONT>|g; \
		s|LOPEN|<FONT COLOR="DarkSlateGray">|g; \
		s|LCLOSE|</FONT>|g; \
		s|FORMCLOSE|</FONT>|g; \
		s|FORMOPEN|<FONT COLOR="Indigo">|g; \
		s|HEADOPEN|<FONT COLOR="SaddleBrown">|g; \
		s|HEADCLOSE|</FONT>|g; \
		s|<FONT| <FONT|g; \
		s|[ ]{3,}| |g; \
		s|[ ]{2,}| |g;' $FILENAME_CSV
}

8_putSomeMoreColors(){
	perl -p -i -e \
		's|― - |―|g; \
		s#((―|-)*b[0-9]+(―|-)+)#<br><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g; \
		s#((―|-)*a[0-9]+(―|-)+)#<br><b><FONT COLOR="Teal">[$1]</FONT></b>#g; \
		s|(\(+.+?\)+)|<FONT COLOR="DarkGoldenRod">$1</FONT>|g; \
		s|\W+">|">|g; \
		s|&amp,amp,|\&|g; \
		s|&amp;|\&|g; \
		s|&amp|\&|g; \
		s|<case>|<b>|g; \
		s|</case>|</b>|g; \
		s|<colloc>|<i>|g; \
		s|</colloc>|<i>|g; \
		s|<def>||g; \
		s|</def>||g; \
		s|<gramGrp>||g; \
		s|</gramGrp>||g; \
		s|<lbl>|<FONT COLOR="Purple">|g; \
		s|</lbl>|</FONT>|g; \
		s|<mood>|<b><FONT COLOR="DarkGray">|g; \
		s|</mood>|</FONT></b>|g; \
		s|<number>|<b>|g; \
		s|</number>|</b>|g; \
		s|<subc>|<i>|g; \
		s|</subc>|</i>|g; \
		s|<usg>||g; \
		s|</usg>||g; \
		s|<xr>||g; \
		s|</xr>||g; \
		s|^\s+||g; \
		s|  +| |g; \
		s|<sense >||g;' $FILENAME_CSV
}

9_convert2STARDICTwithLINGUAE(){
	dict=`readlink --no-newline --quiet --silent -f $FILENAME_CSV`

	# Restore the tab Character
	perl -p -i -e 's|#####_____#####_____#####|\t|g' $FILENAME_CSV
	
	python linguae/linguae.py "$dict"
}

10_convert2STARDICTwith_tabfile(){
	dict=`readlink --no-newline --quiet --silent -f $FILENAME_CSV`

	# Restore the tab Character
	perl -p -i -e 's|#####_____#####_____#####|\t|g' $FILENAME_CSV
	
	perl -p -i -e  \
	   's|&lt;|<|g; \
		s|&gt;|>|g; \
		s|&quot;|"|g; \
		s|&amp;|\&|g; \
		s|&lt,|<|g; \
		s|&gt,|>|g; \
		s|&quot,|"|g; \
		s|&amp,|\&|g; \
		s|&lt|<|g; \
		s|&gt|>|g; \
		s|&quot|"|g; \
		s|&amp|\&|g;' $FILENAME_CSV

	perl -p -i -e \
	   's|<FONT COLOR="DarkGoldenRod">|<c c="#B8860B">|g; \
		s|<FONT COLOR="DarkGray">|<c c="#A9A9A9>|g; \
		s|<FONT COLOR="DarkGreen">|<c c="#006400>|g; \
		s|<FONT COLOR="DarkMagenta">|<c c="#8B008B">|g; \
		s|<FONT COLOR="DarkOliveGreen">|<c c="#556B2F">|g; \
		s|<FONT COLOR="DarkRed">|<c c="#8B0000">|g; \
		s|<FONT COLOR="DarkSlateGray">|<c c="#2F4F4F">|g; \
		s|<FONT COLOR="Indigo">|<c c="#4B0082">|g; \
		s|<FONT COLOR="MediumBlue">|<c c="#0000CD">|g; \
		s|<FONT COLOR="SaddleBrown">|<c c="#8B4513">|g; \
		s|<FONT COLOR="Teal">|<c c="#008080">|g; \
		s|</FONT>|</c>|g; \
		s|<FONT COLOR="Black">|<c c="#000000">|g;' $FILENAME_CSV

	# Convert to StarDict
	./tabfile "$dict"
}

clean_up(){
	echo "Will delete junk files in 10 seconds;"
	echo "interrupt the script if you want to keep them."

	sleep 10 && rm -rfv $FILENAME_XML salmone-lexicon.dict salmone-lexicon.index stardict-salmone-lexicon-2.4.2
}

# Execute fonctions

echo Stage 0 0_xml_merge
0_xml_merge

echo Stage 1 1_firstCleanup
1_firstCleanup

echo Stage 2 2_convert2_dictd
2_convert2_dictd

echo Stage 3 3_convert2STARDICTwithMAKEDICT
3_convert2STARDICTwithMAKEDICT

#echo Stage 4 4_convert2CSVwithLINGUAE
#4_convert2CSVwithLINGUAE

echo Stage 4 4_convert2CSVwith_stardict2txt
4_convert2CSVwith_stardict2txt

echo Stage 5 5_secondCleanup
5_secondCleanup

echo Stage 6 6_thirdCleanup
6_thirdCleanup

echo Stage 7 7_putSomeColors
7_putSomeColors

echo Stage 8 8_putSomeMoreColors
8_putSomeMoreColors

echo Stage 9 9_convert2STARDICTwithLINGUAE
9_convert2STARDICTwithLINGUAE

#echo Stage 10 10_convert2STARDICTwith_tabfile
#10_convert2STARDICTwith_tabfile

# Moving files
mkdir -p CSV-Salmone-Lexicon
mv -v salmone-lexicon CSV-Salmone-Lexicon/

#dictunzip salmone-lexicon.dict.dz
#mkdir -p StarDict-Salmone-Lexicon
#mv -v salmone-lexicon.idx salmone-lexicon.ifo salmone-lexicon.dict StarDict-Salmone-Lexicon/

echo Stage 11: Final: clean_up
clean_up

exit $?
