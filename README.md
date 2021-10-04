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
    sha256 = "d5f668498989d6f3ee1f015707771bcaca7ea05291ee08404e78095bdc4f1fdc",
    urls = [
        "https://github.com/aspect-dev/rules_deno/releases/download/0.1.0/rules_deno-0.1.0.tar.gz",
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

## Example

See the examples/genrule folder for the simplest usage: run deno in a Bazel genrule
where you fully control the command line used to spawn deno.
