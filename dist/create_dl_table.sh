#!/bin/bash

rm -rfv table.html

# Create the table.html and star putting data
echo \<table\> > table.html
echo \<tr\> >> table.html
echo \<td\>File\</td\> >> table.html
echo \<td\>Creation Date\</td\> >> table.html
echo \</tr\> >> table.html

for file in *.7z
do
	echo \<tr\> >> table.html
	echo \<td\>\<a href=\"dist\/PUTLINKHERE\/`echo $file`\"\>`echo $file`\</a\>\</td\> >> table.html
	echo \<td\>`stat -c %y $file`\</td\> >> table.html
	echo \</tr\> >> table.html
done

echo \</table\> >> table.html

#\<a href=\"dist\/csv\/`echo $file`\"\>`echo $file`\</a\>
