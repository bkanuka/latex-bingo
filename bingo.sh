#!/bin/bash

node=( AA AB AC AD AE BA BB BC BD BE CA CB CD CE DA DB DC DD DE EA EB EC ED EE )

cat > bingo.tex << EOF
\documentclass{article}
\usepackage{xstring}
\usepackage[none]{hyphenat}
\usepackage{tikz}
\usetikzlibrary{calc}
\usepackage[margin=2.0cm]{geometry}
\renewcommand{\familydefault}{\sfdefault}

\newcommand{\Size}{3cm}% Adjust size of square as desired

\def\NumOfColumns{5}%
\def\Sequence{1/A, 2/B, 3/C, 4/D, 5/E}% This needs to match \NumOfColumns 

\tikzset{Square/.style={
    inner sep=0pt,
    text width=\Size, 
    minimum size=\Size,
    draw=black,
    align=center
    }
}
EOF

i=0
OLDIFS=$IFS
IFS=$'\n'
for line in $(sort -R squares | head -n 24)
do
    echo "\newcommand{\Node${node[i]}}{$line}%" >> bingo.tex
    (( i++ ))
done
IFS=$OLDIFS


echo "\newcommand{\NodeCC}{\includegraphics[width=0.9\textwidth]{marwan.png}}%" >> bingo.tex

cat >> bingo.tex << EOF
\pagestyle{empty}

\begin{document}
\centering
% Optional Title
\vspace*{\fill}
    \begin{center}
        \begin{tikzpicture}[draw=black, ultra thick, x=\Size,y=\Size]
            \node at (0.5,-0.8) {\Huge B};
            \node at (1.5,-0.8) {\Huge I};
            \node at (2.5,-0.8) {\Huge N};
            \node at (3.5,-0.8) {\Huge G};
            \node at (4.5,-0.8) {\Huge O};
            \foreach \col/\colLetter in \Sequence {%
                \foreach \row/\rowLetter in \Sequence{%
                    \pgfmathtruncatemacro{\value}{\col+\NumOfColumns*(\row-1)}
                    \def\NodeText{\expandafter\csname Node\rowLetter\colLetter\endcsname}
                    \node [Square] at (\$(\col,-\row)-(0.5,0.5)\$) {\NodeText};
                }
            }
        \end{tikzpicture}
    \end{center}
\vspace*{\fill}
\end{document}
EOF

pdflatex bingo.tex
