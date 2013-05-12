#!/bin/sh

texmf="$HOME/texmf/tex/latex/citegit"
scriptpath="$HOME/texmf/scripts/citegit"
mkdir -pv "$texmf" "$scriptpath"
cp -v src/citegit.sty "$texmf"
cp -v src/citegit.lua "$scriptpath"
