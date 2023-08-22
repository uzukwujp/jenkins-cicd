pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = "${key}"
        AWS_SECRET_ACCESS_KEY = "${secret}"
    }

    stages {
        stage("install terraform plugins"){
            steps {

                sh 'terraform init'

            }
        }

        stage("terraform plan"){
            steps {
                sh 'terraform plan'
            }
        }

        stage("terraform apply"){
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage("update ansible inventory file"){
            steps {
                sh 'chmod +x update_inventory.sh'
                sh './update_inventory.sh'
            }
        }
    }
}
