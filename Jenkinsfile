@Library('jenkins-shared-libraries')_
def myUtils = new io.abc.pipelinedeclrative()
pipeline {
   agent any
   stages {
     stage('Clone  Repositry'){
        steps{
          script {
          myUtils.CheckOutScm('https://github.com/hossameltohamy/nodejs-with-docker-k8s.git','master','')
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
         }  
         failure {  
             sh "failuer happen"  
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
  