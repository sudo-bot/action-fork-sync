#!/bin/sh -l

DEPTH="$1"
BRANCHES="$2"
SOURCE_URL="$3"
FORK_URL="$4"
DRY_RUN="$5"
METHOD="$6"

echo "::debug DEPTH: ${DEPTH}"
echo "::debug BRANCHES: ${BRANCHES}"
echo "::debug SOURCE_URL: ${SOURCE_URL}"
echo "::debug FORK_URL: ${FORK_URL}"
echo "::debug DRY_RUN: ${DRY_RUN}"

if [ ! -d .cloneDir-source ]; then
    echo "::debug cloning..."
    git clone --bare --filter=tree:0 --depth "${DEPTH}" --no-single-branch "${SOURCE_URL}" ".cloneDir-source"
    if [ ! -d .cloneDir-source ]; then
        echo "::error The directory was not created, cloning must have failed.";
        exit 1;
    fi
    cd ".cloneDir-source"
else
    cd ".cloneDir-source"
    echo "::debug fetching..."
    git fetch --all -p -P
fi

OPTS=""

if [ "${DRY_RUN}" = "true" ]; then
    echo "::debug Using dry-run mode"
    OPTS="--dry-run"
fi

echo "${BRANCHES}" | sed -n 1'p' | tr ',' '\n' | while read branchName; do
    echo "::debug Sync branch: ${branchName}"
    git push ${OPTS} "${FORK_URL}" $branchName
done
