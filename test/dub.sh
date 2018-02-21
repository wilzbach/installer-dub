#!/bin/bash

set -uexo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/common.sh

compilers=(
    dub-1.2.0
    dub-1.5.0
    dub-1.6.0
    dmd-2.079.0+dub-1.5.0
)

versions=(
    'DUB version 1.2.0, built on Jan 22 2017'
    'DUB version 1.5.0, built on Sep  1 2017'
    'DUB version 1.6.0, built on Nov  8 2017'
    'DUB version 1.5.0, built on Sep  1 2017'
)

for idx in "${!compilers[@]}"
do
    compiler="${compilers[$idx]}"
    echo "Testing: $compiler"
    "$INSTALLER" $compiler
    . $("$INSTALLER" $compiler -a)

    compilerVersion=$(dub --version | sed -n 1p)
    test "$compilerVersion" = "${versions[$idx]}"
    deactivate

    "$INSTALLER" uninstall $compiler
done
