#!/bin/bash

INPUT=input
VALID_PASSPORTS=0
BLA=$(cat ${INPUT} | sed -e s'/^$/§/')
ARRAY=()
PASSPORT=0

OIFS=$IFS
IFS=$'§'
for i in  $BLA
do
  ARRAY+=($i)
done
IFS=$OIFS

while [ $PASSPORT -lt  ${#ARRAY[@]} ]
do
  RF_BYR=0
  RF_IYR=0
  RF_EYR=0
  RF_HGT=0
  RF_HCL=0
  RF_ECL=0
  RF_PID=0
  RF_CID=0
  for x in ${ARRAY[${PASSPORT}]}
  do
    KEY="${x%%:*}"
    VALUE="${x##*:}"
    [ "$KEY" = "byr" ] && RF_BYR=1
    [ "$KEY" = "iyr" ] && RF_IYR=1
    [ "$KEY" = "eyr" ] && RF_EYR=1
    [ "$KEY" = "hgt" ] && RF_HGT=1
    [ "$KEY" = "hcl" ] && RF_HCL=1
    [ "$KEY" = "ecl" ] && RF_ECL=1
    [ "$KEY" = "pid" ] && RF_PID=1
    [ "$KEY" = "cid" ] && RF_CID=1
    done
  PASSPORT=$((++PASSPORT))
  if [[ $RF_BYR -eq 1 && $RF_IYR -eq 1 && $RF_EYR -eq 1 && $RF_HGT -eq 1 && $RF_HCL -eq 1 && $RF_ECL -eq 1 && $RF_PID -eq 1 ]]; then
    VALID_PASSPORTS=$((++VALID_PASSPORTS)) 
  fi
done

echo "The answer is: $VALID_PASSPORTS";