pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = "${key}"
        AWS_SECRET_ACCESS_KEY = "${secret}"
        ANSIBLE_PRIVATE_KEY=credentials('private-key')

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

        stage("run the ansible playbook"){
            steps {
                sh 'sudo su'
                sh 'ssh-keygen -f "/home/ubuntu/.ssh/known_hosts" -R 54.197.8.155'
                sh 'export ANSIBLE_HOST_KEY_CHECKING=False'
                sh 'ansible-playbook -i playbooks/inventory.yml -vvvv --private-key=$ANSIBLE_PRIVATE_KEY playbooks/playbook.yml'
            }
        }
    }
}
