#!/usr/bin/env bash

set +x
echo -------------------------------------------------
echo Building most recent branch:
git --no-pager log --decorate=short -n5 | grep RIT-EVT | head -n1 | sed -e 's/.*RIT-EVT\/\(.*\).*/\1/'
echo -------------------------------------------------

rm -rf _site/

git clone https://${EVT_USER}:${EVT_PASS}github.com/RIT-EVT/RIT-EVT.github.io.git --branch master --depth 1 _site
echo -------------------------------------------------

LIVE_VERSION_BUILD=`< _site/version/index.html grep -A1 data-version | tail -n1 | sed 's/^ *//;s/ *$//'`

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

echo "version: $LIVE_VERSION.$LIVE_BUILD" >> _config.yml

set -x
jekyll build
set +x
echo -------------------------------------------------

cd _site/
git add -A
git commit -m "v$LIVE_VERSION.$LIVE_BUILD $(date)"
echo -------------------------------------------------
git push
cd ..

echo -------------------------------------------------
echo "Cleaning up old branches"
git branch -r --merged origin/develop | grep -v master | grep -v dmz | grep -v \* | grep -v HEAD | grep -v develop | while read line; do git push origin :${line//origin\/}; done
echo -------------------------------------------------

TAG_NAME=v$LIVE_VERSION.$LIVE_BUILD
BRANCH_NAME=`git --no-pager log --decorate=short -n5 | grep RIT-EVT | head -n1 | sed -e 's/.*RIT-EVT\/\(.*\).*/\1/'`

echo "TAG_NAME=$TAG_NAME" > /var/tmp/env
echo "DATE=$(date)" >> /var/tmp/env
echo "BRANCH_NAME=$BRANCH_NAME" >> /var/tmp/env
