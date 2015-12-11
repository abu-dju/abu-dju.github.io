#!/bin/bash

0_xml_merge(){
	cp -rfv ../salmone/usalmone.xml salmone-lexicon.xml
}

1_firstCleanup(){
perl -p -i -e 's|^\s+||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree|\n\n_____\n\n<entryFree|g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' salmone-lexicon.xml
	perl -p -i -e 's|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g' salmone-lexicon.xml
	perl -p -i -e 's|</orth>|\n</orth>|g' salmone-lexicon.xml
	perl -p -i -e 's|<|LESSTHAN|g' salmone-lexicon.xml
	perl -p -i -e 's|>|GREATERTHAN|g' salmone-lexicon.xml
	perl -p -i -e 's|"|QUOTEQUOTE|g' salmone-lexicon.xml
	perl -p -i -e 's|=|SIGNEEGAL|g' salmone-lexicon.xml
}

2_convert2_dictd(){
	dictfmt --utf8 -u dfmcreator@gmail.com -s "Salmone Arabic-English Lexicon" -c5 salmone-lexicon < salmone-lexicon.xml
}

3_convert2STARDICTwithMAKEDICT(){
	./makedict -i dictd -o stardict salmone-lexicon.index
}

4_convert2CSVwithLINGUAE(){
	dict=`readlink --no-newline --quiet --silent -f stardict-salmone-lexicon-2.4.2/salmone-lexicon.dict`
	python linguae/linguae.py "$dict"
}

5_secondCleanup(){
	perl -p -i -e 's|LESSTHAN|<|g' salmone-lexicon.csv
	perl -p -i -e 's|GREATERTHAN|>|g' salmone-lexicon.csv
	perl -p -i -e 's|QUOTEQUOTE|"|g' salmone-lexicon.csv
	perl -p -i -e 's|SIGNEEGAL|=|g' salmone-lexicon.csv
	perl -p -i -e 's|<br>| |g' salmone-lexicon.csv
	perl -p -i -e 's|keysigneegalquotequoteاquotequote[0-9]+typesigneegalquotequotemainquotequotegreaterthan||g' salmone-lexicon.csv
	perl -p -i -e 's|typesigneegalquotequotemainquotequotegreaterthan||g' salmone-lexicon.csv
	perl -p -i -e 's|idsigneegalquotequoten[0-9]+quotequote||g' salmone-lexicon.csv
	perl -p -i -e 's|idsigneegalquotequoten[0-9]+quotequote||g' salmone-lexicon.csv
	perl -p -i -e 's|typesigneegalmaingreaterthan||g' salmone-lexicon.csv
	perl -p -i -e 's|keysigneegalquotequote||g' salmone-lexicon.csv
	perl -p -i -e 's|lessthanentryfree||g' salmone-lexicon.csv
	perl -p -i -e 's|typesigneegalmain||g' salmone-lexicon.csv
	perl -p -i -e 's|greaterthan||g' salmone-lexicon.csv
	perl -p -i -e 's|quotequote||g' salmone-lexicon.csv
	perl -p -i -e 's|[a-z]+?="[a-z]+?\s*[a-z]*?"||g' salmone-lexicon.csv
	perl -p -i -e 's|n="*"||g' salmone-lexicon.csv
	perl -p -i -e 's|[a-z]+?="[a-z]*?[0-9]+?"||g' salmone-lexicon.csv
	perl -p -i -e 's|<entryFree\s*?[a-z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g' salmone-lexicon.csv
	perl -p -i -e 's|<entryFree\s*?[a-z]+?="(.+?)"\s*?>|<entryFree>$1|g' salmone-lexicon.csv
	perl -p -i -e 's|<form\W+?>|<form>|g' salmone-lexicon.csv
	perl -p -i -e 's|<head\W+?>|<head>|g' salmone-lexicon.csv
	perl -p -i -e 's|<foreign\W+?>|<foreign>|g' salmone-lexicon.csv
	perl -p -i -e 's|<hi\W+?>|<hi>|g' salmone-lexicon.csv
	perl -p -i -e 's|<orth\W+?[a-z]+?=""\s*>|<orth>|g' salmone-lexicon.csv
	perl -p -i -e 's|<orth\W+?>|<orth>|g' salmone-lexicon.csv
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' salmone-lexicon.csv
	perl -p -i -e 's|<itype>.*?</itype>||g' salmone-lexicon.csv
	perl -p -i -e 's|(\s+\s+)+| |g' salmone-lexicon.csv
	perl -p -i -e 's|^\s+||g' salmone-lexicon.csv
	#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|$1\t|g' salmone-lexicon.csv

}

