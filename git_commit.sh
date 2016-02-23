#!/bin/bash

SCRIPT_DIR=$(dirname $0)
SCRIPT_DIR=${SCRIPT_DIR/\./$(pwd)}
echo SCRIPT_DIR = ${SCRIPT_DIR}

cd ${SCRIPT_DIR}

git add SSLinker/*
git add Resources/*

git add SSLinker.xcodeproj/xcshareddata/xcschemes/*

TODAY=$1
if [ $1 == "" ] 
then   
TODAY=`date '+%Y-%m-%d %H:%M:%S'`
fi
git commit -am "${TODAY}"

git status
#curl -s 'https://github.com/qokelate' > /dev/null && git push origin master

echo finished.
#exit 0

