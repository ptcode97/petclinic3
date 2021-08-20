def projectName = 'petclinic'
def version = "0.0.${currentBuild.number}"
def dockerImageTag = "${projectName}:${version}"

pipeline {
  agent any
  parameters {
    string(name: 'projectName', description: 'Project name to create or target for update')
  }

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
# Delete old build first
oc delete buildconfigs/petclinic || echo "Already deleted PC build config"
oc delete is/petclinic || echo "Already deleted PC image stream"
oc delete is/openjdk || echo "Already deleted Java image stream"
oc new-build --strategy docker --binary --docker-image openjdk:11 --name petclinic
oc start-build petclinic --from-dir . --follow"""
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
