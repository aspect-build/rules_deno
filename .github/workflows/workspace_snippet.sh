#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

# Set by GH actions, see
# https://docs.github.com/en/actions/learn-github-actions/environment-variables#default-environment-variables
TAG=${GITHUB_REF_NAME}
PREFIX="rules_deno-${TAG:1}"
SHA=$(git archive --format=tar --prefix=${PREFIX}/ ${TAG} | gzip | shasum -a 256 | awk '{print $1}')

# Semver regex from https://gist.github.com/rverst/1f0b97da3cbeb7d93f4986df6e8e5695
SEMVER_PATTERN='(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?'
LATEST_VERSION="$(< ./deno/private/deno_versions.bzl grep -oE "${SEMVER_PATTERN}" | sort -V | tail -n1)"

cat << EOF
WORKSPACE snippet:
\`\`\`starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "contrib_rules_deno",
    sha256 = "${SHA}",
    strip_prefix = "${PREFIX}",
    url = "https://github.com/aspect-build/rules_deno/archive/refs/tags/${TAG}.tar.gz",
)

# Fetches the rules_deno dependencies.
# If you want to have a different version of some dependency,
# you should fetch it *before* calling this.
# Alternatively, you can skip calling this function, so long as you've
# already fetched all the dependencies.
load("@contrib_rules_deno//deno:repositories.bzl", "deno_register_toolchains", "rules_deno_dependencies")

rules_deno_dependencies()

# Choose a deno interpreter version
deno_register_toolchains(
    name = "deno",
    deno_version = "${LATEST_VERSION}",
)

\`\`\`
EOF
