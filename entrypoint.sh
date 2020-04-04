#!/bin/sh -l

DEPTH="$1"
BRANCHES="$2"
SOURCE_URL="$3"
FORK_URL="$4"
DRY_RUN="$5"

if [ ! -d .cloneDir-source ]; then
    git clone --bare --filter=tree:0 --depth "${DEPTH}" --no-single-branch "${SOURCE_URL}" ".cloneDir-source"
    cd ".cloneDir-source"
else
    cd ".cloneDir-source"
    git fetch --all -p -P
fi

OPTS=""

if [ "${DRY_RUN}" = "true" ]; then
    echo 'Using dry-run mode';
    OPTS="--dry-run"
fi

echo "${BRANCHES}" | sed -n 1'p' | tr ',' '\n' | while read branchName; do
    git push ${OPTS} "${FORK_URL}" $branchName
done
