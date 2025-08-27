# Flask + Jenkins (Docker) CI/CD Starter

This is the sample project for running Jenkins **inside Docker** and using a declarative pipeline to test, build, push, and deploy a Flask app.

## Structure
```
flask-jenkins-docker/
├── app.py
├── requirements.txt
├── tests/
│   └── test_app.py
├── Dockerfile
├── .dockerignore
├── Jenkinsfile
├── compose.yaml            # local app testing
├── docker-compose.jenkins.yml  # runs Jenkins in Docker
└── deploy/
    └── deploy_on_server.sh
```

## Run Jenkins in Docker
```bash
docker compose -f docker-compose.jenkins.yml up -d
```

Jenkins UI: http://localhost:8080

Get initial password:
```bash
docker logs jenkins
```

## Local App Run
```bash
docker build -t flask-ci-cd:dev .
docker run -p 5000:5000 flask-ci-cd:dev
```

Open http://localhost:5000
