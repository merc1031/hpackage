#!/bin/bash

set -e

SRCDIR=$1
PROJECT=$2

DEPS=$(cat $SRCDIR/cabal.config | sed -e 's/constraints://' | awk -F' ' '{print $1 $2};' | sed -e 's/==/-/' | sed -e 's/,//' | grep -vE "$PROJECT|hs-imvu|rts")

mkdir -p bundled-dependencies

rm -f licenses.csv
touch licenses.csv

pushd bundled-dependencies
for PACKAGE_QUALIFIED in $DEPS; do
    echo $PACKAGE_QUALIFIED
    if [ ! -d $PACKAGE_QUALIFIED ] && [ ! -f $PACKAGE_QUALIFIED.tar.gz ]; then
        echo "Fetching $PACKAGE_QUALIFIED"
        cabal get $PACKAGE_QUALIFIED
        sleep 1
        tar cvzf $PACKAGE_QUALIFIED.tar.gz $PACKAGE_QUALIFIED
    fi
    echo "Fetching Info from $PACKAGE_QUALIFIED.tar.gz"
    set +e
    COPYRIGHT=$(tar -xOzf $PACKAGE_QUALIFIED.tar.gz $PACKAGE_QUALIFIED/LICENSE | grep Copyright | head -1)
    set -e
    LICENSE=$(cabal info $PACKAGE_QUALIFIED | grep License: | awk -F' ' '{print $2};')
    HOMEPAGE=$(cabal info $PACKAGE_QUALIFIED | grep Homepage: | grep -v '\[' | awk -F' ' '{print $2};')
    echo "Fetched Info from $PACKAGE_QUALIFIED.tar.gz"

    rm -rf $PACKAGE_QUALIFIED

    echo "$PACKAGE_QUALIFIED,$LICENSE,$COPYRIGHT,$HOMEPAGE" >> ../licenses.csv
done
