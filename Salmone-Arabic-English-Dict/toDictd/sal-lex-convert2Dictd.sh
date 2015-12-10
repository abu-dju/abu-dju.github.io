#!/bin/bash

join_files(){
	cp -rfv ../salmone/usalmone.xml salmone-lexicon.xml
}

first_Cleanup(){
	perl -p -i -e 's|^\s+||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree|\n\n_____\n\n<entryFree|g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g' salmone-lexicon.xml
	perl -p -i -e 's|<orth|\n######<orth>|g' salmone-lexicon.xml
	perl -p -i -e 's|</orth>|\n</orth>|g' salmone-lexicon.xml
}

second_Cleanup(){
	perl -p -i -e 's|<br>| |g' salmone-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?="[a-zA-Z]+?\s*[a-zA-Z]*?"||g' salmone-lexicon.xml
	perl -p -i -e 's|n="\*"||g' salmone-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?="[a-zA-Z]*?[0-9]+?"||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree\s*?[a-zA-Z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree\s*?[a-zA-Z]+?="(.+?)"\s*?>|<entryFree>$1|g' salmone-lexicon.xml
	perl -p -i -e 's|<form\W+?>|<form>|g' salmone-lexicon.xml
	perl -p -i -e 's|<head\W+?>|<head>|g' salmone-lexicon.xml
	perl -p -i -e 's|<foreign\W+?>|<foreign>|g' salmone-lexicon.xml
	perl -p -i -e 's|<hi\W+?>|<hi>|g' salmone-lexicon.xml
	perl -p -i -e 's|<orth\W+?[a-zA-Z]+?=""\s*>|<orth>|g' salmone-lexicon.xml
	perl -p -i -e 's|<orth\W+?>|<orth>|g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|^\s+||g' salmone-lexicon.xml
	#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|salmone-lexicon.xml\t|g' salmone-lexicon.xml
}

third_Cleanup(){
	perl -p -i -e 's|<analytic/\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</author\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<author\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</authority\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<authority\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</availability\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<availability\W+\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</biblStruct\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<biblStruct\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</body\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<body\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</cell\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<cell\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|</date\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<date\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</div1\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<div1||g' salmone-lexicon.xml
	perl -p -i -e 's|</div2\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|encoding="UTF-8"\?\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</fileDesc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<fileDesc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's#</foreign\W*?>##g' salmone-lexicon.xml
	perl -p -i -e 's|<foreign\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</dictScrap\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<dictScrap\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</form\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<form\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</orth\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<orth\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</G\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<G/\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<G\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<H\W*?>[0-9]+</H\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</head\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<head\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</hi\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<hi\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</itype\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<itype\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</quote\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<quote\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</sense\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<sense\\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</H\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<H/\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</imprint\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<imprint\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</item\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<item\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|</listBibl\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<listBibl\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|</list\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<list\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|</L\W*?>|LCLOSE|g' salmone-lexicon.xml
	perl -p -i -e 's|<L\W*?>|LOPEN|g' salmone-lexicon.xml
	perl -p -i -e 's|</monogr\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<monogr\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|</note\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<note\W*?\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|</notesStmt\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<notesStmt\W*?>| |g' salmone-lexicon.xml
	perl -p -i -e 's|<pb\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<pb\W+\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<pb\W+/\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<pb/\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</p\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<p\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</publicationStmt\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<publicationStmt\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</publisher\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<publisher\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</pubPlace\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<pubPlace\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</row\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<row\W+\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</sourceDesc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<sourceDesc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</Table\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<Table\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|&amp;|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|amp;|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|&gt;|\W*?>|g' salmone-lexicon.xml
	perl -p -i -e 's|&lt;|<|g' salmone-lexicon.xml
	perl -p -i -e 's|&quot;|"|g' salmone-lexicon.xml
	perl -p -i -e 's|&&|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|</TEI.2\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<TEI.2\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<\?xml version="1.0"||g' salmone-lexicon.xml
	perl -p -i -e 's|</teiHeader\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<teiHeader\W+\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</text\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</text\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<text\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</title\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<title\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</titleStmt\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<titleStmt\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</entryFree>||g' salmone-lexicon.xml
}

fourth_Cleanup(){	 
	perl -p -i -e 's|&amp,amp,|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|&amp|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|&amp;|\&|g' salmone-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?>/||g' salmone-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?">||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" \$" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" \*" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part"[a-zA-Z]+?">||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 part"N"\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree >||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|<form type="[a-zA-Z]+? [a-zA-Z]+?">||g' salmone-lexicon.xml
	perl -p -i -e 's|<form type="[a-zA-Z]+?">||g' salmone-lexicon.xml
	perl -p -i -e 's|=||g' salmone-lexicon.xml
	perl -p -i -e 's|\*" >||g' salmone-lexicon.xml
	perl -p -i -e 's|― - |―|g' salmone-lexicon.xml
	perl -p -i -e 's|<H>||g' salmone-lexicon.xml
	perl -p -i -e 's|<orth orig="[a-b]+"\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|<orth orig="[a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<orth orig"[a-zA-Z]+"\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|part="[a-zA-Z]+?" [a-zA-Z]+?[0-9]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g' salmone-lexicon.xml
	perl -p -i -e 's|part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|" part="[a-zA-Z]+?">||g' salmone-lexicon.xml
	perl -p -i -e 's|" part="[a-zA-Z]+?"||g' salmone-lexicon.xml
	perl -p -i -e 's|<pb [0-9]+"/>||g' salmone-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0"||g' salmone-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" \$" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 n"\$"\W+>||g' salmone-lexicon.xml
}

fifth_Cleanup(){
	### Salmoné
	perl -p -i -e 's|<case\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</case>||g' salmone-lexicon.xml
	perl -p -i -e 's|<colloc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</colloc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<def\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</def>||g' salmone-lexicon.xml
	perl -p -i -e 's|<gramGrp\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</gramGrp>||g' salmone-lexicon.xml
	perl -p -i -e 's|<lbl\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</lbl>||g' salmone-lexicon.xml
	perl -p -i -e 's|<mood\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</mood>||g' salmone-lexicon.xml
	perl -p -i -e 's|<number\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</number>||g' salmone-lexicon.xml
	perl -p -i -e 's|<subc\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</subc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<usg\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</usg>||g' salmone-lexicon.xml
	perl -p -i -e 's|<xr\W*?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</xr>||g' salmone-lexicon.xml
	perl -p -i -e 's|^\s+||g' salmone-lexicon.xml
	perl -p -i -e 's|^ +\n +$||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 [a-z]+"||g' salmone-lexicon.xml	
	perl -p -i -e 's|<sense >||g' salmone-lexicon.xml
	perl -p -i -e 's|<sense/>||g' salmone-lexicon.xml
	perl -p -i -e 's|</ref>||g' salmone-lexicon.xml
	perl -p -i -e 's|<lang>||g' salmone-lexicon.xml
	perl -p -i -e 's|</lang>||g' salmone-lexicon.xml
	perl -p -i -e 's|<gen>||g' salmone-lexicon.xml
	perl -p -i -e 's|</gen>||g' salmone-lexicon.xml
	perl -p -i -e 's|<ref />||g' salmone-lexicon.xml
	perl -p -i -e 's|</gram>||g' salmone-lexicon.xml
	perl -p -i -e 's|<sense />||g' salmone-lexicon.xml
	perl -p -i -e 's|</change>||g' salmone-lexicon.xml
	perl -p -i -e 's|<change>||g' salmone-lexicon.xml
	perl -p -i -e 's|</encodingDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<encodingDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|encoding"utf-8"?>||g' salmone-lexicon.xml
	perl -p -i -e 's|</funder>||g' salmone-lexicon.xml
	perl -p -i -e 's|<funder n"org:NSF">||g' salmone-lexicon.xml
	perl -p -i -e 's|<idno >0866850899</idno>||g' salmone-lexicon.xml
	perl -p -i -e 's|<language >Arabic</language>||g' salmone-lexicon.xml
	perl -p -i -e 's|<language >English</language>||g' salmone-lexicon.xml
	perl -p -i -e 's|<language >Greek</language>||g' salmone-lexicon.xml
	perl -p -i -e 's|<language >Latin</language>||g' salmone-lexicon.xml
	perl -p -i -e 's|<language >Transliterated Arabic</language>||g' salmone-lexicon.xml
	perl -p -i -e 's|</langUsage>||g' salmone-lexicon.xml
	perl -p -i -e 's|<langUsage>||g' salmone-lexicon.xml
	perl -p -i -e 's|</name>||g' salmone-lexicon.xml
	perl -p -i -e 's|<name>||g' salmone-lexicon.xml
	perl -p -i -e 's|</profileDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<profileDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<refsDecl doctype"TEI.2">||g' salmone-lexicon.xml
	perl -p -i -e 's|</refsDecl>||g' salmone-lexicon.xml
	perl -p -i -e 's|</resp>||g' salmone-lexicon.xml
	perl -p -i -e 's|<resp>||g' salmone-lexicon.xml
	perl -p -i -e 's|</respStmt>||g' salmone-lexicon.xml
	perl -p -i -e 's|<respStmt>||g' salmone-lexicon.xml
	perl -p -i -e 's|</revisionDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|<revisionDesc>||g' salmone-lexicon.xml
	perl -p -i -e 's|(\s+\s+)+| |g' salmone-lexicon.xml
	perl -p -i -e 's|\n| |g' salmone-lexicon.xml
	perl -p -i -e 's#((―|-)*b[0-9]+(―|-)+)#\n\n[$1]#g' salmone-lexicon.xml
	perl -p -i -e 's#((―|-)*a[0-9]+(―|-)+)#\n\n[$1]#g' salmone-lexicon.xml
	perl -p -i -e 's#((―|-)*B[0-9]+(―|-)+)#\n\n[$1]#g' salmone-lexicon.xml
	perl -p -i -e 's#((―|-)*A[0-9]+(―|-)+)#\n\n[$1]#g' salmone-lexicon.xml
	perl -p -i -e 's|_____|\n\n_____\n\n|g' salmone-lexicon.xml
	perl -p -i -e 's|######|\n|g' salmone-lexicon.xml
	perl -p -i -e 's|" >||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 n"||g' salmone-lexicon.xml
	perl -p -i -e 's|<ref >||g' salmone-lexicon.xml
	perl -p -i -e 's|orig"" />||g' salmone-lexicon.xml
	perl -p -i -e 's|<gram >||g' salmone-lexicon.xml
	perl -p -i -e 's|<state />||g' salmone-lexicon.xml
	perl -p -i -e 's|>| |g' salmone-lexicon.xml
	perl -p -i -e 's|  +| |g' salmone-lexicon.xml
	perl -p -i -e 's|<state /||g' salmone-lexicon.xml
	perl -p -i -e 's|<gram||g' salmone-lexicon.xml
	perl -p -i -e 's|<ref||g' salmone-lexicon.xml
	perl -p -i -e 's|<div2 n||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
#	perl -p -i -e 's|||g' salmone-lexicon.xml
}

convert_2_dictd(){
dictfmt --utf8 -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" -c5 salmone-lexicon. < salmone-lexicon.xml
}

cleanup(){
rm -rfv salmone-lexicon.xml
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
