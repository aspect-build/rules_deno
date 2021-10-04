# Declare the local Bazel workspace.
# This is *not* included in the published distribution.
workspace(
    # see https://docs.bazel.build/versions/main/skylark/deploying.html#workspace
    name = "dev_aspect_rules_deno",
)

local_repository(
    name = "genrule_example",
    path = "examples/genrule",
)

# Install our "runtime" dependencies which users install as well
load("//deno:repositories.bzl", "deno_register_toolchains", "rules_deno_dependencies")

rules_deno_dependencies()

load(":internal_deps.bzl", "rules_deno_internal_deps")

rules_deno_internal_deps()

deno_register_toolchains(
    name = "deno1_14",
    deno_version = "1.14.2",
)
