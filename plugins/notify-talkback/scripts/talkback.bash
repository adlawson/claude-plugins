#!/usr/bin/env bash
set -eo pipefail

if [[ $(uname -s) -ne "Darwin" ]]; then exit 1; fi

input=$(jq -r '.' < /dev/stdin)
working_directory=$(basename "${CLAUDE_PROJECT_DIR:-$PWD}")

declare instruction
case $(echo "${input}" | jq -r '.hook_event_name') in
    Notification) instruction="is waiting";;
    PermissionRequest) instruction="has a question";;
    Stop) instruction="is done";;
    *) echo $(echo "${input}" | jq -r '.hook_event_name')
esac

say --rate=200 <<-EOF
${working_directory} ${instruction}.

EOF
