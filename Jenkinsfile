pipeline {
    agent any

    parameters {
        string(name: 'VERSION', defaultValue: '1.0.0')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'test', 'staging'])
    }

    stages {

        stage('Build') {
            steps {
                bat '''
                echo Compiling...
                del /Q sources.txt 2>NUL
                dir /S /B src\\*.java > sources.txt
                javac @sources.txt
                if %ERRORLEVEL% NEQ 0 exit /b 1
                '''
            }
        }

        stage('Test') {
            steps {
                bat '''
                echo Running tests...
                java -cp "src\\main\\java;src\\test\\java" com.devops.CalculatorTest
                if %ERRORLEVEL% NEQ 0 exit /b 1
                '''
            }
        }

        stage('Package') {
            steps {
                bat '''
                echo Packaging...
                if not exist package mkdir package
                jar cfe calculator.jar com.devops.Calculator -C src\\main\\java .
                copy calculator.jar package\\
                echo version=%VERSION% > package\\version.txt
                echo environment=%ENVIRONMENT% >> package\\version.txt
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'package/**'
        }
        success {
            echo 'Pipeline completed successfully'
        }
        failure {
            echo 'Pipeline failed'
        }
    }
}

