#!/bin/bash

FILENAME=$1

perl -p -i -e  \
   's|&lt;|<|g; \
	s|&gt;|>|g; \
	s|&amp;|\&|g; \
	s|&quot;|"|g;' $FILENAME

perl -p -i -e "s|&apos;|'|g;" $FILENAME

#perl -p -i -e \
#   's|<FONT COLOR="DarkGoldenRod">|<c c="#B8860B">|g; \
#	s|<FONT COLOR="DarkGray">|<c c="#A9A9A9>|g; \
#	s|<FONT COLOR="DarkGreen">|<c c="#006400>|g; \
#	s|<FONT COLOR="DarkMagenta">|<c c="#8B008B">|g; \
#	s|<FONT COLOR="DarkOliveGreen">|<c c="#556B2F">|g; \
#	s|<FONT COLOR="DarkRed">|<c c="#8B0000">|g; \
#	s|<FONT COLOR="DarkSlateGray">|<c c="#2F4F4F">|g; \
#	s|<FONT COLOR="Indigo">|<c c="#4B0082">|g; \
#	s|<FONT COLOR="MediumBlue">|<c c="#0000CD">|g; \
#	s|<FONT COLOR="SaddleBrown">|<c c="#8B4513">|g; \
#	s|<FONT COLOR="Teal">|<c c="#008080">|g; \
#	s|</FONT>|</c>|g; \
#	s|<FONT COLOR="Black">|<c c="#000000">|g; \
#	s|  +| |g; \
#	s|  +| |g;' $FILENAME

