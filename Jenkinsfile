pipeline {
  agent any

  environment {
    VENV = 'venv'
  }

  stages {
    stage('Checkout Git') {
      steps {
        git branch: 'main', url: 'https://github.com/rvorbita/flask-demo-cicd'
      }
    }

    stage('Setup Python venv') {
      steps {
        sh '''
          python3 -m venv ${VENV}
          . ${VENV}/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
        '''
      }
    }

    stage('Lint & Test') {
      steps {
        sh '''
          . ${VENV}/bin/activate
          pip install flake8 pytest
          flake8 .
          mkdir -p reports
          pytest -q --junitxml=reports/junit.xml
        '''
      }
      post {
        always {
          junit 'reports/junit.xml'
        }
      }
    }

    stage('Run Flask App (smoke test)') {
      steps {
        sh '''
          . ${VENV}/bin/activate
          nohup python app.py > flask.log 2>&1 &
          FLASK_PID=$!
          sleep 5
          curl -f http://127.0.0.1:5000/ || (echo "Flask app did not start!" && kill $FLASK_PID && exit 1)
          kill $FLASK_PID
        '''
      }
    }
  }

  post {
    success {
      echo "✔ Flask pipeline finished successfully."
    }
    failure {
      echo "✖ Build failed. Check logs."
    }
  }
}

