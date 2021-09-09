#!/bin/bash

GOBASE=$(cat GOBASE)
if [ "$GOBASE"y == "y" ]; then
	echo "Wrong branch format!  It should be hoddarla-<Golang commit>."
	exit -1
fi

if [ -d go ]; then
	cd go
	git fetch origin
else
	git clone https://github.com/golang/go.git
	cd go
fi

if [ "$1"y == "apply"y ]; then 
	git reset --hard $GOBASE; git stash
	find ../patch -type f -print | sort | xargs git am
elif [ "$1"y == "patch"y ]; then
	rm -fr ../patch
	git format-patch $GOBASE -o ../patch
fi
exit 0
