#!/bin/sh -l

DEPTH="$1"
BRANCHES="$2"
SOURCE_URL="$3"
FORK_URL="$4"
DRY_RUN="$5"

echo "${BRANCHES}" | sed -n 1'p' | tr ',' '\n' | while read branchName; do
    if [ ! -d ".cloneDir-${branchName}" ]; then
        rm -rf ".cloneDir-${branchName}"
    fi
    echo "Get fork sha for branch"
    FORK_SHA=$(git ls-remote git@github.com:williamdes/phpmyadmintest.git "refs/heads/${branchName}" | awk '{ print $1}')
    echo "Fork sha: ${FORK_SHA}"
    echo "Cloning ..."
    git clone --bare --depth "${DEPTH}" --single-branch --branch "${branchName}" "${SOURCE_URL}" ".cloneDir-${branchName}"
    cd ".cloneDir-${branchName}"
    git push --dry-run "${FORK_URL}" $branchName
    cd ../
done
