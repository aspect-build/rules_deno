"""Provides a simple way to test your rules as an external workspace.
Add a basic smoke-test target below.
"""

load("@bazel_skylib//rules:build_test.bzl", "build_test")
load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load("@bazel_skylib//rules:write_file.bzl", "write_file")
load("@contrib_rules_deno//deno:defs.bzl", "deno_binary")

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

# Trivial test fixture: a JavaScript program that writes to a file using Deno runtime API
write_file(
    name = "source",
    out = "some.js",
    content = ["Deno.writeTextFile(Deno.args[0], 'stuff')"],
)

write_file(
    name = "write_expected",
    out = "expected",
    content = ["stuff"],
)

# You can use the deno toolchain together with a genrule().
# This gives you complete control over starting the interpreter, but you also have to
# manually handle module resolution.
genrule(
    name = "use_deno_toolchain",
    srcs = ["some.js"],
    outs = ["genrule_out"],
    cmd = "$(DENO_PATH) run --allow-write $(execpath some.js) $@",
    toolchains = ["@deno_toolchains//:resolved_toolchain"],
    tools = ["@deno_toolchains//:resolved_toolchain"],
)

diff_test(
    name = "test_genrule",
    failure_message = "expected Deno program to write content",
    file1 = "expected",
    file2 = "genrule_out",
)
