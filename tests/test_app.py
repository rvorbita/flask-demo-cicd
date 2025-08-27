import app

def test_health():
    client = app.app.test_client()
    resp = client.get("/health")
    assert resp.status_code == 200
    assert resp.json["status"] == "ok"
    print("Health-check endpoint:", resp.json)


def test_home():
    clinet = app.app.test_client()
    resp = clinet.get("/")
    assert resp.status_code == 200
    assert resp.json['message'] == "Hello, CI/CD with Jenkins in Docker!"
    print("Home endpoint:", resp.json)
