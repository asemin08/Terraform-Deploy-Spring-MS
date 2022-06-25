pipeline {
    agent any

    parameters {
        booleanParam(name: 'destroy', defaultValue: false, description: 'Voulez vous détruire votre instance Terraform en cours ?'
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        GIT_PATH = "https://github.com/asemin08/Terraform-Deploy-Spring-MS.git"
        GIT_BRANCH = "main"
    }

    stages {

        stage('récupération du code source et récupération de la bonne branch') {
	        when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: "*/${GIT_BRANCH}"]],
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [],
                    submoduleCfg: [],
                    userRemoteConfigs: [[
                        url: "${GIT_PATH}"
                    ]]
                ])
            }
        }

        stage('Création clé ssh') {
	        when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                dir("app/") {
                    sh 'ssh-keygen -N -f projet_key_pair'
                }
            }
        }

        stage('Terraform init') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                dir("app/") {
                    sh'terraform init'
                }
            }
        }

        stage('Terraform plan') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                dir("app/") {
                    sh'terraform plan --auto-approve -var=\"AWS_ACCESS_KEY=${params.AWS_ACCESS_KEY_ID}\" -var=\"AWS_SECRET_KEY=${params.AWS_SECRET_ACCESS_KEY}\"'
                }
            }
        }

        stage('Terraform apply') {
            when {
                not {
                    equals expected: true, actual: params.destroy
                }
            }
            steps {
                dir("app/") {
                    sh'terraform apply --auto-approve -var=\"AWS_ACCESS_KEY=${params.AWS_ACCESS_KEY_ID}\" -var=\"AWS_SECRET_KEY=${params.AWS_SECRET_ACCESS_KEY}\"'
                }
            }
        }

        stage('Terraform destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
            steps {
                dir("app/") {
                    sh'terraform destroy --auto-approve -var=\"AWS_ACCESS_KEY=${params.AWS_ACCESS_KEY_ID}\" -var=\"AWS_SECRET_KEY=${params.AWS_SECRET_ACCESS_KEY}\"'
                }
            }
        }


    }

}