pipeline {
    agent { node { label 'AGENT-1' } } 

    options {
        ansiColor('xterm')
    }

    stages {
        stage('init') {
            steps {
                echo 'Building..Stage'

                sh '''
                   ls -l
                   pwd
                   terraform init

                '''
            }
        }
        stage('plan') {
            steps {
                
                sh'''
                    ls -l
                   pwd
                   terraform plan
                '''
            }
        }
       
    }
 post { 
        always { 
            echo 'I will always say Hello again!'
        }

        success{

            echo "I will run only in success scenario"
        }

        failure{

            echo "i will run in failure case only"
        }
    }

}