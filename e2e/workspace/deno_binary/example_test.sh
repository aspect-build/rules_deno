#!/usr/bin/env bash
$SCRIPT_LOCATION script_output.json

echo "Deno execution finished"

expected_output='{"run":"prompt","read":"prompt","write":"granted","net":"prompt","env":"granted","ffi":"prompt","hrtime":"prompt"}'
actual_output="$(cat script_output.json)"

if [[ "$expected_output" != "$actual_output" ]]; then
  echo "------------------------------------------"
  echo "ERROR: Unexpected output from Deno script."
  printf "Expected:\n%s\n" "$expected_output" >&2
  printf "Actual:\n%s\n" "$actual_output" >&2
  exit 1
fi
