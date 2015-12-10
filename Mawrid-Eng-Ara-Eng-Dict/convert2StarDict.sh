#!/bin/bash

cp -rfv Source/mawrid_dict.txt mawrid_dict.csv 

cleanup_json_stuff(){
	perl -p -i -e 's#_id|direction|word|word2|mean##g' mawrid_dict.csv
	perl -p -i -e 's#^[0-9]+\|[0-9]+\|##g' mawrid_dict.csv
	perl -p -i -e 's|\{"\w+":|\n|g' mawrid_dict.csv
	perl -p -i -e 's|"\w+":| |g' mawrid_dict.csv
	perl -p -i -e 's|,  \[| |g' mawrid_dict.csv
	perl -p -i -e 's|\[ "",| |g' mawrid_dict.csv
	perl -p -i -e 's|"}]},| |g' mawrid_dict.csv
	perl -p -i -e 's|"}]}]},| |g' mawrid_dict.csv
	perl -p -i -e 's|"}]}]}]}| |g' mawrid_dict.csv
	perl -p -i -e 's|,  ""| |g' mawrid_dict.csv
	perl -p -i -e 's|"]}]}]}]}| |g' mawrid_dict.csv
	perl -p -i -e 's|"}]}| |g' mawrid_dict.csv
	perl -p -i -e 's|"]}]}]}| |g' mawrid_dict.csv
	perl -p -i -e 's|"]},| |g' mawrid_dict.csv
	perl -p -i -e 's|"" ]}]}]}]}| |g' mawrid_dict.csv
	perl -p -i -e 's|"" ]},| |g' mawrid_dict.csv
	perl -p -i -e 's|"" ]}]}]},| |g' mawrid_dict.csv
	perl -p -i -e 's#\n|| "", \[ \[ \[]}]}]}##g' mawrid_dict.csv
	perl -p -i -e 's|\{"":"| |g' mawrid_dict.csv
	perl -p -i -e 's|"\},| |g' mawrid_dict.csv
	perl -p -i -e 's|\}],| |g' mawrid_dict.csv
	perl -p -i -e 's|":| |g' mawrid_dict.csv
	perl -p -i -e 's|\}| |g' mawrid_dict.csv
	perl -p -i -e 's|\[| |g' mawrid_dict.csv
	perl -p -i -e 's|\]| |g' mawrid_dict.csv
	perl -p -i -e 's|"\W*?"| |g' mawrid_dict.csv
	perl -p -i -e 's|"| |g' mawrid_dict.csv
	perl -p -i -e 's#\|\|#\|#g' mawrid_dict.csv
	perl -p -i -e 's#\|#; #g' mawrid_dict.csv
	perl -p -i -e 's|  +| |g' mawrid_dict.csv

	#{"word":
	#{"pos":
	#{"means":
	#{"num":
	#{"phrases":
	#{"en":
	#{"trans":
	#{"ara_trans":
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
