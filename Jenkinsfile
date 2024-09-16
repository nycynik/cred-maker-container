pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub')  // Reference to Docker Hub credentials
        DOCKER_IMAGE = 'nycynik/credzmaker'  // Docker image name
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the GitHub repository
                git branch: 'main', url: 'https://github.com/nycynik/cred-maker-container.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub and push the image
                    sh "echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin"
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Deploy the image to the Kubernetes cluster
                    // Assuming you have a Kubernetes YAML manifest file for your deployment
                    sh """
                    kubectl set image deployment/your-deployment your-container=${DOCKER_IMAGE}:${BUILD_NUMBER} --record
                    kubectl rollout status deployment/your-deployment
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Docker Image pushed to Docker Hub and deployed to Kubernetes successfully."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
