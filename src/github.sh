#!/bin/sh

git remote -v |
sed -n 's/.*git@github.com:\(.*\)\.git.*/\1/p' |
head -1
