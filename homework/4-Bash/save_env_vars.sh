#!/bin/bash

function create_today_backup_dir_if_not_exists() {
    mkdir -p "$(today_backup_dir)"
}

function today_backup_dir() {
    echo ~/"backup/conf/$(today)"
}

function today() {
    date +%d-%m-%Y
}

function save_env_vars() {
    printenv > "$(today_backup_dir)/env_data.txt"
}

create_today_backup_dir_if_not_exists
save_env_vars