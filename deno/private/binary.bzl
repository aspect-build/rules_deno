"implementation details for deno_binary"

def _deno_binary_impl(ctx):
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])

    if is_windows:
        script_extension = ".bat"
        leftover_args = "%*"
        export_cmd = "set"
    else:
        script_extension = ".sh"
        leftover_args = "$@"
        export_cmd = "export"

    # Declare output file for launcher script on selected platform
    outfile_name = ctx.attr.name + script_extension
    outfile = ctx.actions.declare_file(outfile_name)

    # Get Deno executable and build flags to include in launcher
    deno_tools = ctx.toolchains["@aspect_rules_deno//deno:toolchain_type"].denoinfo.tool_files
    flags = _build_deno_flags(
        allow_uncached = ctx.attr.allow_uncached,
        unstable_apis = ctx.attr.unstable_apis,
        allow = ctx.attr.allow,
    )
    runtime_args = leftover_args

    # Add lock file to flags if specified
    build_flags = []
    if ctx.file.lockfile != None:
        build_flags.append("--lock")
        build_flags.append(ctx.file.lockfile.path)
    flags += build_flags

    # Create cache folder for use as DENO_DIR
    cache_folder = ctx.actions.declare_directory("%s_deno_cache" % ctx.attr.name)

    # Collect up all of the input files for use in actions
    infiles = ctx.files.main + ctx.files.deps + ctx.files.lockfile

    # Download any remote included scripts to cache
    ctx.actions.run(
        executable = deno_tools[0].path,
        arguments = ["cache", ctx.file.main.path] + build_flags,
        tools = deno_tools,
        env = {
            "DENO_DIR": cache_folder.path,
        },
        mnemonic = "DenoCache",
        inputs = infiles,
        outputs = [cache_folder],
    )

    ctx.actions.write(
        output = outfile,
        content = """
{export_cmd} DENO_DIR="{deno_cache}"
{deno_executable} run {flags} {main_file} {runtime_args}
        """.strip().format(
            export_cmd = export_cmd,
            deno_cache = cache_folder.short_path,
            deno_executable = deno_tools[0].short_path,
            main_file = ctx.file.main.path,
            flags = " ".join(flags),
            runtime_args = runtime_args,
        ),
        is_executable = True,
    )

    runfiles = ctx.runfiles(files = deno_tools + infiles + [cache_folder])
    return DefaultInfo(
        executable = outfile,
        runfiles = runfiles,
    )

deno_binary = rule(
    implementation = _deno_binary_impl,
    executable = True,
    toolchains = ["@aspect_rules_deno//deno:toolchain_type"],
    attrs = {
        "main": attr.label(
            allow_single_file = True,
            mandatory = True,
            doc = "Main entrypoint script that is given to `deno run` command.",
        ),
        "deps": attr.label_list(
            default = [],
            allow_files = True,
            doc = "Additional local files that will be imported.",
        ),
        "lockfile": attr.label(
            allow_single_file = True,
            doc = "The lock file to check prior to running the script.",
        ),
        "allow_uncached": attr.bool(
            default = False,
            doc = "Whether to allow uncached remote dependencies.",
        ),
        "unstable_apis": attr.bool(
            default = False,
            doc = "Whether to allow unstable Deno APIs. See https://deno.land/manual/runtime/stability",
        ),
        "allow": attr.string_list(
            default = [],
            doc = "Any Deno permissions to allow the script to use. See https://deno.land/manual/getting_started/permissions",
        ),
        "_windows_constraint": attr.label(
            default = "@platforms//os:windows",
        ),
    },
    doc = """Invoke Deno to run the specified script.

For Deno documentation, see https://deno.land/manual.

Example:
```starlark
load("@aspect_rules_deno//deno:defs.bzl", "deno_binary")

deno_binary(
  name = "example",
  allow = ["write"],
  main = "main.ts",
  unstable_apis = True,
  deps = [
      "helper.ts",
      ":deno_utils",
  ],
)
```
""",
)

def _build_deno_flags(allow_uncached, unstable_apis, allow):
    flags = []
    if not allow_uncached:
        flags.append("--cached-only")
    if unstable_apis:
        flags.append("--unstable")
    for p in allow:
        flags.append("--allow-%s" % p)
    return flags
