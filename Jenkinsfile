pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'terraform destroy && terraform apply'
            }
        }
        stage('deploy') {
            steps {
                sh 'yarn deploy'
            }
        }
    }
}