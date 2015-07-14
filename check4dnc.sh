#!/bin/sh
set -e

# This GIT hook helper checks staged changes for 'DO NOT COMMIT' string
# Returns non-zero if found

# To install this check into .git/hooks/pre-commit
# just add line '/path/to/check-do-not-commit.sh || exit 1' >>BEFOR<< last line with 'exec git diff-index ...'

# The bottom of .git/hooks/pre-commit should looks something like this:
# 
#       /path/to/check-do-not-commit.sh || exit 1
#       # If there are whitespace errors, print the offending file names and fail.
#       exec git diff-index --check --cached $against --


DONOTCOMMIT_COUNT=`git diff --cached $against | grep '^\+' | grep 'DO NOT COMMIT' | wc -l`

if [ "$DONOTCOMMIT_COUNT" != "0" ]; then
	echo "Commit aborted - found 'DO NOT COMMIT' tag"
	echo
	git diff --cached HEAD | egrep '^\+\+\+|^\+.*DO NOT COMMIT'
	exit 1
fi

exit 0
