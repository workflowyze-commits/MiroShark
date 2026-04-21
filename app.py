import os
from flask import Flask, send_from_directory
from backend.main import app as backend_app

app = Flask(__name__, static_folder='dist')

# Connect the AI Agent logic from the backend folder
app.register_blueprint(backend_app, url_prefix='/api')

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path != "" and os.path.exists(app.static_folder + '/' + path):
        return send_from_directory(app.static_folder, path)
    else:
        return send_from_directory(app.static_folder, 'index.html')

if __name__ == "__main__":
    # This matches the port we set in the Dockerfile
    port = int(os.environ.get("PORT", 5001))
    app.run(host='0.0.0.0', port=port)
