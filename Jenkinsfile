pipeline {
  
  agent any
   
  environment {
  registry = "amandavkar/zipkin"
  registryCredential = 'dockerhub'
  dockerImage = ''
  }
  
  tools {
     // Install the Maven version configured as "M3" and add it to the path.
     maven "Maven"
  }

  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/amandavkar/Microservice-Zipkin-Server.git'
      }
    }
	
	stage('Build jar file') {
	  steps {
        // Run Maven on a Unix agent.
        sh "mvn -Dmaven.test.failure.ignore=true -DskipTests=true clean package"

        // To run Maven on a Windows agent, use
        // bat "mvn -Dmaven.test.failure.ignore=true -DskipTests=true clean package"
	  }
    }

    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
			dockerImage.push("latest")
          }
        }
      }
    }

	stage('Remove Unused docker image') {
	  steps{
		sh "docker rmi $registry:$BUILD_NUMBER"
	  }
	}
	
//	stage('Copy kustomization, deployment and service YAML files to Kubernetes master') {
//	  steps{
//	      sh "scp -r movie-info-service.yml vagrant@k8s-master:/home/vagrant"
//	  }
//	}
//	
//	stage('Execute Ansible playbook to deploy service in Kubernetes') {
//	  steps{
//		ansiblePlaybook installation: 'Ansible', inventory: '/etc/ansible/hosts', playbook: 'playbook-movie-info-service.yml'
//	  }
//	}
  }
	
}
