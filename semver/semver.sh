#!/usr/bin/env bash

function is_valid() {
    local version=$1
    local semver_regex="^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$"
    
    if [[ $version =~ $semver_regex ]]; then
        return 0
    else
        return 1
    fi
}

function parse() {
    local version=$1

    if ! is_valid "$version"; then
        echo "Invalid semver format" >&2
        return 1
    fi

    declare -A parsed_semver
    local base_version=$(echo "$version" | cut -d- -f1)
    parsed_semver["major"]=$(echo "$base_version" | cut -d. -f1)
    parsed_semver["minor"]=$(echo "$base_version" | cut -d. -f2)
    parsed_semver["patch"]=$(echo "$base_version" | cut -d. -f3)

    parsed_semver["pre-release"]=$(echo "$version" | grep -o -- '-[^+]*' 2>/dev/null | sed 's/^-//')
    parsed_semver["build"]=$(echo "$version" | grep -o -- '+.*' 2>/dev/null | sed 's/^+//')

    echo "${parsed_semver[major]} ${parsed_semver[minor]} ${parsed_semver[patch]} ${parsed_semver[pre-release]} ${parsed_semver[build]}"
}

# 1: v1 > v2
# 0: v1 == v2
# -1: v1 < v2
function compare() {
    local v1=$1
    local v2=$2

    local v1_parts=$(parse "$v1")
    local v2_parts=$(parse "$v2")
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    read -r v1_major v1_minor v1_patch v1_pre v1_build <<< "$v1_parts"
    read -r v2_major v2_minor v2_patch v2_pre v2_build <<< "$v2_parts"
    if [[ $v1_major -gt $v2_major ]]; then
        echo 1; return 0
    elif [[ $v1_major -lt $v2_major ]]; then
        echo -1; return 0
    fi

    if [[ $v1_minor -gt $v2_minor ]]; then
        echo 1; return 0
    elif [[ $v1_minor -lt $v2_minor ]]; then
        echo -1; return 0
    fi

    if [[ $v1_patch -gt $v2_patch ]]; then
        echo 1; return 0
    elif [[ $v1_patch -lt $v2_patch ]]; then
        echo -1; return 0
    fi

    if [[ -z "$v1_pre" && -n "$v2_pre" ]]; then
        echo 1; return 0
    elif [[ -n "$v1_pre" && -z "$v2_pre" ]]; then
        echo -1; return 0
    elif [[ "$v1_pre" > "$v2_pre" ]]; then
        echo 1; return 0
    elif [[ "$v1_pre" < "$v2_pre" ]]; then
        echo -1; return 0
    fi

    echo 0
}