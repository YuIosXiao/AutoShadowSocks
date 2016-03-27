#!/bin/bash

SCRIPT_DIR=$(dirname $0)
SCRIPT_DIR=${SCRIPT_DIR/\./$(pwd)}
echo SCRIPT_DIR = ${SCRIPT_DIR}

cd ${SCRIPT_DIR}

git add OSX/SSLinker/*
git add OSX/Resources/*
git add Windows/*

git commit -am "$1"

git status
#curl -s 'https://github.com/qokelate' > /dev/null && git push origin master

echo finished.
#exit 0

