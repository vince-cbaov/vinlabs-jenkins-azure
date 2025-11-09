pipeline {
  agent any

  environment {
    DOCKER_HOST = 'vinadmin@20.238.36.65'
    NGINX_IP = '10.0.1.4'
  }

  stages {
    stage('Hello') {
      steps {
        echo 'Hello World'
      }
    }

    stage('Check NGINX') {
      steps {
        sh 'curl -I http://${NGINX_IP}'
      }
    }

    stage('Check Remote Docker') {
      steps {
        sshagent(['docker-ssh']) {
          sh "ssh -o StrictHostKeyChecking=no ${DOCKER_HOST} 'docker version'"
        }
      }
    }

    stage('List Docker Containers') {
      steps {
        sshagent(['docker-ssh']) {
          sh "ssh ${DOCKER_HOST} 'docker ps -a'"
        }
      }
    }

    stage('Run Hello World Container') {
      steps {
        sshagent(['docker-ssh']) {
          sh "ssh ${DOCKER_HOST} 'docker run --rm hello-world'"
        }
      }
    }

    stage('Deploy to Azure Web App') {
      steps {
        withCredentials([azureServicePrincipal('jenkins-sp')]) {
          sh '''
            az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET --tenant $AZURE_TENANT_ID
            az webapp config container set \
              --name vinlabs-python-app \
              --resource-group vinlabs \
              --docker-custom-image-name vfalconer/vinlabs-python:latest
          '''
        }
      }
    }


    stage('Check Jenkins') {
      steps {
        sh 'curl http://localhost:8080'
      }
    }
  }
}
