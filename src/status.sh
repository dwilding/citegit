#!/bin/sh

git status --porcelain --untracked-files$1 -- $2
