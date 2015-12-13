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

FILENAME_XML=salmone-lexicon.xml

join_files(){
	cp -rfv ../salmone/usalmone.xml $FILENAME_XML
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
		's|<analytic/\W*?>||g; \
		s|</author\W*?>||g; \
		s|<author\W*?>||g; \
		s|</authority\W*?>||g; \
		s|<authority\W*?>||g; \
		s|</availability\W*?>||g; \
		s|<availability\W+\W*?>||g; \
		s|</biblStruct\W*?>||g; \
		s|<biblStruct\W*?>||g; \
		s|</body\W*?>||g; \
		s|<body\W*?>||g; \
		s|</cell\W*?>||g; \
		s|<cell\W+>||g; \
		s|</date\W*?>||g; \
		s|<date\W*?>||g; \
		s|</div1\W*?>||g; \
		s|<div1||g; \
		s|</div2\W*?>||g; \
		s|<div2\W+>||g; \
		s|encoding="UTF-8"\?\W*?>||g; \
		s|</fileDesc\W*?>||g; \
		s|<fileDesc\W*?>||g; \
		s#</foreign\W*?>##g; \
		s|<foreign\W*?>||g; \
		s|</dictScrap\W*?>||g; \
		s|<dictScrap\W*?>||g; \
		s|</form\W*?>||g; \
		s|<form\W*?>||g; \
		s|</orth\W*?>||g; \
		s|<orth\W*?>||g; \
		s|</G\W*?>||g; \
		s|<G/\W*?>||g; \
		s|<G\W*?>||g; \
		s|<H\W*?>[0-9]+</H\W*?>||g; \
		s|</head\W*?>||g; \
		s|<head\W*?>||g; \
		s|</hi\W*?>||g; \
		s|<hi\W*?>||g; \
		s|</itype\W*?>||g; \
		s|<itype\W*?>||g; \
		s|</quote\W*?>||g; \
		s|<quote\W*?>||g; \
		s|</sense\W*?>||g; \
		s|<sense\\W*?>||g; \
		s|</H\W*?>||g; \
		s|<H/\W*?>||g; \
		s|</imprint\W*?>||g; \
		s|<imprint\W*?>||g; \
		s|</item\W*?>| |g; \
		s|<item\W*?>| |g; \
		s|</listBibl\W*?>| |g; \
		s|<listBibl\W*?>| |g; \
		s|</list\W*?>| |g; \
		s|<list\W*?>| |g; \
		s|</L\W*?>|LCLOSE|g; \
		s|<L\W*?>|LOPEN|g; \
		s|</monogr\W*?>| |g; \
		s|<monogr\W*?>| |g; \
		s|</note\W*?>| |g; \
		s|<note\W*?\W*?>| |g; \
		s|</notesStmt\W*?>| |g; \
		s|<notesStmt\W*?>| |g; \
		s|<pb\W*?>||g; \
		s|<pb\W+\W*?>||g; \
		s|<pb\W+/\W*?>||g; \
		s|<pb/\W*?>||g; \
		s|</p\W*?>||g; \
		s|<p\W*?>||g; \
		s|</publicationStmt\W*?>||g; \
		s|<publicationStmt\W*?>||g; \
		s|</publisher\W*?>||g; \
		s|<publisher\W*?>||g; \
		s|</pubPlace\W*?>||g; \
		s|<pubPlace\W*?>||g; \
		s|</row\W*?>||g; \
		s|<row\W+\W*?>||g; \
		s|</sourceDesc\W*?>||g; \
		s|<sourceDesc\W*?>||g; \
		s|</Table\W*?>||g; \
		s|<Table\W*?>||g; \
		s|&amp;|\&|g; \
		s|amp;|\&|g; \
		s|&gt;|\W*?>|g; \
		s|&lt;|<|g; \
		s|&quot;|"|g; \
		s|&&|\&|g; \
		s|</TEI.2\W*?>||g; \
		s|<TEI.2\W*?>||g; \
		s|<\?xml version="1.0"||g; \
		s|</teiHeader\W*?>||g; \
		s|<teiHeader\W+\W*?>||g; \
		s|</text\W*?>||g; \
		s|</text\W*?>||g; \
		s|<text\W*?>||g; \
		s|</title\W*?>||g; \
		s|<title\W*?>||g; \
		s|</titleStmt\W*?>||g; \
		s|<titleStmt\W*?>||g; \
		s|<entryFree\W*?>||g; \
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
		s|<div2 n"\$"\W+>||g;' $FILENAME_XML
}

