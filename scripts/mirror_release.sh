#!/usr/bin/env bash
# Produce a dictionary for the current deno release,
# suitable for appending to deno/private/deno_versions.bzl

set -o errexit

set -o errexit -o nounset -o pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
RAW=$(mktemp)

REPOSITORY=${1:-"denoland/deno"}

# how many releases to mirror
NUM_RELEASES=1

(
	curl --silent \
		--header "Accept: application/vnd.github.v3+json" \
		https://api.github.com/repos/${REPOSITORY}/releases?per_page=${NUM_RELEASES} |
		jq -f $SCRIPT_DIR/filter.jq
) >$RAW

# Replace URLs with their hash
for version in $(jq -r 'keys | .[]' <$RAW); do
	echo "    \"${version/v/}\": {"
	for platform in $(jq -r ".[\"$version\"] | keys | .[]" <$RAW); do
		filename=$(jq -r ".[\"$version\"] | .[\"$platform\"]" <$RAW)
		url="https://github.com/denoland/deno/releases/download/$version/$filename"
		sha256=$(curl -sSL $url | shasum -b -a 384 | awk "{ print \$1 }" | xxd -r -p | base64)
		echo "        \"${platform}\": \"sha384-${sha256}\","
	done
	echo "    },"
done

echo ""
echo "Copy the version info into deno/private/deno_versions.bzl"
