#!/bin/bash

0_xml_merge(){
	cat ../lane/*.xml > lane-lexicon.xml
}

1_firstCleanup(){
	perl -p -i -e 's|^\s+||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree|\n\n_____\n\n<entryFree|g' lane-lexicon.xml
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<itype>.*?</itype>||g' lane-lexicon.xml
	perl -p -i -e 's|<entryFree>\s+<form>\s+<orth|<entryFree><form><orth|g' lane-lexicon.xml
	perl -p -i -e 's|</orth>|\n</orth>|g' lane-lexicon.xml
	perl -p -i -e 's|<|LESSTHAN|g' lane-lexicon.xml
	perl -p -i -e 's|>|GREATERTHAN|g' lane-lexicon.xml
	perl -p -i -e 's|"|QUOTEQUOTE|g' lane-lexicon.xml
	perl -p -i -e 's|=|SIGNEEGAL|g' lane-lexicon.xml
}

2_convert2_dictd(){
	dictfmt --utf8 -u dfmcreator@gmail.com -s "Lane Arabic-English Lexicon" -c5 lane-lexicon < lane-lexicon.xml
}

3_convert2STARDICTwithMAKEDICT(){
	./makedict -i dictd -o stardict lane-lexicon.index
}

4_convert2CSVwithLINGUAE(){
	dict=`readlink --no-newline --quiet --silent -f stardict-lane-lexicon-2.4.2/lane-lexicon.dict`
	python linguae/linguae.py "$dict"
}

5_secondCleanup(){
	perl -p -i -e 's|LESSTHAN|<|g' lane-lexicon.csv
	perl -p -i -e 's|GREATERTHAN|>|g' lane-lexicon.csv
	perl -p -i -e 's|QUOTEQUOTE|"|g' lane-lexicon.csv
	perl -p -i -e 's|SIGNEEGAL|=|g' lane-lexicon.csv
	perl -p -i -e 's|<br>| |g' lane-lexicon.csv
	perl -p -i -e 's|lessthanentryfree||g' lane-lexicon.csv
	perl -p -i -e 's|idsigneegalquotequoten[0-9]+quotequote||g' lane-lexicon.csv
	perl -p -i -e 's|keysigneegalquotequote||g' lane-lexicon.csv
	perl -p -i -e 's|quotequote||g' lane-lexicon.csv
	perl -p -i -e 's|typesigneegalmain||g' lane-lexicon.csv
	perl -p -i -e 's|greaterthan||g' lane-lexicon.csv
	perl -p -i -e 's|typesigneegalmaingreaterthan||g' lane-lexicon.csv
	perl -p -i -e 's|typesigneegalquotequotemainquotequotegreaterthan||g' lane-lexicon.csv
	perl -p -i -e 's|[a-z]+?="[a-z]+?\s*[a-z]*?"||g' lane-lexicon.csv
	perl -p -i -e 's|n="*"||g' lane-lexicon.csv
	perl -p -i -e 's|[a-z]+?="[a-z]*?[0-9]+?"||g' lane-lexicon.csv
	perl -p -i -e 's|<entryFree\s*?[a-z]+?="(\w+?\W*?\w*?)"\s*?>|<entryFree>$1|g' lane-lexicon.csv
	perl -p -i -e 's|<entryFree\s*?[a-z]+?="(.+?)"\s*?>|<entryFree>$1|g' lane-lexicon.csv
	perl -p -i -e 's|<form\W+?>|<form>|g' lane-lexicon.csv
	perl -p -i -e 's|<head\W+?>|<head>|g' lane-lexicon.csv
	perl -p -i -e 's|<foreign\W+?>|<foreign>|g' lane-lexicon.csv
	perl -p -i -e 's|<hi\W+?>|<hi>|g' lane-lexicon.csv
	perl -p -i -e 's|<orth\W+?[a-z]+?=""\s*>|<orth>|g' lane-lexicon.csv
	perl -p -i -e 's|<orth\W+?>|<orth>|g' lane-lexicon.csv
	perl -p -i -e 's|<itype>[0-9]+</itype>||g' lane-lexicon.csv
	perl -p -i -e 's|<itype>.*?</itype>||g' lane-lexicon.csv
	perl -p -i -e 's|(\s+\s+)+| |g' lane-lexicon.csv
	perl -p -i -e 's|^\s+||g' lane-lexicon.csv

	#s|(<entryFree>\W*?(<form>)+?\W*?(<orth>)+?\W*?(.*?)(</orth>)+?)|lane-lexicon.xml\t|g' lane-lexicon.csv
}

6_thirdCleanup(){
	perl -p -i -e 's|<analytic/>||g' lane-lexicon.csv
	perl -p -i -e 's|</author>||g' lane-lexicon.csv
	perl -p -i -e 's|<author>||g' lane-lexicon.csv
	perl -p -i -e 's|</authority>||g' lane-lexicon.csv
	perl -p -i -e 's|<authority>||g' lane-lexicon.csv
	perl -p -i -e 's|</availability>||g' lane-lexicon.csv
	perl -p -i -e 's|<availability >||g' lane-lexicon.csv
	perl -p -i -e 's|</biblStruct>||g' lane-lexicon.csv
	perl -p -i -e 's|<biblStruct>||g' lane-lexicon.csv
	perl -p -i -e 's|</body>||g' lane-lexicon.csv
	perl -p -i -e 's|<body>||g' lane-lexicon.csv
	perl -p -i -e 's|</cell>||g' lane-lexicon.csv
	perl -p -i -e 's|<cell >||g' lane-lexicon.csv
	perl -p -i -e 's|</date>||g' lane-lexicon.csv
	perl -p -i -e 's|<date>||g' lane-lexicon.csv
	perl -p -i -e 's|</div1>||g' lane-lexicon.csv
	perl -p -i -e 's|<div1||g' lane-lexicon.csv
	perl -p -i -e 's|</div2>||g' lane-lexicon.csv
	perl -p -i -e 's|<div2 >||g' lane-lexicon.csv
	perl -p -i -e 's|encoding="UTF-8"\?>||g' lane-lexicon.csv
	perl -p -i -e 's|</fileDesc>||g' lane-lexicon.csv
	perl -p -i -e 's|<fileDesc>||g' lane-lexicon.csv
	perl -p -i -e 's#</foreign>#FOREIGNCLOSE#g' lane-lexicon.csv
	perl -p -i -e 's|<foreign>|FOREIGNOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</dictScrap>|DICTSCRAPCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<dictScrap>|DICTSCRAPOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</form>|FORMCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<form>|FORMOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</orth>|ORTHCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<orth>|ORTHOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</G>|GCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<G/>|GCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<G>|GOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|<H>165</H>||g' lane-lexicon.csv
	perl -p -i -e 's|</head>|HEADCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<head>|HEADOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</hi>|HICLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<hi>|HIOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</itype>|ITYPECLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<itype>|ITYPEOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</quote>|QUOTECLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<quote>|QUOTEOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</sense>|SENSECLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<sense>|SENSEOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</H>||g' lane-lexicon.csv
	perl -p -i -e 's|<H/>||g' lane-lexicon.csv
	perl -p -i -e 's|</imprint>||g' lane-lexicon.csv
	perl -p -i -e 's|<imprint>||g' lane-lexicon.csv
	perl -p -i -e 's|</item> | |g' lane-lexicon.csv
	perl -p -i -e 's|<item>| |g' lane-lexicon.csv
	perl -p -i -e 's|</listBibl>| |g' lane-lexicon.csv
	perl -p -i -e 's|<listBibl>| |g' lane-lexicon.csv
	perl -p -i -e 's|</list>| |g' lane-lexicon.csv
	perl -p -i -e 's|<list>| |g' lane-lexicon.csv
	perl -p -i -e 's|</L>|LCLOSE|g' lane-lexicon.csv
	perl -p -i -e 's|<L>|LOPEN|g' lane-lexicon.csv
	perl -p -i -e 's|</monogr>| |g' lane-lexicon.csv
	perl -p -i -e 's|<monogr>| |g' lane-lexicon.csv
	perl -p -i -e 's|</note>| |g' lane-lexicon.csv
	perl -p -i -e 's|<note >| |g' lane-lexicon.csv
	perl -p -i -e 's|</notesStmt>| |g' lane-lexicon.csv
	perl -p -i -e 's|<notesStmt>| |g' lane-lexicon.csv
	perl -p -i -e 's|<pb>||g' lane-lexicon.csv
	perl -p -i -e 's|<pb >||g' lane-lexicon.csv
	perl -p -i -e 's|<pb />||g' lane-lexicon.csv
	perl -p -i -e 's|<pb/>||g' lane-lexicon.csv
	perl -p -i -e 's|</p>||g' lane-lexicon.csv
	perl -p -i -e 's|<p>||g' lane-lexicon.csv
	perl -p -i -e 's|</publicationStmt>||g' lane-lexicon.csv
	perl -p -i -e 's|<publicationStmt>||g' lane-lexicon.csv
	perl -p -i -e 's|</publisher>||g' lane-lexicon.csv
	perl -p -i -e 's|<publisher>||g' lane-lexicon.csv
	perl -p -i -e 's|</pubPlace>||g' lane-lexicon.csv
	perl -p -i -e 's|<pubPlace>||g' lane-lexicon.csv
	perl -p -i -e 's|</row>||g' lane-lexicon.csv
	perl -p -i -e 's|<row >||g' lane-lexicon.csv
	perl -p -i -e 's|</sourceDesc>||g' lane-lexicon.csv
	perl -p -i -e 's|<sourceDesc>||g' lane-lexicon.csv
	perl -p -i -e 's|</Table>||g' lane-lexicon.csv
	perl -p -i -e 's|<Table>||g' lane-lexicon.csv
	perl -p -i -e 's|</TEI.2>||g' lane-lexicon.csv
	perl -p -i -e 's|<TEI.2>||g' lane-lexicon.csv
	perl -p -i -e 's|</teiHeader>||g' lane-lexicon.csv
	perl -p -i -e 's|<teiHeader >||g' lane-lexicon.csv
	perl -p -i -e 's|</text>||g' lane-lexicon.csv
	perl -p -i -e 's|</text>||g' lane-lexicon.csv
	perl -p -i -e 's|<text>||g' lane-lexicon.csv
	perl -p -i -e 's|</title>||g' lane-lexicon.csv
	perl -p -i -e 's|<title>||g' lane-lexicon.csv
	perl -p -i -e 's|</titleStmt>||g' lane-lexicon.csv
	perl -p -i -e 's|<titleStmt>||g' lane-lexicon.csv
	perl -p -i -e 's|<?xml version="1.0"||g' lane-lexicon.csv
	perl -p -i -e 's|<entryFree>||g' lane-lexicon.csv
	perl -p -i -e 's|</entryFree>||g' lane-lexicon.csv
	perl -p -i -e 's|DICTSCRAPCLOSE||g' lane-lexicon.csv
	perl -p -i -e 's|DICTSCRAPOPEN||g' lane-lexicon.csv
	perl -p -i -e 's|GCLOSE||g' lane-lexicon.csv
	perl -p -i -e 's|GOPEN||g' lane-lexicon.csv
	perl -p -i -e 's|&amp;|\&|g' lane-lexicon.csv
	perl -p -i -e 's|amp;|\&|g' lane-lexicon.csv
	perl -p -i -e 's|&gt;|>|g' lane-lexicon.csv
	perl -p -i -e 's|&lt;|<|g' lane-lexicon.csv
	perl -p -i -e 's|&quot;|"|g' lane-lexicon.csv
	perl -p -i -e 's|&&|\&|g' lane-lexicon.csv
}

7_putSomeColors(){
perl -p -i -e 's|FOREIGNOPEN|<b><FONT COLOR="DarkGreen">|g' lane-lexicon.csv
	perl -p -i -e 's#FOREIGNCLOSE#</FONT></b>#g' lane-lexicon.csv

	perl -p -i -e 's|HEADOPEN|<i><FONT COLOR="MediumBlue">|g' lane-lexicon.csv
	perl -p -i -e 's|HEADCLOSE|</FONT></i>|g' lane-lexicon.csv

	perl -p -i -e 's|SENSEOPEN|<b><FONT COLOR="DarkGray">|g' lane-lexicon.csv
	perl -p -i -e 's|SENSECLOSE|</FONT></b>|g' lane-lexicon.csv

	perl -p -i -e 's|QUOTEOPEN|<I>|g' lane-lexicon.csv
	perl -p -i -e 's|QUOTECLOSE|</I>|g' lane-lexicon.csv

	perl -p -i -e 's|HIOPEN|<i><b><FONT COLOR="Black">|g' lane-lexicon.csv
	perl -p -i -e 's|HICLOSE|</FONT></b></i>|g' lane-lexicon.csv

	perl -p -i -e 's|ORTHOPEN|<b><FONT COLOR="DarkMagenta">|g' lane-lexicon.csv
	perl -p -i -e 's|ORTHCLOSE|</FONT></b>|g' lane-lexicon.csv

	perl -p -i -e 's|ITYPEOPEN|<FONT COLOR="DarkOliveGreen">|g' lane-lexicon.csv
	perl -p -i -e 's|ITYPECLOSE|</FONT>|g' lane-lexicon.csv

	perl -p -i -e 's|LOPEN|<FONT COLOR="DarkSlateGray">|g' lane-lexicon.csv
	perl -p -i -e 's|LCLOSE|</FONT>|g' lane-lexicon.csv

	perl -p -i -e 's|FORMCLOSE|</FONT>|g' lane-lexicon.csv
	perl -p -i -e 's|FORMOPEN|<FONT COLOR="Indigo">|g' lane-lexicon.csv

	perl -p -i -e 's|HEADOPEN|<FONT COLOR="SaddleBrown">|g' lane-lexicon.csv
	perl -p -i -e 's|HEADCLOSE|</FONT>|g' lane-lexicon.csv

	perl -p -i -e 's|<FONT| <FONT|g' lane-lexicon.csv
	perl -p -i -e 's|  +| |g' lane-lexicon.csv
}

8_putSomeMoreColors(){
	perl -p -i -e 's|― - |―|g' lane-lexicon.csv
	perl -p -i -e 's#((―|-)*b[0-9]+(―|-)+)#<br><br><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g' lane-lexicon.csv
	perl -p -i -e 's#((―|-)*B[0-9]+(―|-)+)#<br><br><b><FONT COLOR="DarkRed">[$1]</FONT></b>#g' lane-lexicon.csv
	perl -p -i -e 's#((―|-)*a[0-9]+(―|-)+)#<br><br><b><FONT COLOR="Teal">[$1]</FONT></b>#g' lane-lexicon.csv
	perl -p -i -e 's#((―|-)*A[0-9]+(―|-)+)#<br><br><b><FONT COLOR="Teal">[$1]</FONT></b>#g' lane-lexicon.csv
	perl -p -i -e 's|(\(+.+?\)+)|<FONT COLOR="DarkGoldenRod">$1</FONT>|g' lane-lexicon.csv
	perl -p -i -e 's|\W+">|">|g' lane-lexicon.csv
	perl -p -i -e 's|&amp,amp,|\&|g' lane-lexicon.csv
	perl -p -i -e 's|&amp;|\&|g' lane-lexicon.csv
	perl -p -i -e 's|&amp|\&|g' lane-lexicon.csv
}

9_convert2STARDICTwithLINGUAE(){
	dict=`readlink --no-newline --quiet --silent -f lane-lexicon.csv`
	python linguae/linguae.py "$dict"
}

clean_up(){
	echo "Will delete files in 10 seconds"
	echo "Interrupt the script if you want to keep them"
	sleep 10 &&	rm -rfv lane-lexicon.xml lane-lexicon.dict lane-lexicon.index stardict-lane-lexicon-2.4.2
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
