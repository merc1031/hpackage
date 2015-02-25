#!/bin/bash
set -e

CABAL="$1"
SRCDIR=$2

BASEDIR=$(cd "$(dirname "$0")"/..; pwd -P)
cd $BASEDIR

BUILDDIR=$BASEDIR/debian/build-output

WORKDIR=$BASEDIR/debian/bundled-dependency-workdir
EXTRACTDIR=$WORKDIR/extracted
PACKAGEDB=$WORKDIR/packagedb
LOCALDIR=$WORKDIR/local

for PKGFILE in $(ls $BASEDIR/bundled-dependencies/*.tar.gz); do
#    PKGFILE=$BASEDIR/bundled-dependencies/$PACKAGENAME.tar.gz

    tar zxf $PKGFILE -C $EXTRACTDIR

    pushd $SRCDIR
    echo `pwd`
    echo $PKGFILE
    PKGNAME=$(basename $PKGFILE .tar.gz)
    PKGDIR=$EXTRACTDIR/$PKGNAME
    echo $PKGDIR
    $CABAL sandbox -v add-source --snapshot $PKGDIR
    popd
done

#pushd $SRCDIR
#cabal install -v $(ls .cabal-sandbox/snapshots | grep -vE 'base-[0-9]')
#popd
