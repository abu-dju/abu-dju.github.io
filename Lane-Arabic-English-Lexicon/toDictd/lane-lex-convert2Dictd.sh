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
		's|^\s+||g; \
		s|<entryFree|\n\n_____\n\n<entryFree|g; \
		s|<itype>[0-9]+</itype>||g; \
		s|<itype>.*?</itype>||g; \
		s|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g; \
		s|<orth|\n######<orth>|g; \
		s|</orth>|\n</orth>|g;' $FILENAME_XML
}

second_Cleanup(){
	perl -p -i -e \
		's|<br>| |g; \
		s|[a-zA-Z]+?="[a-zA-Z]+?\s*[a-zA-Z]*?"||g; \
		s|n="\*"||g; \
		s|[a-zA-Z]+?="[a-zA-Z]*?[0-9]+?"||g; \
		s|<entryFree\s*?[a-zA-Z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g; \
		s|<entryFree\s*?[a-zA-Z]+?="(.+?)"\s*?>|<entryFree>$1|g; \
		s|<form\W+?>|<form>|g; \
		s|<head\W+?>|<head>|g; \
		s|<foreign\W+?>|<foreign>|g; \
		s|<hi\W+?>|<hi>|g; \
		s|<orth\W+?[a-zA-Z]+?=""\s*>|<orth>|g; \
		s|<orth\W+?>|<orth>|g; \
		s|<itype>[0-9]+</itype>||g; \
		s|<itype>.*?</itype>||g; \
		s|^\s+||g;' $FILENAME_XML
		#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|$FILENAME_XML\t|g' $FILENAME_XML
}

third_Cleanup(){
	perl -p -i -e \
		's|<analytic/>||g; \
		s|</author>||g; \
		s|<author>||g; \
		s|</authority>||g; \
		s|<authority>||g; \
		s|</availability>||g; \
		s|<availability\W+>||g; \
		s|</biblStruct>||g; \
		s|<biblStruct>||g; \
		s|</body>||g; \
		s|<body>||g; \
		s|</cell>||g; \
		s|<cell\W+>||g; \
		s|</date>||g; \
		s|<date>||g; \
		s|</div1>||g; \
		s|<div1||g; \
		s|</div2>||g; \
		s|<div2\W+>||g; \
		s|encoding="UTF-8"\?>||g; \
		s|</fileDesc>||g; \
		s|<fileDesc>||g; \
		s#</foreign>##g; \
		s|<foreign>||g; \
		s|</dictScrap>||g; \
		s|<dictScrap>||g; \
		s|</form>||g; \
		s|<form>||g; \
		s|</orth>||g; \
		s|<orth>||g; \
		s|</G>||g; \
		s|<G/>||g; \
		s|<G>||g; \
		s|<H>[0-9]+</H>||g; \
		s|</head>||g; \
		s|<head>||g; \
		s|</hi>||g; \
		s|<hi>||g; \
		s|</itype>||g; \
		s|<itype>||g; \
		s|</quote>||g; \
		s|<quote>||g; \
		s|</sense>||g; \
		s|<sense>||g; \
		s|</H>||g; \
		s|<H/>||g; \
		s|</imprint>||g; \
		s|<imprint>||g; \
		s|</item>| |g; \
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
		s|<note\W*?>| |g; \
		s|</notesStmt>| |g; \
		s|<notesStmt>| |g; \
		s|<pb>||g; \
		s|<pb\W+>||g; \
		s|<pb\W+/>||g; \
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
		s|<row\W+>||g; \
		s|</sourceDesc>||g; \
		s|<sourceDesc>||g; \
		s|</Table>||g; \
		s|<Table>||g; \
		s|&amp;|\&|g; \
		s|amp;|\&|g; \
		s|&gt;|>|g; \
		s|&lt;|<|g; \
		s|&quot;|"|g; \
		s|&&|\&|g; \
		s|</TEI.2>||g; \
		s|<TEI.2>||g; \
		s|<\?xml version="1.0"||g; \
		s|</teiHeader>||g; \
		s|<teiHeader\W+>||g; \
		s|</text>||g; \
		s|</text>||g; \
		s|<text>||g; \
		s|</title>||g; \
		s|<title>||g; \
		s|</titleStmt>||g; \
		s|<titleStmt>||g; \
		s|<entryFree>||g; \
		s|</entryFree>||g;' $FILENAME_XML
}

fourth_Cleanup(){	 
	perl -p -i -e \
		's|&amp,amp,|\&|g; \
		s|&amp|\&|g; \
		s|&amp;|\&|g; \
		s|[a-zA-Z]+?>/||g; \
		s|[a-zA-Z]+?" >||g; \
		s|<div2 part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g; \
		s|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g; \
		s|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g; \
		s|<div2 part="[a-zA-Z]+?">||g; \
		s|<div2 part="[a-zA-Z]+?" >||g; \
		s|<div2 part="[a-zA-Z]+?" \$" >||g; \
		s|<div2 part="[a-zA-Z]+?" \*" >||g; \
		s|<div2 part"[a-zA-Z]+?">||g; \
		s|<div2 part"N"\W+>||g; \
		s|<entryFree >||g; \
		s|<entryFree\W+>||g; \
		s|<form type="[a-zA-Z]+? [a-zA-Z]+?">||g; \
		s|<form type="[a-zA-Z]+?">||g; \
		s|=||g; \
		s|\*" >||g; \
		s|― - |―|g; \
		s|<H>||g; \
		s|<orth orig="[a-b]+"\W+>||g; \
		s|<orth orig="[a-zA-Z]+?" >||g; \
		s|<orth orig"[a-zA-Z]+"\W+>||g; \
		s|part="[a-zA-Z]+?" [a-zA-Z]+?[0-9]+?" >||g; \
		s|part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g; \
		s|part="[a-zA-Z]+?" [a-zA-Z]+?" >||g; \
		s|" part="[a-zA-Z]+?">||g; \
		s|" part="[a-zA-Z]+?"||g; \
		s|<pb [0-9]+"/>||g; \
		s|<\?xml versio1.0"||g; \
		s|<\?xml versio1.0" part="[a-zA-Z]+?" [a-zA-Z]+?" >||g; \
		s|<\?xml versio1.0" part="[a-zA-Z]+?" >||g; \
		s|<\?xml versio1.0" part="[a-zA-Z]+?" \$" >||g; \
		s|<div2 n"\$"\W+>||g; \
		s|>| |g;' $FILENAME_XML	 
}

fifth_Cleanup(){
	perl -p -i -e \
		's|\n| |g; \
		s#((―|-)*b[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*a[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*B[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*A[0-9]+(―|-)+)#\n\n[$1]#g; \
		s|_____|\n\n_____\n\n|g; \
		s|######|\n|g; \	
		s|  +| |g;' $FILENAME_XML
}

convert_2_dictd(){
dictfmt --utf8 -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" -c5 lane-lexicon < $FILENAME_XML
}

cleanup(){
rm -rfv $FILENAME_XML
mkdir -p dictd-lane_ara_eng-lexicon && mv -v lane-lexicon.dict lane-lexicon.index dictd-lane_ara_eng-lexicon/
}

echo Stage 1 join_files
join_files

echo Stage 2 first_Cleanup
first_Cleanup

echo Stage 3 second_Cleanup
second_Cleanup

echo Stage 4 third_Cleanup
third_Cleanup

echo Stage 5 fourth_Cleanup
fourth_Cleanup

echo Stage 6 fifth_Cleanup
fifth_Cleanup

echo Stage 7 convert_2_dictd
convert_2_dictd

echo Stage 8 cleanup
cleanup

exit $?
