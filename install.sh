#!/bin/sh

texmf="$HOME/texmf/tex/latex/citegit"
mkdir -pv "$texmf"
cp -v src/* "$texmf"
cd "$texmf"
chmod -v +x *.sh
sed -i "s|citegit@path{\.|citegit@path{$texmf|" citegit.sty
