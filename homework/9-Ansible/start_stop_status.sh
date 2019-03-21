#!/bin/bash

function startMicroservice() {
    root_password="$1"
    ansible-playbook calculator-playbook/calculator.yml --extra-vars "ansible_become_pass=$root_password"
}

function stopMicroservice() {
    root_password="$1"
    echo "$root_password" | sudo -S kill $(pidof calculator-microservice)
}

function microserviceStatus() {
    pidof calculator-microservice && echo 'RUNNING' || echo 'NOT RUNNING'
}

echo 'Starting microservice...'
startMicroservice "$1"
echo 'Microservice started successfully!'
microserviceStatus
echo 'Stopping microservice...'
stopMicroservice "$1"
echo 'Microservice stopped successfully!'
microserviceStatus