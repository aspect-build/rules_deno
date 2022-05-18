<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#deno_binary"></a>

## deno_binary

<pre>
deno_binary(<a href="#deno_binary-name">name</a>, <a href="#deno_binary-main">main</a>, <a href="#deno_binary-allow">allow</a>, <a href="#deno_binary-unstable_apis">unstable_apis</a>, <a href="#deno_binary-deps">deps</a>, <a href="#deno_binary-kwargs">kwargs</a>)
</pre>

Invoke Deno to run the specified script.

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


**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="deno_binary-name"></a>name |  Name of the target   |  none |
| <a id="deno_binary-main"></a>main |  Main entrypoint script that is given to <code>Deno run</code> command   |  none |
| <a id="deno_binary-allow"></a>allow |  Any Deno permissions to allow the script to use (https://deno.land/manual/getting_started/permissions)   |  <code>[]</code> |
| <a id="deno_binary-unstable_apis"></a>unstable_apis |  Whether to allow unstable Deno APIs (https://deno.land/manual/runtime/stability)   |  <code>False</code> |
| <a id="deno_binary-deps"></a>deps |  Additional local files that will be imported   |  <code>[]</code> |
| <a id="deno_binary-kwargs"></a>kwargs |  Other common named parameters such as <code>tags</code> or <code>visibility</code>   |  none |


