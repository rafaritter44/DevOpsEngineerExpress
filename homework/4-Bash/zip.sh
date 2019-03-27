#!/bin/bash

function create_today_backup_dir_if_not_exists() {
    mkdir -p "$(today_backup_dir)"
}

function today_backup_dir() {
    echo ~/"backup/data/$(today)"
}

function today() {
    date +%d-%m-%Y
}

function folder_name() {
    folder="$1"
    cd $folder
    echo "${PWD##*/}"
}

function zip_folder() {
    folder="$1"
    folder_name=$(folder_name "$folder")
    zip -r "$(today_backup_dir)/${folder_name}.zip" "$folder"
}

create_today_backup_dir_if_not_exists
zip_folder "$1"