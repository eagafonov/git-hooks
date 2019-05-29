# git-hooks

Small collection of GIT hooks to make life easier (or more interesting)

## DO-NOT-COMMIT

Here is the snippet for a git pre-commit hook to avoid accidental commits of private/debug changes (from [hooks/pre-commit](hooks/pre-commit))

    DONOTCOMMIT_COUNT=`git diff --cached $against | grep '^\+' | grep 'DO NOT COMMIT' | wc -l`

    if [ "$DONOTCOMMIT_COUNT" != "0" ]; then
        echo "Commit aborted - found 'DO NOT COMMIT' tag"
        echo
        git diff --cached HEAD | egrep '^\+\+\+|^\+.*DO NOT COMMIT'
        exit 1
    fi

Just put a comment with `DO NOT COMMIT` somewhere around the changes you are going to keep private for a while.
