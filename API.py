from flask import Flask, render_template
from flask import request
import requests


app = Flask(__name__, template_folder="template")


@app.route("/", methods=["post", "get"])
def Home():
    msg = ""
    resp = ""
    resPlt = ""
    image = ""
    if request.method == "POST":
        age = request.form.get("age")
        sex = request.form.get("sex")
        wt = request.form.get("wt")
        cr = request.form.get("cr")
        sexStat = ""
        if sex == "m":
            sexStat = "man"
        elif sex == "f":
            sexStat = "woman"
        msg = f"In a {age} year old {sexStat} with {wt} Kgs wieght, creatinin level of {cr} makes a GFR estimation of:"

        apiUrl = "http://127.0.0.1:7767/gfr"
        body = {"age": age, "sex": sex, "wt": wt, "cr": cr}
        response = requests.post(apiUrl, data=body).json()
        resp = round(response[0], 1)
        image = f"http://127.0.0.1:7767/plt?age={age}&sex={sex}&wt={wt}&cr={cr}"
    return render_template("gfr-tmp.html", message=msg, response=resp, image=image)
