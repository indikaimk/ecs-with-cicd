.PHONY: help install test lint docker-build docker-run tofu-init tofu-fmt tofu-validate

help:
	@echo "Available commands:"
	@echo "  make install        Install Python dependencies"
	@echo "  make test           Run unit tests with coverage"
	@echo "  make lint           Run ruff linter"
	@echo "  make docker-build   Build Docker container locally"
	@echo "  make docker-run     Run Docker container on port 5000"
	@echo "  make tofu-fmt       Format OpenTofu code"
	@echo "  make tofu-validate  Validate OpenTofu code"

install:
	pip install -r app/requirements.txt

test:
	pytest app/tests/ -v --cov=app/src

lint:
	ruff check app/

docker-build:
	docker build -t ecs-flask-app:latest ./app

docker-run:
	docker run --rm -p 5000:5000 --name ecs-flask-app ecs-flask-app:latest

tofu-fmt:
	tofu -chdir=infra fmt -recursive

tofu-validate:
	tofu -chdir=infra init -backend=false
	tofu -chdir=infra validate
