def test_hello_endpoint(client):
    response = client.get("/api/hello")
    assert response.status_code == 200
    data = response.get_json()
    assert data["message"] == "Hello World!"


def test_hello_returns_json(client):
    response = client.get("/api/hello")
    assert response.content_type == "application/json"


def test_index_returns_html(client):
    response = client.get("/")
    assert response.status_code == 200


def test_security_headers(client):
    response = client.get("/api/hello")
    assert response.headers["X-Content-Type-Options"] == "nosniff"
    assert response.headers["X-Frame-Options"] == "DENY"
    assert response.headers["X-XSS-Protection"] == "1; mode=block"
    assert response.headers["Referrer-Policy"] == "strict-origin-when-cross-origin"


def test_404(client):
    response = client.get("/nonexistent")
    assert response.status_code == 404
