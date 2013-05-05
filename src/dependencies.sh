#!/bin/sh

for file in GNUmakefile makefile Makefile
do
	if [ -f $file ]
	then
		depends=$(grep $2: $file | cut -d ':' -f 2-)

		if [ -n "$depends" ]
		then
			break
		fi
	fi
done

if [ -z "$depends" ]
then
	depends="$(egrep '\\input|\\include' $1 |
sed -n 's/^[ \t]*\(\\input\|\\include\){\([^\.]*\)\(\.tex\)*}/\2\.tex/p' |
tr '\n' ' ')$1"
fi

for file in $depends
do
	echo -n ' '

	if [ -h $file ]
	then
		readlink -n $file
	else
		echo -n $file
	fi
done
