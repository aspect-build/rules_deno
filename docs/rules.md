<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="#deno_binary"></a>

## deno_binary

<pre>
deno_binary(<a href="#deno_binary-name">name</a>, <a href="#deno_binary-allow">allow</a>, <a href="#deno_binary-allow_uncached">allow_uncached</a>, <a href="#deno_binary-deps">deps</a>, <a href="#deno_binary-lockfile">lockfile</a>, <a href="#deno_binary-main">main</a>, <a href="#deno_binary-unstable_apis">unstable_apis</a>)
</pre>

Invoke Deno to run the specified script.

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


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="deno_binary-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| <a id="deno_binary-allow"></a>allow |  Any Deno permissions to allow the script to use. See https://deno.land/manual/getting_started/permissions   | List of strings | optional | [] |
| <a id="deno_binary-allow_uncached"></a>allow_uncached |  Whether to allow uncached remote dependencies.   | Boolean | optional | False |
| <a id="deno_binary-deps"></a>deps |  Additional local files that will be imported.   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | optional | [] |
| <a id="deno_binary-lockfile"></a>lockfile |  The lock file to check prior to running the script.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | optional | None |
| <a id="deno_binary-main"></a>main |  Main entrypoint script that is given to <code>deno run</code> command.   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| <a id="deno_binary-unstable_apis"></a>unstable_apis |  Whether to allow unstable Deno APIs. See https://deno.land/manual/runtime/stability   | Boolean | optional | False |


