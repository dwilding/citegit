#!/bin/sh

git log -1 --format=%$1 -- $2
