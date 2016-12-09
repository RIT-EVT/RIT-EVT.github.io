#!/usr/bin/env bash

cd ..
rm -rf _site/
git clone https://github.com/RIT-EVT/RIT-EVT.github.io.git --branch master --depth 1 _site
LIVE_VERSION_BUILD=`cat _site/version`

LIVE_VERSION=${LIVE_VERSION_BUILD%.*}
LIVE_BUILD=${LIVE_VERSION_BUILD#}
PACKAGE_VERSION=`sed -nE 's/^\s*"version": "(.*?)",$/\1/p' package.json`
rm -rf _site/*
jekyll build
cd _site/
echo "$BUILD_VERSION" > version
git add -A
git commit -m \"Release: $(date)\"
git push
cd ..
