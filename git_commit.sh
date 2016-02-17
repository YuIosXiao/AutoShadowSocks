#!/bin/bash

SCRIPT_DIR=$(dirname $0)
SCRIPT_DIR=${SCRIPT_DIR/\./$(pwd)}
echo SCRIPT_DIR = ${SCRIPT_DIR}

cd ${SCRIPT_DIR}

git add SSLinker/*
git add Resources/*

git add SSLinker.xcodeproj/xcshareddata/xcschemes/*

TODAY=`date '+%Y-%m-%d %H:%M:%S'`
git commit -am "${TODAY}"

git status
curl -s 'https://github.com/qokelate/sma11case' > /dev/null && git push origin master

echo finished.
#exit 0

