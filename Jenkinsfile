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

    stage('Debug Credentials') {
      steps {
        script {
          def creds = com.cloudbees.plugins.credentials.CredentialsProvider.lookupCredentials(
            com.cloudbees.plugins.credentials.common.StandardCredentials.class,
            Jenkins.instance,
            null,
            null
          )
          for (c in creds) {
            echo "Found credential: ${c.id} (${c.description})"
          }
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

    stage('Check Jenkins') {
      steps {
        sh 'curl http://localhost:8080'
      }
    }
  }
}
