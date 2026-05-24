"""Our "development" dependencies

Users should *not* need to install these. If users see a load()
statement from these, that's a bug in our distribution.
"""

load("//deno/private:maybe.bzl", http_archive = "maybe_http_archive")

def rules_deno_internal_deps():
    "Fetch deps needed for local development"
    http_archive(
        name = "bazel_lib",
        sha256 = "c6e2be1c7a30ef6de9d0e15cd3a4b6bc62fe156848117c0a1eeedf97561a4f6b",
        strip_prefix = "bazel-lib-3.3.1",
        url = "https://github.com/bazel-contrib/bazel-lib/releases/download/v3.3.1/bazel-lib-v3.3.1.tar.gz",
    )

    http_archive(
        name = "aspect_rules_lint",
        sha256 = "78e0d8b35270be83f4ee0895b2327d5165016b7a2c9204ac50c2a9b98852bbe9",
        strip_prefix = "rules_lint-1.13.0",
        url = "https://github.com/aspect-build/rules_lint/releases/download/v1.13.0/rules_lint-v1.13.0.tar.gz",
    )

    http_archive(
        name = "bazelrc-preset.bzl",
        sha256 = "af1053fb5224c69843eae55c11596cd9a987200f94b60ee036797c9a022c9c0c",
        strip_prefix = "bazelrc-preset.bzl-1.9.2",
        url = "https://github.com/bazel-contrib/bazelrc-preset.bzl/releases/download/v1.9.2/bazelrc-preset.bzl-v1.9.2.tar.gz",
    )

    # Required transitively by bazelrc-preset.bzl, which loads
    # `@bazel_features_version//:version.bzl`. In bzlmod that repo is created
    # by the `version_extension` extension; under WORKSPACE we have to call
    # `bazel_features_deps()` from WORKSPACE to materialize it.
    http_archive(
        name = "bazel_features",
        sha256 = "6a727a78c0134b1b912c97c0937e1c956f35775934ae3e1f4af4156f8d5d1ff4",
        strip_prefix = "bazel_features-1.47.1",
        url = "https://github.com/bazel-contrib/bazel_features/releases/download/v1.47.1/bazel_features-v1.47.1.tar.gz",
    )

    http_archive(
        name = "rules_multirun",
        sha256 = "a203b9f098297b8e5b38e8e746d3f9e55ce2687a76a18599ae0b3fbf8359a7eb",
        url = "https://github.com/keith/rules_multirun/releases/download/0.13.0/rules_multirun.0.13.0.tar.gz",
    )

    http_archive(
        name = "rules_shell",
        sha256 = "20721f63908879c083f94869e618ea8d4ff5edb91ff9a72a2ebee357fdbc352d",
        strip_prefix = "rules_shell-0.8.0",
        url = "https://github.com/bazelbuild/rules_shell/releases/download/v0.8.0/rules_shell-v0.8.0.tar.gz",
    )

    http_archive(
        name = "bazel_gazelle",
        sha256 = "32938bda16e6700063035479063d9d24c60eda8d79fd4739563f50d331cb3209",
        urls = ["https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.35.0/bazel-gazelle-v0.35.0.tar.gz"],
    )

    http_archive(
        name = "bazel_skylib_gazelle_plugin",
        sha256 = "0a466b61f331585f06ecdbbf2480b9edf70e067a53f261e0596acd573a7d2dc3",
        urls = ["https://github.com/bazelbuild/bazel-skylib/releases/download/1.4.1/bazel-skylib-gazelle-plugin-1.4.1.tar.gz"],
    )

    http_archive(
        name = "buildifier_prebuilt",
        sha256 = "8ada9d88e51ebf5a1fdff37d75ed41d51f5e677cdbeafb0a22dda54747d6e07e",
        strip_prefix = "buildifier-prebuilt-6.4.0",
        urls = ["http://github.com/keith/buildifier-prebuilt/archive/6.4.0.tar.gz"],
    )

    http_archive(
        name = "io_bazel_rules_go",
        sha256 = "6734a719993b1ba4ebe9806e853864395a8d3968ad27f9dd759c196b3eb3abe8",
        urls = ["https://github.com/bazelbuild/rules_go/releases/download/v0.45.1/rules_go-v0.45.1.zip"],
    )

    http_archive(
        name = "io_bazel_stardoc",
        sha256 = "62bd2e60216b7a6fec3ac79341aa201e0956477e7c8f6ccc286f279ad1d96432",
        urls = ["https://github.com/bazelbuild/stardoc/releases/download/0.6.2/stardoc-0.6.2.tar.gz"],
    )
