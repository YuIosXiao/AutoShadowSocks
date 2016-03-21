#!/bin/bash

SCRIPT_DIR=$(dirname $0)
SCRIPT_DIR=${SCRIPT_DIR/\./$(pwd)}
echo SCRIPT_DIR = ${SCRIPT_DIR}

cd ${SCRIPT_DIR}

git add SSLinker/*
git add Resources/*
git add Released/*

#git add SSLinker.xcodeproj/xcshareddata/xcschemes/*

git commit -am "$1"

git status
#curl -s 'https://github.com/qokelate' > /dev/null && git push origin master

echo finished.
#exit 0

