#!/bin/sh

texmf="$HOME/texmf/tex/latex/citegit"
mkdir -pv "$texmf"
cp -v src/* "$texmf"
sed -i "s|citegit@path{\.|citegit@path{$texmf|" "$texmf/citegit.sty"
