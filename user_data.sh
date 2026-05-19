#!/bin/bash
set -xe
exec > /var/log/user_data.log 2>&1

# Update system
yum update -y

# Install Python, pip, and nginx
yum install -y python3 python3-pip
amazon-linux-extras install nginx1 -y

# Install pinned dependencies (Flask 2.x supports Python 3.7 on Amazon Linux 2)
pip3 install "flask==2.2.5" "gunicorn==21.2.0"

# Create app directory
mkdir -p /opt/flask-app/templates

# Create Flask app
cat <<'PYEOF' > /opt/flask-app/app.py
from flask import Flask, render_template
from datetime import datetime, timezone

app = Flask(__name__)

@app.route("/")
def home():
    current_time = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    return render_template("index.html", current_time=current_time)
PYEOF

# Create HTML template
cat <<'HTMLEOF' > /opt/flask-app/templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Python Flask App</title>

    <style>
        body {
            margin: 0;
            background: radial-gradient(circle at top, #0f172a, #020617);
            color: #00ff99;
            font-family: "Courier New", monospace;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .role {
            color: #9ca3af;
            margin-top: 10px;
        }
        .box {
            text-align: center;
            padding: 50px;
            border: 2px solid #00ff99;
            border-radius: 15px;
            box-shadow: 0 0 25px #00ff99;
        }

        .typewriter h1 {
            overflow: hidden;
            border-right: .15em solid #00ff99;
            white-space: nowrap;
            animation: typing 3s steps(30, end),
                       blink 0.8s infinite;
            font-size: 2.5rem;
        }

        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }

        @keyframes blink {
            50% { border-color: transparent }
        }

        .time {
            margin-top: 20px;
            font-size: 1.2rem;
            color: #38bdf8;
        }
    </style>
</head>

<body>

<div class="box">
    <div class="typewriter">
        <h1>Hello from Python Flask App! 🚀</h1>
    </div>

    <div class="time">
        Current Time (EC2):<br>
        <strong>{{ current_time }}</strong>
    </div>
    <div class="role">Senior Site Reliability Engineer - Vinay Singh!</div>
</div>

</body>
</html>
HTMLEOF

# Configure nginx to proxy port 80 → gunicorn on 8000
cat <<'NGINXEOF' > /etc/nginx/conf.d/flask-app.conf
server {
    listen 80 default_server;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
NGINXEOF

# Remove default nginx config to avoid port conflicts
rm -f /etc/nginx/conf.d/default.conf

# Create systemd service for gunicorn
cat <<'SVCEOF' > /etc/systemd/system/flask-app.service
[Unit]
Description=Flask Web App (Gunicorn)
After=network.target

[Service]
WorkingDirectory=/opt/flask-app
ExecStart=/usr/bin/python3 -m gunicorn app:app --bind 127.0.0.1:8000 --workers 2
Restart=on-failure
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
SVCEOF

systemctl daemon-reload
systemctl enable flask-app
systemctl start flask-app

systemctl enable nginx
systemctl start nginx
