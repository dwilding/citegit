#!/bin/sh

git log -1 --format=%$1 -- $2 |
sed -e 's/\([\\{}%&\$_]\)/\\noexpand\\\1/g' \
-e 's/\([~^]\)/\\noexpand\\\1{}/g' \
-e 's/\\\\\([@a-z]*\)/\\citegit@char@backslash{\1}/gi' \
-e 's/#\([0-9]*\)/\\noexpand\\citegit@char@number{\1}/g'
