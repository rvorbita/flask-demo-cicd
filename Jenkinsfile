pipeline {
    
    agent any 
    
    stages {
        stage('Check out github repo') {
            steps {
                git branch: 'main', url: 'https://github.com/rvorbita/flask-demo-cicd'
            }
            
            post {
                success {
                    echo "Repo checkout successful."
                }
                failure {
                    echo "Failed to checkout repo."
                }
            }
        }
        
        stage('Setup environment') {
            steps {
                sh ''' 
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install -r requirements.txt
                '''
            }
            post {
                always {
                    echo "Environment setup stage finished."
                }
            }
        }
        
        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    export PYTHONPATH=$PWD
                    pytest -s -v \
                    --junitxml=reports/results.xml \
                    --cov=app --cov-report=xml --cov-report=html \
                    tests/
                '''
            }
            
            post {
                always {
                        junit 'reports/*.xml'  // publish pytest results
                        archiveArtifacts artifacts: 'coverage.xml, htmlcov/**', fingerprint: true
                        publishHTML(target: [
                            allowMissing: false,
                            alwaysLinkToLastBuild: true,
                            keepAll: true,
                            reportDir: 'htmlcov',
                            reportFiles: 'index.html',
                            reportName: 'Coverage Report'
                        ])
                    }
                
                success {
                    echo "Tests passed"
                }
                failure {
                    echo "Tests Failed - check test reports in jenkins."
                }
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying application."
            }
            post {
                always {
                    echo "Deploy stage completed."
                }
            }
        }
    }
    
    post {
        success {
            echo "All stages completed successfully!"
        }
        failure {
            echo "Pipeline failed. Sending alert..."
        }
        always {
            echo "Pipeline execution finished!"
        }
    }
}
