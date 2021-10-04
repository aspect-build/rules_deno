#!/usr/bin/env bash
set -o errexit -o pipefail -o nounset

cd $TEST_SRCDIR

DENO=${DENO#external/}
export RUST_BACKTRACE=1

out=$($DENO run dev_aspect_rules_deno/tests/hello_world.js)

set -x
if [[ "$out" != *"Hello John"* ]]; then
    echo "Expected output containing Hello John but was"
    echo $out
    exit 1
fi

