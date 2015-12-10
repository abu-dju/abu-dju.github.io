#!/bin/bash

join_files(){
	cat ../lane/*.xml > lane-lexicon.xml
}

first_Cleanup(){
	perl -p -i -e 's|^\s+||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree|\n\n_____\n\n<entryFree|g' lane-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g' lane-lexicon.xml
	perl -p -i -e 's|<orth|\n######<orth>|g' lane-lexicon.xml
	perl -p -i -e 's|</orth>|\n</orth>|g' lane-lexicon.xml
}

second_Cleanup(){
	perl -p -i -e 's|<br>| |g' lane-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?="[a-zA-Z]+?\s*[a-zA-Z]*?"||g' lane-lexicon.xml
	perl -p -i -e 's|n="\*"||g' lane-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?="[a-zA-Z]*?[0-9]+?"||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree\s*?[a-zA-Z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree\s*?[a-zA-Z]+?="(.+?)"\s*?>|<entryFree>$1|g' lane-lexicon.xml
	perl -p -i -e 's|<form\W+?>|<form>|g' lane-lexicon.xml
	perl -p -i -e 's|<head\W+?>|<head>|g' lane-lexicon.xml
	perl -p -i -e 's|<foreign\W+?>|<foreign>|g' lane-lexicon.xml
	perl -p -i -e 's|<hi\W+?>|<hi>|g' lane-lexicon.xml
	perl -p -i -e 's|<orth\W+?[a-zA-Z]+?=""\s*>|<orth>|g' lane-lexicon.xml
	perl -p -i -e 's|<orth\W+?>|<orth>|g' lane-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' lane-lexicon.xml
	#perl -p -i -e 's|(\s+\s+)+| |g' lane-lexicon.xml
	perl -p -i -e 's|^\s+||g' lane-lexicon.xml
	#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|lane-lexicon.xml\t|g' lane-lexicon.xml
}

third_Cleanup(){
	perl -p -i -e 's|<analytic/>||g' lane-lexicon.xml
	perl -p -i -e 's|</author>||g' lane-lexicon.xml
	perl -p -i -e 's|<author>||g' lane-lexicon.xml
	perl -p -i -e 's|</authority>||g' lane-lexicon.xml
	perl -p -i -e 's|<authority>||g' lane-lexicon.xml
	perl -p -i -e 's|</availability>||g' lane-lexicon.xml
	perl -p -i -e 's|<availability\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|</biblStruct>||g' lane-lexicon.xml
	perl -p -i -e 's|<biblStruct>||g' lane-lexicon.xml
	perl -p -i -e 's|</body>||g' lane-lexicon.xml
	perl -p -i -e 's|<body>||g' lane-lexicon.xml
	perl -p -i -e 's|</cell>||g' lane-lexicon.xml
	perl -p -i -e 's|<cell\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|</date>||g' lane-lexicon.xml
	perl -p -i -e 's|<date>||g' lane-lexicon.xml
	perl -p -i -e 's|</div1>||g' lane-lexicon.xml
	perl -p -i -e 's|<div1||g' lane-lexicon.xml
	perl -p -i -e 's|</div2>||g' lane-lexicon.xml
	perl -p -i -e 's|<div2\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|encoding="UTF-8"\?>||g' lane-lexicon.xml
	perl -p -i -e 's|</fileDesc>||g' lane-lexicon.xml
	perl -p -i -e 's|<fileDesc>||g' lane-lexicon.xml
	perl -p -i -e 's#</foreign>##g' lane-lexicon.xml
	perl -p -i -e 's|<foreign>||g' lane-lexicon.xml
	perl -p -i -e 's|</dictScrap>||g' lane-lexicon.xml
	perl -p -i -e 's|<dictScrap>||g' lane-lexicon.xml
	perl -p -i -e 's|</form>||g' lane-lexicon.xml
	perl -p -i -e 's|<form>||g' lane-lexicon.xml
	perl -p -i -e 's|</orth>||g' lane-lexicon.xml
	perl -p -i -e 's|<orth>||g' lane-lexicon.xml
	perl -p -i -e 's|</G>||g' lane-lexicon.xml
	perl -p -i -e 's|<G/>||g' lane-lexicon.xml
	perl -p -i -e 's|<G>||g' lane-lexicon.xml
	perl -p -i -e 's|<H>[0-9]+</H>||g' lane-lexicon.xml
	perl -p -i -e 's|</head>||g' lane-lexicon.xml
	perl -p -i -e 's|<head>||g' lane-lexicon.xml
	perl -p -i -e 's|</hi>||g' lane-lexicon.xml
	perl -p -i -e 's|<hi>||g' lane-lexicon.xml
	perl -p -i -e 's|</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<itype>||g' lane-lexicon.xml
	perl -p -i -e 's|</quote>||g' lane-lexicon.xml
	perl -p -i -e 's|<quote>||g' lane-lexicon.xml
	perl -p -i -e 's|</sense>||g' lane-lexicon.xml
	perl -p -i -e 's|<sense>||g' lane-lexicon.xml
	perl -p -i -e 's|</H>||g' lane-lexicon.xml
	perl -p -i -e 's|<H/>||g' lane-lexicon.xml
	perl -p -i -e 's|</imprint>||g' lane-lexicon.xml
	perl -p -i -e 's|<imprint>||g' lane-lexicon.xml
	perl -p -i -e 's|</item>| |g' lane-lexicon.xml
	perl -p -i -e 's|<item>| |g' lane-lexicon.xml
	perl -p -i -e 's|</listBibl>| |g' lane-lexicon.xml
	perl -p -i -e 's|<listBibl>| |g' lane-lexicon.xml
	perl -p -i -e 's|</list>| |g' lane-lexicon.xml
	perl -p -i -e 's|<list>| |g' lane-lexicon.xml
	perl -p -i -e 's|</L>|LCLOSE|g' lane-lexicon.xml
	perl -p -i -e 's|<L>|LOPEN|g' lane-lexicon.xml
	perl -p -i -e 's|</monogr>| |g' lane-lexicon.xml
	perl -p -i -e 's|<monogr>| |g' lane-lexicon.xml
	perl -p -i -e 's|</note>| |g' lane-lexicon.xml
	perl -p -i -e 's|<note\W*?>| |g' lane-lexicon.xml
	perl -p -i -e 's|</notesStmt>| |g' lane-lexicon.xml
	perl -p -i -e 's|<notesStmt>| |g' lane-lexicon.xml
	perl -p -i -e 's|<pb>||g' lane-lexicon.xml
	perl -p -i -e 's|<pb\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|<pb\W+/>||g' lane-lexicon.xml
	perl -p -i -e 's|<pb/>||g' lane-lexicon.xml
	perl -p -i -e 's|</p>||g' lane-lexicon.xml
	perl -p -i -e 's|<p>||g' lane-lexicon.xml
	perl -p -i -e 's|</publicationStmt>||g' lane-lexicon.xml
	perl -p -i -e 's|<publicationStmt>||g' lane-lexicon.xml
	perl -p -i -e 's|</publisher>||g' lane-lexicon.xml
	perl -p -i -e 's|<publisher>||g' lane-lexicon.xml
	perl -p -i -e 's|</pubPlace>||g' lane-lexicon.xml
	perl -p -i -e 's|<pubPlace>||g' lane-lexicon.xml
	perl -p -i -e 's|</row>||g' lane-lexicon.xml
	perl -p -i -e 's|<row\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|</sourceDesc>||g' lane-lexicon.xml
	perl -p -i -e 's|<sourceDesc>||g' lane-lexicon.xml
	perl -p -i -e 's|</Table>||g' lane-lexicon.xml
	perl -p -i -e 's|<Table>||g' lane-lexicon.xml
	perl -p -i -e 's|&amp;|\&|g' lane-lexicon.xml
	perl -p -i -e 's|amp;|\&|g' lane-lexicon.xml
	perl -p -i -e 's|&gt;|>|g' lane-lexicon.xml
	perl -p -i -e 's|&lt;|<|g' lane-lexicon.xml
	perl -p -i -e 's|&quot;|"|g' lane-lexicon.xml
	perl -p -i -e 's|&&|\&|g' lane-lexicon.xml
	perl -p -i -e 's|</TEI.2>||g' lane-lexicon.xml
	perl -p -i -e 's|<TEI.2>||g' lane-lexicon.xml
	perl -p -i -e 's|<\?xml version="1.0"||g' lane-lexicon.xml
	perl -p -i -e 's|</teiHeader>||g' lane-lexicon.xml
	perl -p -i -e 's|<teiHeader\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|</text>||g' lane-lexicon.xml
	perl -p -i -e 's|</text>||g' lane-lexicon.xml
	perl -p -i -e 's|<text>||g' lane-lexicon.xml
	perl -p -i -e 's|</title>||g' lane-lexicon.xml
	perl -p -i -e 's|<title>||g' lane-lexicon.xml
	perl -p -i -e 's|</titleStmt>||g' lane-lexicon.xml
	perl -p -i -e 's|<titleStmt>||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree>||g' lane-lexicon.xml
	perl -p -i -e 's|</entryFree>||g' lane-lexicon.xml
}

fourth_Cleanup(){	 
	perl -p -i -e 's|&amp,amp,|\&|g' lane-lexicon.xml
	perl -p -i -e 's|&amp|\&|g' lane-lexicon.xml
	perl -p -i -e 's|&amp;|\&|g' lane-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?>/||g' lane-lexicon.xml
	perl -p -i -e 's|[a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?">||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" \$" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part="[a-zA-Z]+?" \*" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part"[a-zA-Z]+?">||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 part"N"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree >||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|<form type="[a-zA-Z]+? [a-zA-Z]+?">||g' lane-lexicon.xml
	perl -p -i -e 's|<form type="[a-zA-Z]+?">||g' lane-lexicon.xml
	perl -p -i -e 's|=||g' lane-lexicon.xml
	perl -p -i -e 's|\*" >||g' lane-lexicon.xml
	perl -p -i -e 's|― - |―|g' lane-lexicon.xml
	perl -p -i -e 's|<H>||g' lane-lexicon.xml
	perl -p -i -e 's|<orth orig="[a-b]+"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|<orth orig="[a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<orth orig"[a-zA-Z]+"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|part="[a-zA-Z]+?" [a-zA-Z]+?[0-9]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|part"[a-zA-Z]+?" [a-zA-Z]+?"[a-zA-Z]+?"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|" part="[a-zA-Z]+?">||g' lane-lexicon.xml
	perl -p -i -e 's|" part="[a-zA-Z]+?"||g' lane-lexicon.xml
	perl -p -i -e 's|<pb [0-9]+"/>||g' lane-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0"||g' lane-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" [a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" >||g' lane-lexicon.xml
	perl -p -i -e 's|<\?xml versio1.0" part="[a-zA-Z]+?" \$" >||g' lane-lexicon.xml
	perl -p -i -e 's|<div2 n"\$"\W+>||g' lane-lexicon.xml
	perl -p -i -e 's|>| |g' lane-lexicon.xml
	 
}

fifth_Cleanup(){
	perl -p -i -e 's|\n| |g' lane-lexicon.xml
	perl -p -i -e 's#((―|-)*b[0-9]+(―|-)+)#\n\n[$1]#g' lane-lexicon.xml
	perl -p -i -e 's#((―|-)*a[0-9]+(―|-)+)#\n\n[$1]#g' lane-lexicon.xml
	perl -p -i -e 's#((―|-)*B[0-9]+(―|-)+)#\n\n[$1]#g' lane-lexicon.xml
	perl -p -i -e 's#((―|-)*A[0-9]+(―|-)+)#\n\n[$1]#g' lane-lexicon.xml
	perl -p -i -e 's|_____|\n\n_____\n\n|g' lane-lexicon.xml
	perl -p -i -e 's|######|\n|g' lane-lexicon.xml	
	perl -p -i -e 's|  +| |g' lane-lexicon.xml
}

convert_2_dictd(){
dictfmt --utf8 -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" -c5 lane-lexicon < lane-lexicon.xml
}

cleanup(){
rm -rfv lane-lexicon.xml
mkdir dictd-lane_ara_eng-lexicon && mv -v lane-lexicon.dict lane-lexicon.index dictd-lane_ara_eng-lexicon/
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
