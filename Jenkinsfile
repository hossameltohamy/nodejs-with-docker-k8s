// pipeline {
// agent any
//   stages {

//     stage('Checkout Source') {
//       steps {
//         git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'
//       }
//     }
//       stage("Build image") {
//             steps {
//                 script {
//                     myapp = docker.build("hossamyahia107/nodejs-api:${env.BUILD_ID}")
//                 }
//             }
//         }
    
//       stage("Push image") {
//             steps {
//                 script {
//                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
//                             myapp.push("latest")
//                             myapp.push("${env.BUILD_ID}")
//                     }
//                 }
//             }
//         }
//     stage('Deploy App') {
//       steps {
//         script {
//           kubernetesDeploy(configs: "server-deployment.yaml", kubeconfigId: "mykubeconfig")
//         }
//       }
//     }

//   }

// }
pipeline {

  agent { label 'jenkins-slave' }
  stages {
    stage('Checkout Source') {
      steps {
        git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "server-deployment.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}
// node('jenkins-slave') {
    
//      stage('unit-tests') {
//         sh(script: """
//             docker -v 
//         """)
//     }
// }
 