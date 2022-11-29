#!/bin/bash

val=`xinput | grep "[Mm]ouse" | wc -l`
if [ $val -eq 1 ]; then
	xinput enable "SYNA7DB5:01 06CB:7DB7 Touchpad"
else
	xinput disable "SYNA7DB5:01 06CB:7DB7 Touchpad"
fi
