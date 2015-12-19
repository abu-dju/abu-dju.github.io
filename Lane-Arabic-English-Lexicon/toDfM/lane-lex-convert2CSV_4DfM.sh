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
	python2.7 ../../deps/pyglossary/pyglossary.py lane-lexicon-no-tashkeel.index lane-lexicon-no-tashkeel.txt	
	python2.7 ../../deps/pyglossary/pyglossary.py lane-lexicon-tashkeel.index lane-lexicon-tashkeel.txt
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

5_putDfM_contentNNProperties(){
	perl -p -i -e \
		's|\[|{|g; \
		s|\]|}|g; \
		s|FOREIGNOPEN||g; \
		s|FOREIGNCLOSE||g; \
		s|OPENTABLE| |g; \
		s|ROWROLDATA| |g; \
		s|CELLROLEROWSDATA| |g; \
		s|CLOSECELL| |g; \
		s|CLOSEROW| |g; \
		s|CLOSETABLE| |g; \		
		s|HI_OPEN|\[01|g; \
		s|HI_CLOSE|]|g; \
		s|― - |―|g; \
		s|-|―|g; \
		s#((―|-)*a[0-9]+(―|-)+)#\\n\\n \[02 \{$1\} \]#g; \
		s#((―|-)*b[0-9]+(―|-)+)#\\n\\n \[03 \{$1\} \]#g; \
		s#((―|-)*A[0-9]+(―|-)+)#\\n\\n \[04 \{$1\} \]#g; \
		s#((―|-)*B[0-9]+(―|-)+)#\\n\\n \[05 \{$1\} \]#g; \
		s#(\(.+?[^(\n\f\r]\))#\\n\\n \[06 $1 \]#g; \
		s|[ ]{2,}| |g; \
		s|#####_____#####_____#####|\t|g;' $FILENAME_CSV
}

clean_up(){
	echo "Will delete junk files in 10 seconds;"
	echo "interrupt the script if you want to keep them."

	sleep 10 && rm -rfv $FILENAME_XML lane-lexicon-tashkeel.txt lane-lexicon-no-tashkeel.txt lane-lexicon-no-tashkeel.index lane-lexicon-no-tashkeel.dict lane-lexicon-tashkeel.index lane-lexicon-tashkeel.dict
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

echo Stage 5 5_putDfM_contentNNProperties
5_putDfM_contentNNProperties

echo Stage 11: Final: clean_up
clean_up

exit $?
