#!/usr/bin/env bash
set -eo pipefail

if ! [ -x "$(command -v jq)" ]; then exit 1; fi
if ! [ -x "$(command -v gofmt)" ]; then exit 1; fi

jq -r '[.tool_input.file_path, (.tool_input.edits[]? .file_path)] | map(select(.!=null))[]' |
    while read -r file_path; do
        case "${file_path}" in
            *.go) gofmt -w -s "${file_path}"
        esac
    done
