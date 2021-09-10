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


// Jenkinsfile


// welcomeJob ‘lambdatest’
// pipeline {
//     agent any
//     // stages {
//     //           DockerBuild('build docker, hossamyahia107/nodejs-api:latest')
//     //     }
//     stages{
//     stage('build docker'){
     
// 	    sh "docker build -t hossamyahia107/nodejs-api:latest ."
//   }
//     }
      
//     }

 
   



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

@Library('jenkins-shared-libraries')_
def myUtils = new io.abc.pipeline()
node {
    myUtils.Initialize_Workspace('Clean Work Space')
    myUtils.CheckOutScm('fetch repositry','https://github.com/hossameltohamy/nodejs-with-docker-k8s.git','master','')
    myUtils.CleanDocker('Clean Docker before start')
    stage('test') {
     nodejs(nodeJSInstallationName: 'nodejs') {
       sh 'docker run --name some-postgres -e POSTGRES_PASSWORD=hossam@107@test -d -p 5432:5432 postgres'
       sh 'npm install --only=dev'
       sh 'npm install lodash --save'
       sh 'NODE_ENV=test PGHOST=localhost PGUSER=postgres PGPASSWORD=hossam@107@test  PGDATABASE=test-db  npm run test'
     }
   }
    myUtils.DockerBuild('build DockerImage', 'hossamyahia107/nodejs-api:latest')
    myUtils.CleanDocker('Clean Docker after build & push')
    myUtils.KubernetesDeployment('deploytoK8sCluster','do-ams3-test','https://8a604b66-43ff-4f24-926c-29b158894e10.k8s.ondigitalocean.com','mykubeconfig' , 'kubectl apply -f k8s//')
    stage('Email Notification'){
    myUtils.SendEmail('hossamyahia1017@gmail.com,hossamyahia107@mail.com')
    mail bcc: '', body: '''Build successful!!!!
    Thanks,
    Mahesh''', cc: '', from: '', replyTo: '', subject: 'Build successfull', to: 'smahesh2305@gmail.com'
    }
 post { 
        // changed { 
        //  myUtils.SendEmail('hossamyahia1017@gmail.com,hossamyahia107@mail.com')
        // }
         always {
            echo 'I will always say Hello again!'
            
            emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}",
                recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            
        }
    }
    
}
 