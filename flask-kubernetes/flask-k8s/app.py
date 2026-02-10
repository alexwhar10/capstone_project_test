from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def root():
    return jsonify(message="Flask running on Kubernetes")

@app.get("/health")
def health():
    return jsonify(status="healthy")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)