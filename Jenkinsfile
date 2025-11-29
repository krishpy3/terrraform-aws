pipeline {
    agent any
    tools {
        terraform 'Terraform'
    }

    parameters {
        choice(
            name: 'WORKSPACE',
            choices: ['dev', 'stage', 'prod'],
            description: 'Select Terraform workspace'
        )
    }

    environment {
        TF_WORKSPACE = "${WORKSPACE}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Select Workspace') {
            steps {
                sh """
                terraform workspace select ${TF_WORKSPACE} || \
                terraform workspace new ${TF_WORKSPACE}
                """
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Approval') {
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    input(message: "Approve Terraform Apply for workspace: ${TF_WORKSPACE}?")
                }
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply tfplan'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/tfplan', allowEmptyArchive: true
        }
    }
}
