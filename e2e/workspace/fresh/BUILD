load("@aspect_rules_deno//deno:defs.bzl", "deno_binary")

deno_binary(
    name = "binary",
    allow = [
        "write",
        "env",
        "net",
        "read",
        "run",
    ],
    main = "main.ts",
    unstable_apis = True,
    deps = [
        "deno.json",
        "fresh.gen.ts",
        "import_map.json",
        "twind.config.ts",
        ":components",
        ":islands",
        ":routes",
        ":static",
    ],
)

filegroup(
    name = "components",
    srcs = glob(["components/*.tsx"]),
)

filegroup(
    name = "islands",
    srcs = glob(["islands/*.tsx"]),
)

filegroup(
    name = "routes",
    srcs = glob([
        "routes/**/*.tsx",
        "routes/**/*.ts",
    ]),
)

filegroup(
    name = "static",
    srcs = [
        "static/favicon.ico",
        "static/logo.svg",
    ],
)
