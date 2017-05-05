#!/usr/bin/env bash

cd ..
rm -rf _site/
if [ "$1" = "-ssh" ]; then
    git clone git@github.com:RIT-EVT/RIT-EVT.github.io.git --branch master --depth 1 _site
else
    git clone https://github.com/RIT-EVT/RIT-EVT.github.io.git --branch master --depth 1 _site
fi

LIVE_VERSION_BUILD=`cat _site/version`

LIVE_VERSION=${LIVE_VERSION_BUILD%.*}
LIVE_BUILD=${LIVE_VERSION_BUILD##*.}
PACKAGE_VERSION=`sed -nE 's/^\s*"version": "(.*?)",$/\1/p' ./package.json`

if [[ "$LIVE_VERSION" == "$PACKAGE_VERSION" ]]; then
    LIVE_BUILD=`expr $LIVE_BUILD + 1`
else
    LIVE_VERSION=${PACKAGE_VERSION}
    LIVE_BUILD=0
fi

rm -rf _site/*

jekyll build
echo "$LIVE_VERSION.$LIVE_BUILD" > _site/version

cd _site/
git add -A
git commit -m "v$LIVE_VERSION.$LIVE_BUILD $(date)"
git push
cd ..
