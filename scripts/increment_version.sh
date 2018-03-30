#!/usr/bin/env bash

VERSION_BUILD=`sed -nE 's/^\s*version: (.*?)$/\1/p' _config.yml`.$TRAVIS_BUILD_NUMBER
sed -i "/version:/c\version: $VERSION_BUILD" _config.yml