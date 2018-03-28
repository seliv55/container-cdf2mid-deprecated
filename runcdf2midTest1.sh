#!/bin/bash

apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates

wget "https://drive.google.com/open?id=1KEL-MKwMEkCC8m8INwnZDtdzTp6kqADx" -O metdata 
wget "https://drive.google.com/open?id=17dg9W25nKg3IjSwyybwFyBUnV0J_G_3E" -O wd

runcdf2mid.R -i metdata -o cdf2midout.csv -z wd
rc=$?; 
if [[ $rc != 0 ]]; then 
	echo "R process failed with error $rc"
	exit $rc; 
fi

if [ ! -f cdf2midout.csv ]; then
   	echo "File out_exchanged.csv does not exist, failing test."
   	exit 1
fi

echo "ramid runs with test data without error codes, all expected files created."