6_thirdCleanup(){
	perl -p -i -e 's|<analytic/>||g' salmone-lexicon.csv
	perl -p -i -e 's|</author>||g' salmone-lexicon.csv
	perl -p -i -e 's|<author>||g' salmone-lexicon.csv
	perl -p -i -e 's|</authority>||g' salmone-lexicon.csv
	perl -p -i -e 's|<authority>||g' salmone-lexicon.csv
	perl -p -i -e 's|</availability>||g' salmone-lexicon.csv
	perl -p -i -e 's|<availability >||g' salmone-lexicon.csv
	perl -p -i -e 's|</biblStruct>||g' salmone-lexicon.csv
	perl -p -i -e 's|<biblStruct>||g' salmone-lexicon.csv
	perl -p -i -e 's|</body>||g' salmone-lexicon.csv
	perl -p -i -e 's|<body>||g' salmone-lexicon.csv
	perl -p -i -e 's|</cell>||g' salmone-lexicon.csv
	perl -p -i -e 's|<cell >||g' salmone-lexicon.csv
	perl -p -i -e 's|</date>||g' salmone-lexicon.csv
	perl -p -i -e 's|<date>||g' salmone-lexicon.csv
	perl -p -i -e 's|</div1>||g' salmone-lexicon.csv
	perl -p -i -e 's|<div1||g' salmone-lexicon.csv
	perl -p -i -e 's|</div2>||g' salmone-lexicon.csv
	perl -p -i -e 's|<div2 >||g' salmone-lexicon.csv
	perl -p -i -e 's|encoding="UTF-8"\?>||g' salmone-lexicon.csv
	perl -p -i -e 's|</fileDesc>||g' salmone-lexicon.csv
	perl -p -i -e 's|<fileDesc>||g' salmone-lexicon.csv
	perl -p -i -e 's|<foreign>|FOREIGNOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</foreign>|FOREIGNCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|</dictScrap>|DICTSCRAPCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<dictScrap>|DICTSCRAPOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</form>|FORMCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<form>|FORMOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</orth>|ORTHCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<orth>|ORTHOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</G>|GCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<G/>|GCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<G>|GOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|<H>165</H>||g' salmone-lexicon.csv
	perl -p -i -e 's|</head>|HEADCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<head>|HEADOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</hi>|HICLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<hi>|HIOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</itype>|ITYPECLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<itype>|ITYPEOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</quote>|QUOTECLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<quote>|QUOTEOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</sense>|SENSECLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<sense>|SENSEOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</H>||g' salmone-lexicon.csv
	perl -p -i -e 's|<H/>||g' salmone-lexicon.csv
	perl -p -i -e 's|</imprint>||g' salmone-lexicon.csv
	perl -p -i -e 's|<imprint>||g' salmone-lexicon.csv
	perl -p -i -e 's|</item> | |g' salmone-lexicon.csv
	perl -p -i -e 's|<item>| |g' salmone-lexicon.csv
	perl -p -i -e 's|</listBibl>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<listBibl>| |g' salmone-lexicon.csv
	perl -p -i -e 's|</list>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<list>| |g' salmone-lexicon.csv
	perl -p -i -e 's|</L>|LCLOSE|g' salmone-lexicon.csv
	perl -p -i -e 's|<L>|LOPEN|g' salmone-lexicon.csv
	perl -p -i -e 's|</monogr>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<monogr>| |g' salmone-lexicon.csv
	perl -p -i -e 's|</note>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<note >| |g' salmone-lexicon.csv
	perl -p -i -e 's|</notesStmt>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<notesStmt>| |g' salmone-lexicon.csv
	perl -p -i -e 's|<pb>||g' salmone-lexicon.csv
	perl -p -i -e 's|<pb >||g' salmone-lexicon.csv
	perl -p -i -e 's|<pb />||g' salmone-lexicon.csv
	perl -p -i -e 's|<pb/>||g' salmone-lexicon.csv
	perl -p -i -e 's|</p>||g' salmone-lexicon.csv
	perl -p -i -e 's|<p>||g' salmone-lexicon.csv
	perl -p -i -e 's|</publicationStmt>||g' salmone-lexicon.csv
	perl -p -i -e 's|<publicationStmt>||g' salmone-lexicon.csv
	perl -p -i -e 's|</publisher>||g' salmone-lexicon.csv
	perl -p -i -e 's|<publisher>||g' salmone-lexicon.csv
	perl -p -i -e 's|</pubPlace>||g' salmone-lexicon.csv
	perl -p -i -e 's|<pubPlace>||g' salmone-lexicon.csv
	perl -p -i -e 's|</row>||g' salmone-lexicon.csv
	perl -p -i -e 's|<row >||g' salmone-lexicon.csv
	perl -p -i -e 's|</sourceDesc>||g' salmone-lexicon.csv
	perl -p -i -e 's|<sourceDesc>||g' salmone-lexicon.csv
	perl -p -i -e 's|</Table>||g' salmone-lexicon.csv
	perl -p -i -e 's|<Table>||g' salmone-lexicon.csv
	perl -p -i -e 's|</TEI.2>||g' salmone-lexicon.csv
	perl -p -i -e 's|<TEI.2>||g' salmone-lexicon.csv
	perl -p -i -e 's|</teiHeader>||g' salmone-lexicon.csv
	perl -p -i -e 's|<teiHeader >||g' salmone-lexicon.csv
	perl -p -i -e 's|</text>||g' salmone-lexicon.csv
	perl -p -i -e 's|</text>||g' salmone-lexicon.csv
	perl -p -i -e 's|<text>||g' salmone-lexicon.csv
	perl -p -i -e 's|</title>||g' salmone-lexicon.csv
	perl -p -i -e 's|<title>||g' salmone-lexicon.csv
	perl -p -i -e 's|</titleStmt>||g' salmone-lexicon.csv
	perl -p -i -e 's|<titleStmt>||g' salmone-lexicon.csv
	perl -p -i -e 's|<?xml version="1.0"||g' salmone-lexicon.csv
	perl -p -i -e 's|<entryFree>||g' salmone-lexicon.csv
	perl -p -i -e 's|</entryFree>||g' salmone-lexicon.csv
	perl -p -i -e 's|DICTSCRAPCLOSE||g' salmone-lexicon.csv
	perl -p -i -e 's|DICTSCRAPOPEN||g' salmone-lexicon.csv
	perl -p -i -e 's|GCLOSE||g' salmone-lexicon.csv
	perl -p -i -e 's|GOPEN||g' salmone-lexicon.csv
	perl -p -i -e 's|&amp;|\&|g' salmone-lexicon.csv
	perl -p -i -e 's|amp;|\&|g' salmone-lexicon.csv
	perl -p -i -e 's|&gt;|>|g' salmone-lexicon.csv
	perl -p -i -e 's|&lt;|<|g' salmone-lexicon.csv
	perl -p -i -e 's|&quot;|"|g' salmone-lexicon.csv
	perl -p -i -e 's|&&|\&|g' salmone-lexicon.csv
}

