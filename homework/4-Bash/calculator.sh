function validate_number_of_arguments() {
    if (( $# != 3 )) ; then
        display_usage_and_exit
    fi
}

function validate_operation() {
    if ! [[ "$1" = '+' || "$1" = '-' || "$1" = '*' || "$1" = '/' ]] ; then
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
    echo "Usage: <x> <+|-|*|/> <y>"
}

function calculate() {
    echo "$1 $2 $3" | bc
}

validate_number_of_arguments "$@"

x="$1"
operation="$2"
y="$3"

validate_number "$x"
validate_operation "$operation"
validate_number "$y"

calculate "$1" "$2" "$3"