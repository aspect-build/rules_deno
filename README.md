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
    name = "dev_aspect_rules_deno",
    sha256 = "ca07f393896e555fba89066cb343638ce8cc859d07f47ba54ffd308394610bce",
    urls = [
        "https://github.com/aspect-dev/rules_deno/releases/download/v0.1.0/rules_deno-0.1.0.tar.gz",
    ],
)

load("@dev_aspect_rules_deno//deno:repositories.bzl", "deno_register_toolchains", "rules_deno_dependencies")

# This just gives us bazel-skylib
# You could just as easily install that yourself instead of calling this helper.
rules_deno_dependencies()

deno_register_toolchains(
    name = "deno",
    deno_version = "1.14.2",
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
