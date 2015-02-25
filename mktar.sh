#!/bin/bash

PROJNAME=$(debian/haskell-extract-changelog-name-version.sh name)
VERSION=$(debian/haskell-extract-changelog-name-version.sh version)

rm -rf $PROJNAME-$VERSION
rm -f $PROJNAME-$VERSION.tar.gz

rsync -avP --exclude=".cabal-sandbox" --exclude="cabal.sandbox.config" --exclude="dist" --exclude=".git" $PROJNAME/ $PROJNAME-$VERSION
tar czvf $PROJNAME-$VERSION.tar.gz $PROJNAME-$VERSION
