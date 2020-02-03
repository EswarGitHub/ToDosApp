pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'terraform destroy -auto-approve && terraform apply -auto-approve'
            }
        }
        stage('deploy') {
            steps {
                sh 'yarn deploy'
            }
        }
    }
}