# Bazel rules for deno

This is very early experimental code to provide basic Deno support under Bazel.
This project comes with no guarantees about support, maintenance, or viability, and might be archived at any time.

Depend on this at your own risk!

If we find interest in developing the rules further, we'll fund the project and provide a roadmap of when
you could expect a stable release with a minimal viable feature set.

## Installation

Include this in your WORKSPACE file:

```starlark
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
http_archive(
    name = "contrib_rules_deno",
    sha256 = "9f266a8c2e37e10eb1b460bd0d227524962a0d819544da15bee9f2e053b56c82",
    strip_prefix = "rules_deno-0.1.1",
    url = "https://github.com/aspect-build/rules_deno/archive/refs/tags/v0.1.1.tar.gz",
)

load("@contrib_rules_deno//deno:repositories.bzl", "deno_register_toolchains", "rules_deno_dependencies")

# This just gives us bazel-skylib
# You could just as easily install that yourself instead of calling this helper.
rules_deno_dependencies()

deno_register_toolchains(
    name = "deno1_21",
    deno_version = "1.21.3",
)
```

Now you can use the deno toolchain fetched for your platform.

## Usage

### Generating outputs

Bazel incrementally transforms the source tree to a bazel-out folder, by spawning
subprocesses to run tools. These are called actions and the simplest way to define
one is with the "generic rule" [genrule](https://docs.bazel.build/versions/main/be/general.html#genrule)

See the examples/genrule folder for the simplest usage: we run deno in a genrule
where you fully control the command line used to spawn deno, transforming declared
inputs into declared outputs using the toolchain provided by these rules to select
the deno runtime for the host and target platform.

### Running programs

Both binaries and tests are spawned by Bazel, but without expecting output files.
In the case of tests, Bazel treats these as arbitrary programs that exit zero or non-zero.

See the example in the tests/ folder where we use Bazel's `sh_test` rule to wrap a
Deno program. You could similarly use an `sh_binary` to make a standalone program
that can be used with `bazel run`.
