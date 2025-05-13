#!/usr/bin/env bash

REPO_DIR=$(dirname "$0")

source semver.sh
source "$REPO_DIR/assert/assert.sh"

function test_parse_version() {
    local version="1.2.3"
    local expected_major=1
    local expected_minor=2
    local expected_patch=3

    parsed_version=$(parse "$version")
    assert_equal "$major" "$expected_major" "Major version mismatch"
    assert_equal "$minor" "$expected_minor" "Minor version mismatch"
    assert_equal "$patch" "$expected_patch" "Patch version mismatch"
}
