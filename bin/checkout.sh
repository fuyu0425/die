#!/bin/bash -x

ROOT=$(git rev-parse --show-toplevel)
TMPD=$(mktemp -d /tmp/latexdiff.XXXXXXXXXX)
HERE=$(realpath --relative-to=$ROOT $(pwd))

mkdir -p $TMPD

OLD_REPO=$TMPD/old

git clone $ROOT $OLD_REPO

cd $OLD_REPO
git checkout $1

NEWD=$ROOT/$HERE
OLDD=$OLD_REPO/$HERE

make

cp -f p.pdf $NEWD/p-$1.pdf
