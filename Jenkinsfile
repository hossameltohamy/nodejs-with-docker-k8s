@Library('jenkins-shared-libraries')_
def myUtils = new io.abc.pipelinedeclrative()
pipeline {
   agent any
     environment { 
        registry = "hossamyahia107/nodejs-api" 
        registryCredential = 'dockerhub_id' 
        dockerImage = ''  
        SonarQubescannerHome = tool 'SonarQube Scanner 2.8'
        server= 'http://137.184.100.206:9000'
        PROJECT_KEY='nodejs'
        CODE_DIR= "${JENKINS_HOME}/workspace/${env.JOB_NAME}"
         
    }
     tools {nodejs "nodejs"}
    //  tool 'sonarqube-scanner'
   stages {

      stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube Scanner 2.8') {
                echo  "${PROJECT_KEY}"
          	    sh "cd ${CODE_DIR} && ${SonarQubescannerHome}/bin/sonar-scanner -Dsonar.host.url=${SERVER} -Dsonar.projectKey=${env.JOB_NAME} -Dsonar.java.binaries=${SonarQubescannerHome}/bin/  -Dsonar.login=a85ffda962dfd2408cb0985fda93cbbc2a3933eb  -Dsonar.projectName=${PROJECT_KEY} -Dsonar.sourceEncoding=UTF-8 -Dsonar.webhooks.global.1.url=${SERVER}  -Dsonar.sources=. -Dsonar.projectVersion=1.0"
                sleep 10
                }
            }
        }
        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }
    
    stage('Test App') {
      steps{
       sh 'docker run --name some-postgres -e POSTGRES_PASSWORD=hossam@107@test -d -p 5432:5432 postgres'
       sh 'npm install --only=dev'
       sh 'npm install lodash --save'
       sh 'NODE_ENV=test PGHOST=localhost PGUSER=postgres PGPASSWORD=hossam@107@test  PGDATABASE=test-db  npm run test' 
        // sh 'docker rm -f some-postgres ' 

      }
   }
   stage('Build Docker Images'){
     steps{
       script{
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
            stage ('Deploy to k8s'){
              steps{
                script{
                      withKubeConfig(caCertificate: '', clusterName: "do-ams3-test", contextName: '', credentialsId: "mykubeconfig", namespace: '', serverUrl: "https://753b7942-906c-4ebf-b3bd-04a85ae5ef94.k8s.ondigitalocean.com") {
                    sh """ sed -i 's/#BUILD_NUMBER/${env.BUILD_ID}/g' k8s/server-deployment.yaml """
                    sh """  kubectl apply -f k8s//  """
                  }
                }
              }
            }
   }
         post {  
         always {  
             echo 'Job Finished Successfully, Cleaning ........'  
             deleteDir()
         }  
         success {  
             mail bcc: '', body: "<b>${currentBuild.currentResult} !! </b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.currentResult} CI: Project name -> ${env.JOB_NAME}", to: "hossamyahia107@gmail.com";   
         }  
        
       
}
}
  