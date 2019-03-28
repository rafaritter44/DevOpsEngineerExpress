import os
from flask import Flask
app = Flask(__name__)

@app.route("/env/<name>/<var>", methods=["POST"])
def make_env_var(name, var):
    os.putenv(name, var)
    return os.popen("echo ${}".format(name)).read()

if __name__ == "__main__":
    app.run(port=8080)