#!/bin/bash

INPUT=input
VALID_PASSPORTS=0
BLA=$(cat ${INPUT} | sed -e s'/^$/§/')
ARRAY=()
OIFS=$IFS
IFS=$'§'
PASSPORT=0

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
    if [ "$KEY" = "byr" ]; then
      if [[ $VALUE =~ ^[0-9]{4}$ && $VALUE -ge 1920 && $VALUE -le 2002 ]]; then
        RF_BYR=1
      fi
    fi
    if [ "$KEY" = "iyr" ]; then
      if [[ $VALUE =~ ^[0-9]{4}$ && $VALUE -ge 2010 && $VALUE -le 2020 ]]; then
        RF_IYR=1
      fi
    fi
    if [ "$KEY" = "eyr" ]; then
      if [[ $VALUE =~ ^[0-9]{4}$ && $VALUE -ge 2020 && $VALUE -le 2030 ]]; then
        RF_EYR=1
      fi
    fi
    if [ "$KEY" = "hgt" ]; then
      if [[ $VALUE =~ ^([0-9]+)(cm|in)$ ]]; then
        if [[ ( "${BASH_REMATCH[2]}" = "cm" && ${BASH_REMATCH[1]} -ge 150 && ${BASH_REMATCH[1]} -le 193 ) || ( ${BASH_REMATCH[2]} = in && ${BASH_REMATCH[1]} -ge 59 && ${BASH_REMATCH[1]} -le 76 ) ]]; then
          RF_HGT=1
        fi
      fi
    fi
    if [ "$KEY" = "hcl" ]; then
      if [[ $VALUE =~ \#[a-z0-9]{6} ]]; then
        RF_HCL=1
      fi
    fi
    if [ "$KEY" = "ecl" ]; then
      if [[ $VALUE =~ ^(amb|blu|brn|gry|grn|hzl|oth)$ ]];then
        RF_ECL=1
      fi
    fi
    if [ "$KEY" = "pid" ]; then
      if [[ $VALUE =~ ^[0-9]{9}$ ]];then
        RF_PID=1
      fi
    fi
    [ "$KEY" = "cid" ] && RF_CID=1
    done
  PASSPORT=$((++PASSPORT))
  if [[ $RF_BYR -eq 1 && $RF_IYR -eq 1 && $RF_EYR -eq 1 && $RF_HGT -eq 1 && $RF_HCL -eq 1 && $RF_ECL -eq 1 && $RF_PID -eq 1 ]]; then
    VALID_PASSPORTS=$((++VALID_PASSPORTS)) 
  fi
done

echo "The answer is: $VALID_PASSPORTS"