#!/bin/bash

function validate_number_of_arguments() {
    if (( $# != 2 )) ; then
        display_usage_and_exit
    fi
}

function validate_number() {
    if ! [[ "$1" =~ ^[-]?[0-9]+([.][0-9]+)?$ ]] ; then
        display_usage_and_exit
    fi
}

function display_usage_and_exit() {
    display_usage
    exit 1
}

function display_usage() {
    echo "Usage: <x> <y>"
}

function calculate() {
    x=$1
    y=$2
    echo 'Select operation: + - * /'
    read operation
    case $operation in
        +)
            echo "$x + $y" | bc
            ;;
        -)
            echo "$x - $y" | bc
            ;;
        \*)
            echo "$x * $y" | bc
            ;;
        /)
            echo "$x / $y" | bc
            ;;
        *)
            echo "Error: Invalid operation!"
            exit 1
            ;;
    esac
}

validate_number_of_arguments "$@"

x="$1"
y="$2"

validate_number "$x"
validate_number "$y"

calculate "$x" "$y"