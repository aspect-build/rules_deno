# Aspect Workflows demonstration deployment

This deployment of [Aspect Workflows](https://www.aspect.build/workflows) is configured to run on AWS + GitLab.

You can see this Aspect Workflows demonstration deployment live at
https://gitlab.com/aspect-build/rules_deno/-/pipelines.

The three components of the configuration are,

1. Aspect Workflows terraform module
1. Aspect Workflows configuration yaml
1. GitLab CI configuration yaml

## Aspect Workflows terraform module

This is found under the [`.aspect/workflows/terraform`](./terraform/README.md) directory.

## Aspect Workflows configuration yaml

This is the `config.yaml` file in this directory.

## GitLab CI configuration

This is the `.gitlab-ci.yml` file at the root of the repository.
