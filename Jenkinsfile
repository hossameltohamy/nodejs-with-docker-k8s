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

3
// Jenkinsfile
@Library('jenkins-shared-libraries') _
import io.abc.DockerBuild


// welcomeJob ‘lambdatest’
pipeline {
    agent any
    stages {
              DockerBuild('build docker, hossamyahia107/nodejs-api:latest')
        }
    }

 
   



  // agent any
  // stages {
  //   stage('Checkout Source') {
  //     steps {
  //       git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'
  //     }
  //   }
  //   stage('Deploy App') {
  //     steps {
  //       script {
  //         // kubernetesDeploy(configs: "server-deployment.yaml", kubeconfigId: "mykubeconfigid")
  //        KubernetesDeployment('Deploy App2, do-ams3-test, https://8a604b66-43ff-4f24-926c-29b158894e10.k8s.ondigitalocean.com , 8a604b66-43ff-4f24-926c-29b158894e10, kubectl applay -f k8s/')      
  //          }
  //     }
  //   }

  // }

 
// node('jenkins-slave') {
    
//      stage('unit-tests') {
//         sh(script: """
//             docker -v 
//         """)
//     }
// }
 