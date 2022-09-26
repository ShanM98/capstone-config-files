pipeline{
    agent{
        label 'staging'
    }
    tools{
        maven '3.8.6'
    }
    stages{
        stage('Source Code Checkout'){
            steps{
                git 'https://github.com/ShanM98/sportsarena.git'
            }
        }
        stage('Building the Source Code'){
            steps{
                sh 'mvn clean install test package'
            }
        }
        stage('Removing Old Container and Images'){
            steps{
                sh 'sudo chmod 777 /var/run/docker.sock'
                sh 'cd /home/ec2-user/jenkins/workspace/Sports_Arena_Pipeline'
                sh 'sudo docker-compose down --rmi all'

            }
        }
        stage('Deploying Containers'){
            steps{
                sh 'cd /home/ec2-user/jenkins/workspace/Sports_Arena_Pipeline'
                sh 'sudo docker-compose up -d'
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIAL', variable: 'PASSWORD')]) {
                    sh 'docker login -u glawstraining -p $PASSWORD'
                }
            }
        }
        stage('Push Images into Docker Hub'){
            steps{
                sh 'docker push glawstraining/sports_arena --all-tags'
            }
        }
    }
}