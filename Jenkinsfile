pipeline {
  agent any
  stages {
    stage('Hello') {
      steps {
        echo 'Hello World'
      }
    }
    stage('Check NGINX') {
      steps {
        sh 'curl -I http://10.0.1.4'
      }
    }
    stage('Check Docker') {
      steps {
        sh 'docker --version'
      }
    }
    stage('Check Jenkins') {
      steps {
        sh 'curl http://localhost:8080'
      }
    }
  }
}
