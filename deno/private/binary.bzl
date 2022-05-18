def _deno_binary_impl(ctx):
    is_windows = ctx.target_platform_has_constraint(ctx.attr._windows_constraint[platform_common.ConstraintValueInfo])

    # Declare output file for launcher script on selected platform
    outfile_name = ctx.attr.name
    outfile_name += ".bat" if is_windows else ".sh"
    outfile = ctx.actions.declare_file(outfile_name)

    # Get Deno executable and build flags to include in launcher
    deno = ctx.toolchains["@contrib_rules_deno//deno:toolchain_type"]
    flags = _build_deno_flags(unstable_apis = ctx.attr.unstable_apis, allow = ctx.attr.allow)
    runtime_args = "%*" if is_windows else "$@"

    ctx.actions.write(
        output = outfile,
        content = "{deno_path} run {flags} {main_file} {runtime_args}".format(
            deno_path = deno.denoinfo.tool_files[0].short_path,
            main_file = ctx.file.main.path,
            flags = flags,
            runtime_args = runtime_args,
        ),
        is_executable = True,
    )
    runfiles = ctx.runfiles(files = deno.denoinfo.tool_files +
                                    ctx.files.main +
                                    ctx.files.deps)
    return DefaultInfo(
        executable = outfile,
        runfiles = runfiles,
    )

deno_binary = rule(
    implementation = _deno_binary_impl,
    executable = True,
    toolchains = ["@contrib_rules_deno//deno:toolchain_type"],
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
load("@contrib_rules_deno//deno:defs.bzl", "deno_binary")

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

def _build_deno_flags(unstable_apis, allow):
    flags = []
    if unstable_apis:
        flags.append("--unstable")
    for p in allow:
        flags.append("--allow-%s" % p)
    return " ".join(flags)
