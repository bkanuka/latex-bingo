#!/usr/bin/bash

# Script to generate and print n bingo cards
n=8

for ((i=1;i<=n;i++))
do
    ./bingo.sh
    mv bingo.pdf ${i}.pdf
    # Comment out these lines to disable printing
    # and deleting
    lp ${i}.pdf
    rm ${i}.pdf
done
rm bingo.aux bingo.log bingo.tex
