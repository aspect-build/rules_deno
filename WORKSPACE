# Declare the local Bazel workspace.
# This is *not* included in the published distribution.
workspace(
    # see https://docs.bazel.build/versions/main/skylark/deploying.html#workspace
    name = "dev_aspect_rules_deno",
)

# Install our "runtime" dependencies which users install as well
load("//deno:repositories.bzl", "rules_deno_dependencies")

rules_deno_dependencies()

load(":internal_deps.bzl", "rules_deno_internal_deps")

rules_deno_internal_deps()
