#!/bin/sh

# The purpose of this script is to check the compliance
# of an installation of NFIQ2.0 from the disribution tar
# ball from the original NFIQ developed, tested, and 
# published by NIST.

# This script takes the path to local nfiq and runs it
# on 179 fingerprint images in complianceTestSet
# directory which are a subset of FVC dataset. 
# It will generate the file my_nfiq_numbers.txt 
# which has the format "imageName;nfiq" 
# and then compares this file with complianceTest_NFIQ2_scores.csv
# which is the "groundtruth" nfiq2.0 numbers of the set images
# in the compliance_testset directory. 


# Elham Tabassi
# NIST December 2015

display_usage() { 
	echo "NFIQ2.0 compliance test."
	echo "This script accepts path to the exceutable or uses the executable in NFIQ2/bin/NFIQ2 as default." 
	echo -e "\nUsage:\n$0 [NFIQ2.0_path] \n" 
	} 

if [ $# -ge 2 ] ; then
   display_usage
   exit 1
fi

if [ $# -eq 0 ] ; then
   echo "Running compliance test for ../NFIQ2/bin/NFIQ2 ..."
   nfiqPath=../NFIQ2/bin/NFIQ2
fi

# If one and only one command line argument ...
if [ $# -eq 1 ] ; then
    # Set store first argument
    nfiqPath=$1
   echo "Running compliance test for $nfiqPath ..."
fi

echo NFIQ 2.0 COMPLIANCE TEST STARTS NOW

# run nfiq for fingerprint images in compliance test set
# and store them in my_nfiq_numbers.txt
rm -f my_nfiq_numbers.txt

# run NFIQ for each image
$nfiqPath BATCH fpImageList.txt BMP my_nfiq_numbers.txt false false

# compare nfiq numbers with what NIST has provided
# ignore changes in amount of white space.
# report only if the files differ, not the details of the differences
diff --ignore-space-change -q -s my_nfiq_numbers.txt complianceTest_NFIQ2_scores.csv

echo ""
echo NFIQ COMPLIANCE TEST OF \($nfiqPath\) COMPLETED

