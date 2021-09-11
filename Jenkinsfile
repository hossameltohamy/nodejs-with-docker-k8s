@Library('jenkins-shared-libraries')_
def myUtils = new io.abc.pipelinedeclrative()
pipeline {
   agent any
     environment { 
        registry = "hossamyahia107/nodejs-api" 
        registryCredential = 'dockerhub_id' 
        dockerImage = ''  
    }
     tools {nodejs "nodejs"}
   stages {
     stage('Checkout Source'){
        steps{
          script {
          // myUtils.CheckOutScm('https://github.com/hossameltohamy/nodejs-with-docker-k8s.git','master','')
          //  git 'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git'
           git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'

          }
       }
     }
    stage('Test App') {
      steps{
       sh 'docker run --name some-postgres -e POSTGRES_PASSWORD=hossam@107@test -d -p 5432:5432 postgres'
       sh 'npm install --only=dev'
       sh 'npm install lodash --save'
       sh 'NODE_ENV=test PGHOST=localhost PGUSER=postgres PGPASSWORD=hossam@107@test  PGDATABASE=test-db  npm run test' 
      }
   }
   stage('Build Docker Images'){
     steps{
       script{
      //  myUtils.DockerBuild('hossamyahia107/nodejs-api:latest')
       dockerImage = docker.build registry + ":${env.BUILD_ID}" 
       }
     }
   }

 stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            dockerImage.push("latest")
                            dockerImage.push("${env.BUILD_ID}")
                    }
                }
            }
        }
            stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:${env.BUILD_ID}" 
            }
        } 
            // myUtils.KubernetesDeployment('deploytoK8sCluster','do-ams3-test','https://8a604b66-43ff-4f24-926c-29b158894e10.k8s.ondigitalocean.com','mykubeconfig' , 'kubectl apply -f k8s//')
            stage ('Deploy to k8s'){
              steps{
                script{
                      withKubeConfig(caCertificate: '', clusterName: "do-ams3-test", contextName: '', credentialsId: "mykubeconfig", namespace: '', serverUrl: "https://8a604b66-43ff-4f24-926c-29b158894e10.k8s.ondigitalocean.com") {
                    sh """ sed -i 's/#BUILD_NUMBER/${env.BUILD_ID}/g' k8s/server-deployment.yaml """
                    sh """  kubectl apply -f k8s//  """
                    sh """  kubectl get pods """
                    sh """  cat k8s/server-deployment.yaml """
                    sh """  minikube ip """


                  }
                }
              }
            
           
            }
   }

         post {  
         always {  
             echo 'Job Finished Successfully, Cleaning ........'  
             deleteDir()
             script {
             myUtils.CleanDocker()
             }
         }  
         success {  
             echo 'This will run only if successful'  
            //  mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "hossamyahia107@gmail.com";   

         }  
         failure {  
          echo 'FAIL'  

            //  mail bcc: '', body: "<b>Example</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "hossamyahia107@gmail.com";   
         }  
         unstable {  
             echo 'This will run only if the run was marked as unstable'  
         }  
         changed {  
             echo 'This will run only if the state of the Pipeline has changed'  
             echo 'For example, if the Pipeline was previously failing but is now successful'  
         }    
}
}
  