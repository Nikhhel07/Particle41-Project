from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def get_visitor_info():
    visitor_ip = request.remote_addr
    current_time = datetime.utcnow().isoformat()
    return jsonify({
        "timestamp": current_time,
        "ip": visitor_ip
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
