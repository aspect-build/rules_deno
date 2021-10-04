# How to Contribute

## Formatting

Starlark files should be formatted by buildifier.
We suggest using a pre-commit hook to automate this.
First [install pre-commit](https://pre-commit.com/#installation),
then run

```shell
pre-commit install
```

Otherwise later tooling on CI may yell at you about formatting/linting violations.

## Using this as a development dependency of other rules

You'll commonly find that you develop in another WORKSPACE, such as
some other ruleset that depends on rules_deno, or in a nested
WORKSPACE in the integration_tests folder.

To always tell Bazel to use this directory rather than some release
artifact or a version fetched from the internet, run this
to add an override setting in your Bazel rc settings file:

```sh
(
    cd $(git rev-parse --show-toplevel)

    for verb in build query; do
    echo "$verb --override_repository=dev_aspect_rules_deno=$PWD" >> ~/.bazelrc
    done
)
```
