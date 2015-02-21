#!/usr/bin/env bash
set -e
set -o pipefail

BASEDIR=$(cd "$(dirname "$0")"/..; pwd -P)
cd $BASEDIR

case $1 in
    name)
        head -1 debian/changelog | awk -F' [()]' '{ print $1 }'
        ;;
    version)
        head -1 debian/changelog |
            awk -F'[()]' '{ print $2 }' |
            rev | cut -d '-' -f2- | rev
        ;;
    *)
        echo 'expected name or version!'
        exit -1
        ;;
esac
