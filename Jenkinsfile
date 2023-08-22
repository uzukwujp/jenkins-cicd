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
                sh 'export ANSIBLE_CONFIG=playbooks/ansible.cfg'
                sh 'ansible-playbook -i playbooks/inventory.yml -vvv --private-key=$ANSIBLE_PRIVATE_KEY playbooks/playbook.yml'
            }
        }
    }
}
