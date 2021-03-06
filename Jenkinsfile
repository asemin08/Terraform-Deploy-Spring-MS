pipeline {
    agent any

    parameters {
        booleanParam(name: 'destroy', defaultValue: false, description: 'Voulez vous détruire votre instance Terraform en cours ?')
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
                    script {
                        if (fileExists('projet_key_pair')) {
                            sh 'rm projet_key_pair'
                        }
                        if (fileExists('projet_key_pair.pub')) {
                            sh 'rm projet_key_pair.pub'
                        }
                    }
                    sh 'ssh-keygen -f projet_key_pair -N \"\"'
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
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'accessKey'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'secretKey')]) {
                        sh'terraform plan -var=\"AWS_ACCESS_KEY=$accessKey\" -var=\"AWS_SECRET_KEY=$secretKey\"'
                    }
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
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'accessKey'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'secretKey')]) {
                        sh'terraform apply --auto-approve -var=\"AWS_ACCESS_KEY=$accessKey\" -var=\"AWS_SECRET_KEY=$secretKey\"'
                    }
                }
            }
        }

        stage('Terraform destroy') {
            when {
                equals expected: true, actual: params.destroy
            }
            steps {
                dir("app/") {
                    withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'accessKey'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'secretKey')]) {
                        sh'terraform destroy --auto-approve -var=\"AWS_ACCESS_KEY=$accessKey\" -var=\"AWS_SECRET_KEY=$secretKey\"'
                    }
                }
            }
        }


    }

}