fifth_Cleanup(){
	perl -p -i -e \
		's|<case\W*?>||g; \
		s|</case>||g; \
		s|<colloc\W*?>||g; \
		s|</colloc>||g; \
		s|<def\W*?>||g; \
		s|</def>||g; \
		s|<gramGrp\W*?>||g; \
		s|</gramGrp>||g; \
		s|<lbl\W*?>||g; \
		s|</lbl>||g; \
		s|<mood\W*?>||g; \
		s|</mood>||g; \
		s|<number\W*?>||g; \
		s|</number>||g; \
		s|<subc\W*?>||g; \
		s|</subc>||g; \
		s|<usg\W*?>||g; \
		s|</usg>||g; \
		s|<xr\W*?>||g; \
		s|</xr>||g; \
		s|^\s+||g; \
		s|^ +\n +$||g; \
		s|<div2 [a-z]+"||g; \	
		s|<sense >||g; \
		s|<sense/>||g; \
		s|</ref>||g; \
		s|<lang>||g; \
		s|</lang>||g; \
		s|<gen>||g; \
		s|</gen>||g; \
		s|<ref />||g; \
		s|</gram>||g; \
		s|<sense />||g; \
		s|</change>||g; \
		s|<change>||g; \
		s|</encodingDesc>||g; \
		s|<encodingDesc>||g; \
		s|encoding"utf-8"?>||g; \
		s|</funder>||g; \
		s|<funder n"org:NSF">||g; \
		s|<idno >0866850899</idno>||g; \
		s|<language >Arabic</language>||g; \
		s|<language >English</language>||g; \
		s|<language >Greek</language>||g; \
		s|<language >Latin</language>||g; \
		s|<language >Transliterated Arabic</language>||g; \
		s|</langUsage>||g; \
		s|<langUsage>||g; \
		s|</name>||g; \
		s|<name>||g; \
		s|</profileDesc>||g; \
		s|<profileDesc>||g; \
		s|<refsDecl doctype"TEI.2">||g; \
		s|</refsDecl>||g; \
		s|</resp>||g; \
		s|<resp>||g; \
		s|</respStmt>||g; \
		s|<respStmt>||g; \
		s|</revisionDesc>||g; \
		s|<revisionDesc>||g; \
		s|(\s+\s+)+| |g; \
		s|\n| |g; \
		s#((―|-)*b[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*a[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*B[0-9]+(―|-)+)#\n\n[$1]#g; \
		s#((―|-)*A[0-9]+(―|-)+)#\n\n[$1]#g; \
		s|_____|\n\n_____\n\n|g; \
		s|######|\n|g; \
		s|" >||g; \
		s|<div2 n"||g; \
		s|<ref >||g; \
		s|orig"" />||g; \
		s|<gram >||g; \
		s|<state />||g; \
		s|>| |g; \
		s|  +| |g; \
		s|<state /||g; \
		s|<gram||g; \
		s|<ref||g; \
		s|<div2 n||g;' $FILENAME_XML
}

convert_2_dictd(){
dictfmt --utf8 -u dfmcreator@gmail.com -s "Salmone Arabic-English Lexicon" -c5 salmone-lexicon < $FILENAME_XML
}

cleanup(){
rm -rfv $FILENAME_XML dictd-salmone_ara_eng-lexicon
mkdir -p dictd-salmone_ara_eng-lexicon && mv -v salmone-lexicon.dict salmone-lexicon.index dictd-salmone_ara_eng-lexicon/
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
