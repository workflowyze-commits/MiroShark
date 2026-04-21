import os
from flask import Flask, send_from_directory
# We changed 'main' to 'run' here to match your actual file!
from backend.run import app as backend_app 

app = Flask(__name__, static_folder='dist')

# Connect the AI Agent logic
app.register_blueprint(backend_app, url_prefix='/api')

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def serve(path):
    if path != "" and os.path.exists(app.static_folder + '/' + path):
        return send_from_directory(app.static_folder, path)
    else:
        # If you don't have a 'dist' folder yet, this might error, 
        # but let's get the backend connected first!
        return "WorkfloWyze Backend is Running. Frontend pending build."

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5001))
    app.run(host='0.0.0.0', port=port)
