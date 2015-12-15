#!/bin/bash

cp -rfv Source/mawrid_dict.txt mawrid_dict.csv 

cleanup_json_stuff(){
	perl -p -i -e \
		's#_id|direction|word|word2|mean##g; \
		s|\{"means":|<br><br>|g; \
		s|\{"phrases"|<br><br>|g; \
		s|\{"trans":|<br><br>|g; \
		s|\{"ara_trans":|<br><br>|g; \
		s#^[0-9]+\|[0-9]+\|##g; \
		s|\{"\w+":|\n|g; \
		s|"\w+":| |g; \
		s|,  \[| |g; \
		s|\[ "",| |g; \
		s|"}]},| |g; \
		s|"}]}]},| |g; \
		s|"}]}]}]}| |g; \
		s|,  ""| |g; \
		s|"]}]}]}]}| |g; \
		s|"}]}| |g; \
		s|"]}]}]}| |g; \
		s|"]},| |g; \
		s|"" ]}]}]}]}| |g; \
		s|"" ]},| |g; \
		s|"" ]}]}]},| |g; \
		s#\n|| "", \[ \[ \[]}]}]}##g; \
		s|\{"":"| |g; \
		s|"\},| |g; \
		s|\}],| |g; \
		s|":| |g; \
		s|\}| |g; \
		s|\[| |g; \
		s|\]| |g; \
		s|"\W*?"| |g; \
		s|"| |g; \
		s#\|\|#\|#g; \
		s#\|#; #g; \
		s|<br><br> <br><br>|<br><br>|g; \
		s| , |, |g; \
		s|(\(+[^(\n\r].+?\)+)|<FONT COLOR="DarkGoldenRod">$1</FONT>|g; \
		s|[ ]{2,}| |g;' mawrid_dict.csv
		
}

convert2StarDictWithLINGUAE(){
	 python linguae/linguae.py mawrid_dict.csv
}

echo Stage 1 cleanup_json_stuff
cleanup_json_stuff

editpadpro7 mawrid_dict.csv

echo Stage 2 convert2StarDictWithLINGUAE
convert2StarDictWithLINGUAE

exit $?
