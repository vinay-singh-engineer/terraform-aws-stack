#!/bin/bash

# Update system
yum update -y

# Install Python + pip
yum install -y python3 python3-pip

# Install Flask
pip3 install flask

# Create app directory
mkdir -p /opt/flask-app/templates

# Create Flask app
cat <<EOF > /opt/flask-app/app.py
from flask import Flask, render_template
from datetime import datetime

app = Flask(__name__)

@app.route("/")
def home():
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return render_template("index.html", current_time=current_time)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
EOF

# Create HTML template
cat <<EOF > /opt/flask-app/templates/index.html
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
			color: #9ca3af;  /* nice gray */
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
EOF
EOF

# Start application
cd /opt/flask-app

nohup python3 app.py > app.log 2>&1 &