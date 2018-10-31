#!groovy

pipeline {
    agent any

    environment {
        def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
        def gitUrl = sh(returnStdout: true, script: 'git config remote.origin.url').trim()
    }

    stages {
        stage('Docker Build'){
            steps {
                sh 'GIT_URL=${gitUrl} GIT_BRANCH=${BRANCH_NAME} GIT_COMMIT=${gitCommit} /usr/local/bin/sesh_build.sh prod'
            }
        }

    }

    post {
        success {
            slackSend  failOnError: true,
                           channel: '#jenkins',
                             color: '#139C8A',
                           message: "BUILD SUCCESS:\n  JOB: ${env.JOB_NAME} [${env.BUILD_NUMBER}]\n  BUILD URL: ${env.BUILD_URL}"
        }

        failure {
            slackSend  failOnError: true,
                           channel: '#jenkins',
                             color: '#FF6347',
                           message: "BUILD FAILURE:\n  JOB: ${env.JOB_NAME} [${env.BUILD_NUMBER}]\n  BUILD URL: ${env.BUILD_URL}"
        }
      
        }
    }

      }
}