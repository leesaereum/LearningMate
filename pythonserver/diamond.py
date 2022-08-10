import imp
from flask import Flask, jsonify, render_template, request
import joblib

app = Flask(__name__)

@app.route("/diamond")
def iris():
    carat = float(request.args.get("carat"))
    clarity = float(request.args.get("clarity"))
    width  = float(request.args.get("width"))

    clf = joblib.load("./best_diamond_price_predict.h5")
    pre = clf.predict([[carat, clarity, width]])
    print(pre)
    return jsonify({'result' : str(pre[0])})

def home():
    return render_template("home.html")

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)