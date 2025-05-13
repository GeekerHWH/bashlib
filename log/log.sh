#!/usr/bin/env bash

TIME=$(date +"%Y-%m-%d %H:%M:%S")

function log::Info() {
    echo -e "[\033[34mINFO\033[0m $TIME]: $1"
}
function log::Warnning() {
    echo -e "[\033[33mWARNNING\033[0m $TIME]: $1"
}
function log::Error() {
    echo -e "[\033[31mERROR\033[0m $TIME]: $1"
}