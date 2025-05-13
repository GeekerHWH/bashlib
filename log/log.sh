#!/usr/bin/env bash

function log::Info() {
    local full_path="${BASH_SOURCE[1]}"
    local file_name
    file_name=$(basename "${full_path}")
    local line_no="${BASH_LINENO[0]}"
    printf "[\033[34mINFO\033[0m][%s:%s]: %s\n" "${file_name}" "${line_no}" "$1"
}

function log::Warning() {
    local full_path="${BASH_SOURCE[1]}"
    local file_name
    file_name=$(basename "${full_path}")
    local line_no="${BASH_LINENO[0]}"
    printf "[\033[33mWARNING\033[0m][%s:%s]: %s\n" "${file_name}" "${line_no}" "$1"
}

function log::Error() {
    local full_path="${BASH_SOURCE[1]}"
    local file_name
    file_name=$(basename "${full_path}")
    local line_no="${BASH_LINENO[0]}"
    printf "[\033[31mERROR\033[0m][%s:%s]: %s\n" "${file_name}" "${line_no}" "$1"
}