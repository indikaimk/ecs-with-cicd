import pytest
from app import create_app


@pytest.fixture
def client():
    app = create_app()
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_index_route(client):
    """Test the root endpoint returns operational status."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.get_json()
    assert data["message"] == "Welcome to Flask on AWS ECS Fargate!"
    assert data["status"] == "operational"
    assert "version" in data


def test_health_check_route(client):
    """Test the /health endpoint used by ALB."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.get_json()
    assert data["status"] == "healthy"
    assert "uptime_seconds" in data


def test_info_route(client):
    """Test the /api/v1/info endpoint."""
    response = client.get("/api/v1/info")
    assert response.status_code == 200
    data = response.get_json()
    assert "python_version" in data
    assert "environment" in data
