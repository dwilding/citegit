#!/bin/sh

repo=$(readlink -mn "$(git rev-parse --show-toplevel)")
path=$(cd $1; readlink -mn $2)
echo "${path#$repo}"
