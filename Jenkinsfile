pipeline {
agent {label 'jnlp'}
  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/hossameltohamy/nodejs-with-docker-k8s.git', branch:'master'
      }
    }
      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("hossamyahia107/nodejs-api:${env.BUILD_ID}")
                }
            }
        }
    
      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }
    stage('Deploy App') {
      steps {
        // script {
        //   kubernetesDeploy(configs: "server-deployment.yaml", kubeconfigId: "mykubeconfig")
        // }
        ///CREATE AND APPLY THE PATCH. REMEMBER TO LOGIN ON THE CLUSTER. (-s $CLUSTER_URL --token $TOKEN_CLUSTER --insecure-skip-tls-verify)
        sh  '''          
        PATCH_TO_DEPLOY={\\"metadata\\":{\\"labels\\":{\\"version\\":\\"${env.BUILD_ID}\\"}},\\"spec\\":{\\"template\\":{\\"metadata\\":{\\"labels\\":{\\"version\\":\\"${env.BUILD_ID}\\"}},\\"spec\\":{\\"containers\\":[{\\"name\\":\\"$NAME_DEPLOY\\",\\"image\\":\\"my-image:${env.BUILD_ID}\\"}]}}}}
                        
        kubectl patch deployment $NAME_DEPLOY  -n $NAMESPACE -p $PATCH_TO_DEPLOY \
        -s $CLUSTER_URL --token $TOKEN_CLUSTER --insecure-skip-tls-verify
                        
        '''
      }
    }

  }

}