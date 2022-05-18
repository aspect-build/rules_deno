def _deno_binary_impl(ctx):
    # Declare output file for launcher script on selected platform
    outfile_name = ctx.attr.name
    outfile_name += ".bat" if ctx.attr.is_windows else ".sh"
    outfile = ctx.actions.declare_file(outfile_name)

    # Get Deno executable and build flags to include in launcher
    deno = ctx.toolchains["@contrib_rules_deno//deno:toolchain_type"]
    flags = _build_deno_flags(unstable_apis = ctx.attr.unstable_apis, allow = ctx.attr.allow)
    runtime_args = "%*" if ctx.attr.is_windows else "$@"

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

_deno_binary = rule(
    implementation = _deno_binary_impl,
    executable = True,
    toolchains = ["@contrib_rules_deno//deno:toolchain_type"],
    attrs = {
        "main": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
        "unstable_apis": attr.bool(default = False),
        "allow": attr.string_list(default = []),
        "is_windows": attr.bool(mandatory = True),
        "deps": attr.label_list(default = [], allow_files = True),
    },
)

def deno_binary(name, **kwargs):
    _deno_binary(
        name = name,
        is_windows = select({
            "@bazel_tools//src/conditions:host_windows": True,
            "//conditions:default": False,
        }),
        **kwargs
    )

def _build_deno_flags(unstable_apis, allow):
    flags = []
    if unstable_apis:
        flags.append("--unstable")
    for p in allow:
        flags.append("--allow-%s" % p)
    return " ".join(flags)
