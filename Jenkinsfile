pipeline {

  agent { label 'kubepod' }

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "k8s/server-deployment.yaml", kubeconfigId: "mykubeconfig2")
        }
      }
    }

  }

}