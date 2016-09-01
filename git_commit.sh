#!/bin/bash

SCRIPT_DIR="$(dirname $0)"
if [ '.' = "${SCRIPT_DIR:0:1}" ]; then
    SCRIPT_DIR="$(pwd)/${SCRIPT_DIR}"
fi
echo SCRIPT_DIR = ${SCRIPT_DIR}
cd "${SCRIPT_DIR}"

git add -A OSX/SSLinker/*
git add -A OSX/Resources/*
git add -A Windows/*
git add -A OSX/SSLinker.xcodeproj/xcshareddata/*

"./OSX/osxComponents/git_commit.sh"

COMMIT_MESSAGE='no commit message'
if [ -n "$1" ]; then
	COMMIT_MESSAGE=$1
fi
git commit -am "${COMMIT_MESSAGE}"

git remote show origin | grep 'coding.net' >/dev/null 2>/dev/null && git push origin master
exit 0

