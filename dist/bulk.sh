#!/bin/bash

for file in *; do if [ -d $file ]; then cd $file && ../create_dl_table.sh && cd ..; fi; done

