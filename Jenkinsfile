def ec2_public_ip = ""
def db_endpoint = ""
def db_name = ""
def db_user = ""
def db_password = ""
def terraformOutputs = ""
pipeline {
    agent none
    environment {
        AWS_ACCESS_KEY_ID = "Your AWS acces Key"
        AWS_SECRET_ACCESS_KEY = "Your AWS Secret Key"
        githubuser = "Your git hub username"
        githubpassword = "our git hub access token"
    }

stages {
    stage('Create aws infra') {
        agent {label 'jenkins-agent-terraform' }
        environment {
            PATH = "${env.PATH}:/home/jenkins/terraform"
        }
        steps {
            sh "git clone https://${env.githubuser}:${env.githubpassword}@github.com/prabeeshbalan/acloudbridge.git"
            sh "terraform version"
            dir("acloudbridge/prod/terraform") {
                sh "terraform init"
                sh "terraform apply --auto-approve"
                //sh "terraform destroy --auto-approve"
                script {
                    ec2_public_ip = sh(returnStdout: true, script: "terraform state show module.aws-ec2-free-tier.aws_instance.aws-public-ec2-free-tier | grep -w public_ip | awk -F'\"' '{print \$2}'").trim()
                    db_endpoint = sh(returnStdout: true, script: "terraform state show module.aws-rds-mysql-free-tier.module.aws-rds-mysql-free-tier.module.db_instance.aws_db_instance.this[0] | grep -w address | awk -F'\"' '{print \$2}'").trim()
                    terraformOutputs = readJSON text: sh(returnStdout: true, script: "terraform output -json")
                }
                script {
                    // Extract the values from the JSON
                    db_name = terraformOutputs.terraform_db_name.value
                    db_user = terraformOutputs.terraform_db_username.value
                    db_password = terraformOutputs.terraform_db_password.value
                
                    echo "ec2_public_ip: ${ec2_public_ip}"
                    echo "db_endpoint: ${db_endpoint}"
                    echo "db_name: ${db_name}"
                    echo "db_user: ${db_user}"
                    echo "db_password: ${db_password}"
                }
                sh "echo ${ec2_public_ip}"
                sh "echo ${db_endpoint}"
            }
        }
        
        post{
            always {
                dir("acloudbridge/prod/terraform"){
                    archiveArtifacts artifacts: 'aws_tf_key.pem', fingerprint: true
                }
            }
        }
    
    }
    
    stage('Configure ec2 infra and deploy app') {
        agent {label 'jenkins-agent-ansible' }
        environment{
            ANSIBLE_HOST_KEY_CHECKING = 'False'
        }
        steps {
            sh "git clone https://${env.githubuser}:${env.githubpassword}@github.com/prabeeshbalan/acloudbridge.git"
            sh 'ansible --version'
            dir("acloudbridge/prod/ansible") {
                step([
                $class: 'CopyArtifact',
                filter: 'aws_tf_key.pem',
                fingerprintArtifacts: true,
                optional: true,
                projectName: env.JOB_NAME,
                selector: [$class: 'SpecificBuildSelector',
                        buildNumber: env.BUILD_NUMBER]
                ])
                sh 'sudo chmod 0600 aws_tf_key.pem'
                sh 'cat aws_tf_key.pem'
                sh 'echo [ec2] > temp_hosts'
                sh "echo \'${ec2_public_ip} ansible_connection=ssh ansible_user=ec2-user ansible_ssh_private_key_file=./aws_tf_key.pem\' >> temp_hosts"
                sh 'cat temp_hosts'
                sh "ansible-playbook playbooks/configure-ec2.yaml -i ./temp_hosts --extra-vars \"terraform_db_endpoint=${env.DB_ENDPOINT} terraform_db_username=${env.DB_USER} terraform_db_password=${env.DB_PASSWORD} terraform_db_name=${env.DB_NAME} githubuser=${env.githubuser} githubpassword=${env.githubpassword}\" "
            }
            
        }
    }
}
}
