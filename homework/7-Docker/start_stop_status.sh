#!/bin/bash

function createMicroserviceContainer() {
    docker create --name calculator -p 8080:8080 devops/calculator
}

function removeMicroserviceContainer() {
    docker rm calculator
}

function startMicroservice() {
    docker start calculator
}

function stopMicroservice() {
    docker stop calculator
}

function microserviceStatus() {
    if $(docker inspect --type=container -f '{{.State.Running}}' calculator)
    then echo 'RUNNING'
    else echo 'NOT RUNNING'
    fi
}

echo 'Creating microservice container...'
createMicroserviceContainer
echo 'Microservice container created successfully!'
echo "Status: $(microserviceStatus)"
echo 'Starting microservice...'
startMicroservice
echo 'Microservice started successfully!'
echo "Status: $(microserviceStatus)"
echo 'Stopping microservice...'
stopMicroservice
echo 'Microservice stopped successfully!'
echo "Status: $(microserviceStatus)"
echo 'Removing microservice container...'
removeMicroserviceContainer
echo 'Microservice container removed successfully!'
