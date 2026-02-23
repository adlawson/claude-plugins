#!/usr/bin/env bash
set -eo pipefail

if [[ $(uname -s) -ne "Darwin" ]]; then exit 1; fi
if ! [ -x "$(command -v jq)" ]; then exit 1; fi

working_directory=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")

declare instruction
case $(jq -r '.hook_event_name') in
    Notification) instruction="is waiting";;
    PermissionRequest) instruction="has a question";;
    Stop) instruction="is done";;
    *) exit 0;;
esac

say --rate=200 <<-EOF
${working_directory} ${instruction}.

EOF
