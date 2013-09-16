#!/bin/bash

set -e

DEB_VERSION=`dpkg-parsechangelog  | grep 'Version:' | cut -c10-`

if [ -z "$DEB_VERSION" ]; then
	echo "E: Failed to get package version. Aborting"
	exit 1
fi


HEAD_SHA1=`git log | head -1 | cut -d\  -f2`

echo I: Head -\> $HEAD_SHA1

# tag
# debian/tag
# debian/*:tag

GIT_TAGS=`git tag | egrep "^$DEB_VERSION\$|^debian/$DEB_VERSION\$|^debian/[^:]*%$DEB_VERSION\$"`

HAVE_VALID_TAG=0

for tag in $GIT_TAGS; do
	TAG_SHA1=`git log $tag | head -1 | cut -d\  -f2`
	echo I: Checking tag $tag -\> $TAG_SHA1

	if [ "$TAG_SHA1" == "$HEAD_SHA1" ]; then
		HAVE_VALID_TAG=1
		echo I: Got valid release tag $tag
	fi
done

if [ "$HAVE_VALID_TAG" != "1" ]; then
	echo "E: Head does not refers to tagged commit. Aborting"
	exit 1
fi