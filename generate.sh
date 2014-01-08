#!/bin/bash
for i in {1..8}
do
    ./bingo.sh
    mv bingo.pdf ${i}.pdf
    lp ${i}.pdf
    rm ${i}.pdf
done
rm bingo.aux bingo.log bingo.tex