7_putSomeColors(){
	perl -p -i -e 's|FOREIGNOPEN|<b><FONT COLOR="DarkGreen">|g' salmone-lexicon.csv
	perl -p -i -e 's|FOREIGNCLOSE|</FONT></b>|g' salmone-lexicon.csv

	perl -p -i -e 's|HEADOPEN|<i><FONT COLOR="MediumBlue">|g' salmone-lexicon.csv
	perl -p -i -e 's|HEADCLOSE|</FONT></i>|g' salmone-lexicon.csv

	perl -p -i -e 's|SENSEOPEN|<b><FONT COLOR="DarkGray">|g' salmone-lexicon.csv
	perl -p -i -e 's|SENSECLOSE|</FONT></b>|g' salmone-lexicon.csv

	perl -p -i -e 's|QUOTEOPEN|<I>|g' salmone-lexicon.csv
	perl -p -i -e 's|QUOTECLOSE|</I>|g' salmone-lexicon.csv

	perl -p -i -e 's|HIOPEN|<i><b><FONT COLOR="Black">|g' salmone-lexicon.csv
	perl -p -i -e 's|HICLOSE|</FONT></b></i>|g' salmone-lexicon.csv

	perl -p -i -e 's|ORTHOPEN|<b><FONT COLOR="DarkMagenta">|g' salmone-lexicon.csv
	perl -p -i -e 's|ORTHCLOSE|</FONT></b>|g' salmone-lexicon.csv

	perl -p -i -e 's|ITYPEOPEN|<FONT COLOR="DarkOliveGreen">|g' salmone-lexicon.csv
	perl -p -i -e 's|ITYPECLOSE|</FONT>|g' salmone-lexicon.csv

	perl -p -i -e 's|LOPEN|<FONT COLOR="DarkSlateGray">|g' salmone-lexicon.csv
	perl -p -i -e 's|LCLOSE|</FONT>|g' salmone-lexicon.csv

	perl -p -i -e 's|FORMCLOSE|</FONT>|g' salmone-lexicon.csv
	perl -p -i -e 's|FORMOPEN|<FONT COLOR="Indigo">|g' salmone-lexicon.csv

	perl -p -i -e 's|HEADOPEN|<FONT COLOR="SaddleBrown">|g' salmone-lexicon.csv
	perl -p -i -e 's|HEADCLOSE|</FONT>|g' salmone-lexicon.csv

	perl -p -i -e 's|<FONT| <FONT|g' salmone-lexicon.csv
	perl -p -i -e 's|   | |g' salmone-lexicon.csv
	perl -p -i -e 's|  | |g' salmone-lexicon.csv
}

