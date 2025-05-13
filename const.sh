#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${0}" )" && pwd -P)"
source "${SCRIPT_DIR}/log/log.sh"

function version() {
    echo "v0.0.0"
}

function validate_interpreter_version() {
    local major="${BASH_VERSINFO[0]}"
    if [ "${major}" -lt 5 ]; then
        log::Error "bash version must >= 5"
        false
    fi
}