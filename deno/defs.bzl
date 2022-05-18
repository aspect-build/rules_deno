"Public API re-exports"

load("//deno/private:binary.bzl", _deno_binary = "deno_binary")

def deno_binary(name, main, allow = [], unstable_apis = False, deps = [], **kwargs):
    """Invoke Deno to run the specified script.

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

        Args:
            name: Name of the target
            main: Main entrypoint script that is given to `Deno run` command
            deps: Additional local files that will be imported
            allow: Any Deno permissions to allow the script to use (https://deno.land/manual/getting_started/permissions)
            unstable_apis: Whether to allow unstable Deno APIs (https://deno.land/manual/runtime/stability)
            out: Name of the output json file; defaults to the rule name plus ".json"
            **kwargs: Other common named parameters such as `tags` or `visibility`
        """
    _deno_binary(
        name = name,
        main = main,
        deps = deps,
        allow = allow,
        unstable_apis = unstable_apis,
        **kwargs
    )
