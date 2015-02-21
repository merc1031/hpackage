#!/bin/bash

PROJNAME=$(debian/haskell-extract-changelog-name-version.sh name)
VERSION=$(debian/haskell-extract-changelog-name-version.sh version)
rsync -avP --exclude=".cabal-sandbox" --exclude="cabal.sandbox.config" --exclude="dist" --exclude=".git" $PROJNAME $PROJNAME-$VERSION
tar czvf $PROJNAME-$VERSION.tar.gz $PROJNAME-$VERSION
#maybe cabal sdist ... IS idiotic
