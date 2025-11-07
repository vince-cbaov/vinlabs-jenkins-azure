pipeline {
  agent any

  environment {
    DOCKER_HOST = 'vinadmin@20.238.54.201'
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
        sh "ssh -o StrictHostKeyChecking=no ${DOCKER_HOST} 'docker version'"
      }
    }

    stage('List Docker Containers') {
      steps {
        sh "ssh ${DOCKER_HOST} 'docker ps -a'"
      }
    }

    stage('Run Hello World Container') {
      steps {
        sh "ssh ${DOCKER_HOST} 'docker run --rm hello-world'"
      }
    }

    stage('Check Jenkins') {
      steps {
        sh 'curl http://localhost:8080'
      }
    }
  }
}
