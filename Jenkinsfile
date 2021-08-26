def projectName = 'petclinic'
def version = "0.0.${currentBuild.number}"
def dockerImageTag = "${projectName}:${version}"

pipeline {
  agent any
  

  stages {
    stage('Create project') {
    steps {
        sh """
oc login https://localhost:8443 --username admin --password admin --insecure-skip-tls-verify=true
if ! oc project ${projectName}
then
  oc new-project ${projectName}
fi"""
      }
    }
    

    stage('Compile PetClinic') {
      steps {
        
          sh "docker build -t ${dockerImageTag} ."
      }
    }

    stage('Deploy Container To Openshift') {
      
      steps {
        sh "oc login https://localhost:8443 --username admin --password admin --insecure-skip-tls-verify=true"
        sh "oc project ${projectName} || oc new-project ${projectName}"
        sh "oc delete all --selector app=${projectName} || echo 'Unable to delete all previous openshift resources'"
        sh "oc new-app ${dockerImageTag} -l version=${version}"
        sh "oc expose svc/${projectName}"
      }
    }
  }
}

'''
    stage('Build add or update Petclinic configuration') {
      steps {
        sh """cd openshift
oc login https://localhost:8443 --username admin --password admin --insecure-skip-tls-verify=true
oc project ${projectName}
oc apply -f petclinic-imagestream.yaml
# oc apply -f petclinic-build.yaml
oc apply -f petclinic-service.yaml
oc apply -f petclinic-route.yaml || echo 'Route already in place'"""
        }
    }
    stage('Build Petclinic image') {
      steps {
        sh """oc login https://localhost:8443 --username admin --password admin --insecure-skip-tls-verify=true
find .
cd containers/petclinic

      }
    }
    stage('Deploy PetcClinic Container To Openshift') {
      steps {
        sh """cd openshift
oc login https://localhost:8443 --username admin --password admin --insecure-skip-tls-verify=true
oc project ${projectName}
oc apply -f petclinic-deploymentconfig.yaml"""
      }
    }
   
  }

}
'''
