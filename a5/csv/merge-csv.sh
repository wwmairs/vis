#!/bin/bash


output_file=$1

i=0

files=$(ls *.csv )
echo $files
for filename in $files; do
  echo $i
  if [ $i = 0 ] ; then
    # copy csv headers from first file
    echo "first file"
    head -n 1 $filename > $output_file
  fi
  echo $i "common part"
  # copy csv without headers from other files
  tail -n +2 $filename >> $output_file
  i=$(( $i + 1 ))
done
