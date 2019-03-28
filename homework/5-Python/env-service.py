import os
from flask import Flask
app = Flask(__name__)

@app.route("/conf/env")
def env_vars():
    env_vars = os.popen("printenv")
    return env_vars.read()

if __name__ == "__main__":
    app.run(port=8080)