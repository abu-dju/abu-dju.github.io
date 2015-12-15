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
#+ Lane Arabic-English Lexicon to various dictionary formats.
#
# Copyright 2015 Abu Djuwairiyyah Karim Mohammad Karimou

FILENAME_XML=lane-lexicon.xml
FILENAME_CSV=lane-lexicon.csv

0_xml_merge(){
	cat ../lane/*.xml > $FILENAME_XML
}

1_firstCleanup(){
	perl -p -i -e \
		's|<entryFree.*[^<\n\r\f]*?>|\n\n_____\n\n|g; \
		s|</entryFree>||g; \
		s|</orth>|\n</orth>|g; \
		s|<\?xml version="1.0" encoding="UTF-8"\?>||g; \
		s|<TEI.2>||g; \
		s|<text>||g; \
		s|<body>||g; \
		s|<div1.*?[^<\n\r\f]>||g; \
		s|<head.*?[^<\n\r\f]>||g; \
		s|</head>||g; \
		s|<div2.*?[^<\n\r\f]>||g; \
		s|<form.*?[^<\n\r\f]*?>||g; \
		s|</form>||g; \
		s|<itype>.+?[^<\n\r\f]*?</itype>||g; \
		s|<orth.*?[^<\n\r\f]*?>||g; \
		s|</orth>||g; \
		s|<hi.*?[^<\n\r\f]*?>|HI_OPEN|g; \
		s|</hi>|HI_CLOSE|g; \
		s|<foreign.*?[^<\n\r\f]*?>|FOREIGNOPEN|g; \
		s|</foreign>|FOREIGNCLOSE|g; \
		s|</div2>||g; \
		s|<quote>||g; \
		s|</quote>||g; \
		s|<L>||g; \
		s|</L>||g; \
		s|<pb.*?[^<\n\r\f]*?>||g; \
		s|<G/>||g; \
		s|</div1>||g; \
		s|</body>||g; \
		s|</text>||g; \
		s|</TEI.2>||g; \
		s|<H>||g; \
		s|</H>||g; \
		s|<G>||g; \
		s|</G>||g; \
		s|<head>||g; \
		s|<analytic/>||g; \
		s|</author>||g; \
		s|<author>||g; \
		s|</authority>||g; \
		s|<authority>||g; \
		s|</availability>||g; \
		s|<availability status="free">||g; \
		s|</biblStruct>||g; \
		s|<biblStruct>||g; \
		s|</date>||g; \
		s|<date>||g; \
		s|</fileDesc>||g; \
		s|<fileDesc>||g; \
		s|</imprint>||g; \
		s|<imprint>||g; \
		s|</item>||g; \
		s|<item>||g; \
		s|</list>||g; \
		s|<list>||g; \
		s|</listBibl>||g; \
		s|<listBibl>||g; \
		s|</monogr>||g; \
		s|<monogr>||g; \
		s|</note>||g; \
		s|<note anchored="yes" place="unspecified">||g; \
		s|</notesStmt>||g; \
		s|<notesStmt>||g; \
		s|</p>||g; \
		s|<p>||g; \
		s|</publicationStmt>||g; \
		s|<publicationStmt>||g; \
		s|</publisher>||g; \
		s|<publisher>||g; \
		s|</pubPlace>||g; \
		s|<pubPlace>||g; \
		s|</sourceDesc>||g; \
		s|<sourceDesc>||g; \
		s|</teiHeader>||g; \
		s|<teiHeader type="text" status="new">||g; \
		s|</title>||g; \
		s|<title>||g; \
		s|</titleStmt>||g; \
		s|<titleStmt>||g; \
		s|<H/>||g; \
		s|<sense>||g; \
		s|<dictScrap>||g; \
		s|</dictScrap>||g; \
		s|</sense>||g; \		
		s|<Table>|OPENTABLE|g; \
		s|<row role="data">|ROWROLDATA|g; \
		s|<cell role="data" rows="1" cols="1">|CELLROLEROWSDATA|g; \
		s|</cell>|CLOSECELL|g; \
		s|</row>|CLOSEROW|g; \
		s|</Table>|CLOSETABLE|g; \
		s|\n\n\n|\n|g; \
		s|\n\n|\n|g; \
		s|_____|\n\n\n_____\n|g; \
		s|^\s+||g; \
		s|�| |g; \
		s|@| |g; \
		s|=| |g; \
		s|\r|\n|g; \
		s|foreignopen||g; \
		s|_____\s*(.*?see)|$1|g; \
		s|\f|\n|g; ' $FILENAME_XML
		#editpadpro7 $FILENAME_XML
}


2_convert2_dictd(){
	# this will enable us to search for tashkeel-less words
	dictfmt --utf8 -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" \
	-c5 lane-lexicon-no-tashkeel < $FILENAME_XML
	# delete inconsistencies from index file
	sed -e '1,600d' -i lane-lexicon-no-tashkeel.index
	
	# this will enable us to search for words with tashkeel
	dictfmt --utf8 --allchars -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" \
	-c5 lane-lexicon-tashkeel < $FILENAME_XML
	# delete inconsistencies from index file
	sed -e '1,602d' -i lane-lexicon-tashkeel.index
}

3_convert2CSVwithPYGLOSSARY(){
	python2.7 ./pyglossary/pyglossary.py lane-lexicon-no-tashkeel.index lane-lexicon-no-tashkeel.txt	
	python2.7 ./pyglossary/pyglossary.py lane-lexicon-tashkeel.index lane-lexicon-tashkeel.txt
	# Join the two files
	cat lane-lexicon-no-tashkeel.txt lane-lexicon-tashkeel.txt > lane-lexicon.csv
}

4_second_cleanup(){
	perl -p -i -e \
		's|\t|#####_____#####_____#####|g; \
		s|\\n|<br>|g; \
		s|<k>||g; \
		s|</k>||g; \
		s|<br>| |g;' $FILENAME_CSV
}

5_putSomeColors(){
	perl -p -i -e \
		's|FOREIGNOPEN||g; \
		s|FOREIGNCLOSE||g; \
		s|OPENTABLE|<Table>|g; \
		s|ROWROLDATA|<row role="data">|g; \
		s|CELLROLEROWSDATA|<cell role="data" rows="1" cols="1">|g; \
		s|CLOSECELL|</cell>|g; \
		s|CLOSEROW|</row>|g; \
		s|CLOSETABLE|</Table>|g; \		
		s|HI_OPEN|<i><FONT COLOR="DarkBlue">|g; \
		s|HI_CLOSE|</FONT></i>|g; \
		s|― - |―|g; \
		s|-|―|g; \
		s|― ―|―|g; \
		s#((―|-)*a[0-9]+(―|-)+)#<p></p><b><FONT COLOR="DarkSlateGray">[$1]</FONT></b>#g; \
		s#((―|-)*b[0-9]+(―|-)+)#<p></p><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g; \
		s#((―|-)*A[0-9]+(―|-)+)#<p></p><b><FONT COLOR="SaddleBrown">[$1]</FONT></b>#g; \
		s#((―|-)*B[0-9]+(―|-)+)#<p></p><b><FONT COLOR="Indigo">[$1]</FONT></b>#g; \
		s#(\(.+?[^(\n\f\r]\))#<b><i><FONT COLOR="DarkOliveGreen"> $1 </FONT></i></b>#g; \
		s|[ ]{2,}| |g;' $FILENAME_CSV
}

6_convert2STARDICTwith_tabfile(){
	dict=`readlink --no-newline --quiet --silent -f $FILENAME_CSV`

	# Restore the tab Character
	perl -p -i -e 's|#####_____#####_____#####|\t|g' $FILENAME_CSV

	# Convert to StarDict
	# Adding a new line at the end of the file
	echo >> "$dict"
	./tabfile "$dict"
}

clean_up(){
	echo "Will delete junk files in 10 seconds;"
	echo "interrupt the script if you want to keep them."

	sleep 10 && rm -rfv $FILENAME_XML lane-lexicon-tashkeel.txt lane-lexicon-no-tashkeel.txt lane-lexicon-no-tashkeel.index lane-lexicon-no-tashkeel.dict lane-lexicon-tashkeel.index lane-lexicon-tashkeel.dict stardict-lane-lexicon-2.4.2
}

convert2otherFormats(){
	# Unzip dict
	dictunzip lane-lexicon.dict.dz
	# Convert to xdxf
	./makedict -i stardict -o xdxf lane-lexicon.ifo
	# Fix color problems
	./fix_xdxd_dicts_colors.sh lane-lexicon/dict.xdxf
	# Prepare convertion to slob format (Aard2)
	source env-slob/bin/activate
	# cleanup
	rm -rfv lane-lexicon.slob
	xdxf2slob -c lzma2 -o lane-lexicon.slob -a abu-dju.github.io lane-lexicon/dict.xdxf
	
	mkdir -p DIST StarDict-Lane-Lexicon lane-lexicon-slob CSV-Lane-Lexicon
	mv -vf lane-lexicon.idx lane-lexicon.ifo lane-lexicon.dict StarDict-Lane-Lexicon/
	mv -vf lane-lexicon lane-lexicon-xdxf
	mv -vf lane-lexicon.csv CSV-Lane-Lexicon
	mv -vf lane-lexicon.slob lane-lexicon-slob
	mv -vf lane-lexicon-slob lane-lexicon-xdxf StarDict-Lane-Lexicon CSV-Lane-Lexicon DIST/
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
