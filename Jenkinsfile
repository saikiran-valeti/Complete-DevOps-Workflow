pipeline {
 agent any

 parameters {
  string(name: 'VERSION', defaultValue: '1.0.0')
  choice(name: 'ENVIRONMENT', choices: ['dev','test','staging'])
 }

 stages {
  stage('Build') {
   steps {
    sh 'chmod +x scripts/build.sh'
    sh './scripts/build.sh'
   }
  }

  stage('Test') {
   steps {
    sh 'java -cp src/main/java:src/test/java com.devops.CalculatorTest'
   }
  }

  stage('Package') {
   steps {
    sh '''
    mkdir -p package
    cp calculator.jar package/
    echo "version=${VERSION}" > package/version.txt
    '''
   }
  }
 }

 post {
  always {
   archiveArtifacts artifacts: 'package/**'
  }
 }
}
