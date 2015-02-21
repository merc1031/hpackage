#!/bin/sh
set -e

BASEDIR=$(cd "$(dirname "$0")"/..; pwd -P)
cd $BASEDIR

PROJNAME=$($BASEDIR/debian/haskell-extract-changelog-name-version.sh name)
VERSION=$($BASEDIR/debian/haskell-extract-changelog-name-version.sh version)

ORIGTGZ=$PROJNAME'_'$VERSION'.orig.tar.gz'

set -x verbose
cd $BASEDIR/..
rm -f $ORIGTGZ
tar czf $ORIGTGZ hpackage/bundled-dependencies hpackage/licenses.csv hpackage/$PROJNAME-$VERSION.tar.gz
