pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/rafaritter44/DevOpsEngineerExpress.git'
            }
        }
        stage('Build') {
            steps {
                sh 'cd homework/10-Packer && packer build calculator-template.json'
            }
        }
    }
}