8_putSomeMoreColors(){
	perl -p -i -e 's|― - |―|g' salmone-lexicon.csv
	perl -p -i -e 's#((―|-)*b[0-9]+(―|-)+)#<br><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g' salmone-lexicon.csv
	perl -p -i -e 's#((―|-)*a[0-9]+(―|-)+)#<br><b><FONT COLOR="Teal">[$1]</FONT></b>#g' salmone-lexicon.csv
	perl -p -i -e 's|(\(+.+?\)+)|<FONT COLOR="DarkGoldenRod">$1</FONT>|g' salmone-lexicon.csv
	perl -p -i -e 's|\W+">|">|g' salmone-lexicon.csv
	perl -p -i -e 's|&amp,amp,|\&|g' salmone-lexicon.csv
	perl -p -i -e 's|&amp;|\&|g' salmone-lexicon.csv
	perl -p -i -e 's|&amp|\&|g' salmone-lexicon.csv

	## Salmone
	perl -p -i -e 's|<case>|<b>|g' salmone-lexicon.csv
	perl -p -i -e 's|</case>|</b>|g' salmone-lexicon.csv
	perl -p -i -e 's|<colloc>|<i>|g' salmone-lexicon.csv
	perl -p -i -e 's|</colloc>|<i>|g' salmone-lexicon.csv
	perl -p -i -e 's|<def>||g' salmone-lexicon.csv
	perl -p -i -e 's|</def>||g' salmone-lexicon.csv
	perl -p -i -e 's|<gramGrp>||g' salmone-lexicon.csv
	perl -p -i -e 's|</gramGrp>||g' salmone-lexicon.csv
	perl -p -i -e 's|<lbl>|<FONT COLOR="Purple">|g' salmone-lexicon.csv
	perl -p -i -e 's|</lbl>|</FONT>|g' salmone-lexicon.csv
	perl -p -i -e 's|<mood>|<b><FONT COLOR="DarkGray">|g' salmone-lexicon.csv
	perl -p -i -e 's|</mood>|</FONT></b>|g' salmone-lexicon.csv
	perl -p -i -e 's|<number>|<b>|g' salmone-lexicon.csv
	perl -p -i -e 's|</number>|</b>|g' salmone-lexicon.csv
	perl -p -i -e 's|<subc>|<i>|g' salmone-lexicon.csv
	perl -p -i -e 's|</subc>|</i>|g' salmone-lexicon.csv
	perl -p -i -e 's|<usg>||g' salmone-lexicon.csv
	perl -p -i -e 's|</usg>||g' salmone-lexicon.csv
	perl -p -i -e 's|<xr>||g' salmone-lexicon.csv
	perl -p -i -e 's|</xr>||g' salmone-lexicon.csv
	perl -p -i -e 's|^\s+||g' salmone-lexicon.csv
	perl -p -i -e 's|  +| |g' salmone-lexicon.csv
	perl -p -i -e 's|<sense >||g' salmone-lexicon.csv
	 
	

}

9_convert2STARDICTwithLINGUAE(){
	dict=`readlink --no-newline --quiet --silent -f salmone-lexicon.csv`
	python linguae/linguae.py "$dict"
}

clean_up(){
	echo "Will delete junk files in 10 seconds;"
	echo "interrupt the script if you want to keep them."

	sleep 10 && rm -rfv salmone-lexicon.xml salmone-lexicon.dict salmone-lexicon.index stardict-salmone-lexicon-2.4.2
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

echo Stage 4 4_convert2CSVwithLINGUAE
4_convert2CSVwithLINGUAE

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


echo Stage 10: Final: clean_up
clean_up

exit $?
