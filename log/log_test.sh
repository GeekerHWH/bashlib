#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${0}" )" && pwd -P)"
source "${SCRIPT_DIR}/log.sh"

log::Info "This is a info message"
log::Warning "This is a warning message"
log::Error "This is a error message"