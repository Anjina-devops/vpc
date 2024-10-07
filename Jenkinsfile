pipeline {
    agent { node { label 'AGENT-1' } } 

    stages {
        stage('init') {
            steps {
                
                sh '''
                   terraform init

                '''
            }
        }
        stage('plan') {
            steps {
                 
                 sh'''
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