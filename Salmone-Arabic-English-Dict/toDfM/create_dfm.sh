#!/bin/bash
# Copyright 2013, 2015 Karim Mahamane Karimou
# GNU GPL License
# This script is part of a set of scripts
# that enable the user to batch create
# DictionaryForMIDs.jar/jad files. This
# is particularly useful when one needs
# to generate jars and jads for say 50
# dictionary files (from OmegaWiki or
# Freedict for instance).
#
#This particular script needs to be put in the directory where
#the csv file and the DictionarForMIDs.properties files are.

JAVA_CMD='java -Xms256M -Xmx1500M -jar'
DFM_CREATOR='../../deps/DfM-Creator-0.7-final.jar'
CSV_DICT_FILES_DIRECTORY=`readlink --no-newline --quiet --silent -f dictionary`
CURRENT_DIR=`readlink --no-newline --quiet --silent -f .`"/"
WORKING_DIR=$CURRENT_DIR
CSV_STATIC_DIR=$CSV_DICT_FILES_DIRECTORY
CSV_FILE=`ls $WORKING_DIR/*.csv`

FONT_FILE=$HOME/bin/ArialUnicode.TTF
DICTIONARY_AND_CSVs_DIR=$WORKING_DIR/dictionary
FONT_SIZE=giant
CLIP_TOP=0
CLIP_BOTTOM=0

$JAVA_CMD $DFM_CREATOR -dg $CSV_FILE $WORKING_DIR $WORKING_DIR && \
$JAVA_CMD $DFM_CREATOR -fgc $FONT_FILE $DICTIONARY_AND_CSVs_DIR $FONT_SIZE $CLIP_TOP $CLIP_BOTTOM && \
$JAVA_CMD $DFM_CREATOR -jci $CSV_STATIC_DIR $WORKING_DIR

