pipeline {
    agent any
    stages {
        stage('Run') {
            steps {
                sh 'docker run -d -p 8080:8080 packer/calculator'
            }
        }
    }
}