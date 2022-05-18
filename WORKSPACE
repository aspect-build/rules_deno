# Declare the local Bazel workspace.
# This is *not* included in the published distribution.
workspace(
    # see https://docs.bazel.build/versions/main/skylark/deploying.html#workspace
    name = "contrib_rules_deno",
)

local_repository(
    name = "genrule_example",
    path = "examples/genrule",
)

load(":internal_deps.bzl", "rules_deno_internal_deps")

rules_deno_internal_deps()

# Install our "runtime" dependencies which users install as well
load("//deno:repositories.bzl", "deno_register_toolchains", "rules_deno_dependencies")

rules_deno_dependencies()

deno_register_toolchains(
    name = "deno1_21",
    deno_version = "1.21.3",
)

# For running our own unit tests
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

############################################
# Gazelle, for generating bzl_library targets
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.2")

gazelle_dependencies()
