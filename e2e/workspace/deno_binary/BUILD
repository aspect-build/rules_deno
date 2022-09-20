"""Provides a simple way to test your rules as an external workspace.
Add a basic smoke-test target below.
"""

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@aspect_rules_deno//deno:defs.bzl", "deno_binary")

# Local Deno dependency scripts are just loaded from the file system. This makes
# filegroup the exact behavior we would want of a deno_library rule.
filegroup(
    name = "deno_utils",
    srcs = [
        "util_bazel.ts",
        "util_permissions.ts",
    ],
)

# A deno_binary specifies a main entry point and any flags to pass to Deno on
# execution. The deps are just other scripts we want to be able to import.
deno_binary(
    name = "example_binary",
    allow = [
        "write",
        "env",
    ],
    lockfile = "main.lock",
    main = "main.ts",
    unstable_apis = True,
    deps = [
        "helper.ts",
        ":deno_utils",
    ],
)

build_test(
    name = "smoke_test",
    targets = [
        # targets you add above
        ":example_binary",
    ],
)

sh_test(
    name = "example_test",
    srcs = ["example_test.sh"],
    data = [":example_binary"],
    env = {
        "SCRIPT_LOCATION": "$(location :example_binary)",
    },
)
