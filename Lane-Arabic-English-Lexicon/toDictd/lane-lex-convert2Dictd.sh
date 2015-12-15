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

join_files(){
	cat ../lane/*.xml > $FILENAME_XML
}

first_Cleanup(){
	perl -p -i -e \
		's|<entryFree.*[^<\n\r\f]*?>|\n\n_____\n\n|g; \
		s|</entryFree>||g; \
		s|<orth|\n<orth|g; \
		s|</orth>|\n</orth>|g; \
		s|<\?xml version="1.0" encoding="UTF-8"\?>||g; \
		s|<TEI.2>||g; \
		s|<text>||g; \
		s|<body>||g; \
		s|<div1.*?[^<\n\r\f]*?>||g; \
		s|<head.*?[^<\n\r\f]*?>||g; \
		s|</head>||g; \
		s|<div2.*?[^<\n\r\f]*?>||g; \
		s|<form.*?[^<\n\r\f]*?>||g; \
		s|</form>||g; \
		s|<itype>.+?[^<\n\r\f]*?</itype>||g; \
		s|<orth.*?[^<\n\r\f]*?>||g; \
		s|</orth>||g; \
		s|<hi.*?[^<\n\r\f]*?>||g; \
		s|</hi>||g; \
		s|<foreign.*?[^<\n\r\f]*?>||g; \
		s|</foreign>||g; \
		s|</div2>||g; \
		s|<quote.*?[^<\n\r\f]*?>||g; \
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
		s|<head.*?[^<\n\r\f]*?>||g; \
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
		s|<Table>| |g; \
		s|<row role="data">| |g; \
		s|<cell role="data" rows="1" cols="1">| |g; \
		s|</cell>| |g; \
		s|</row>| |g; \
		s|</Table>| |g; \
		s|\n\n\n|\n|g; \
		s|\n\n|\n|g; \
		s|_____|\n\n\n_____\n|g; \
		s|^\s+||g; \
		s|�| |g; \
		s|@| |g; \
		s|=| |g; \
		s|foreignopen||g; \
		s|_____\s*(.*?see)|$1|g; \
		s|\f|\n|g; \
		s|\r|\n|g; \
		s|[ ]{2,}| |g;' $FILENAME_XML
		#editpadpro7 $FILENAME_XML
}

2_convert2_dictd_and_mix_tashkeel_and_tasheel_less_dicts(){
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
	cat lane-lexicon-no-tashkeel.txt lane-lexicon-tashkeel.txt > lane-lexicon.txt
	#editpadpro7 lane-lexicon.txt
}

further_Cleanup(){
	perl -p -i -e \
		's|\\n| |g; \
		s#((―|-)*b[0-9]+(―|-)+)#\\n\\n[$1]#g; \
		s#((―|-)*a[0-9]+(―|-)+)#\\n\\n[$1]#g; \
		s#((―|-)*B[0-9]+(―|-)+)#\\n\\n[$1]#g; \
		s#((―|-)*A[0-9]+(―|-)+)#\\n\\n[$1]#g; \
		s|[ ]{2,}| |g;' lane-lexicon.txt
}

convert_2_dictd(){
	python2.7 ../../deps/pyglossary/pyglossary.py lane-lexicon.txt lane-lexicon.index
}

cleanup(){
	rm -rfv $FILENAME_XML
	mkdir -p dictd-lane_ara_eng-lexicon && \
	dictunzip lane-lexicon.dict.dz
	mv -vf lane-lexicon.dict lane-lexicon.index dictd-lane_ara_eng-lexicon/
	rm -rfv lane-lexicon.txt lane-lexicon-no-tashkeel.dict lane-lexicon-no-tashkeel.index lane-lexicon-no-tashkeel.txt lane-lexicon-tashkeel.dict lane-lexicon-tashkeel.index lane-lexicon-tashkeel.txt
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
