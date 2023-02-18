from flask import Flask, render_template
from flask_cors import CORS

app = Flask(__name__, static_folder='./templates/styles', template_folder='./templates')
CORS(app)

@app.route('/')
def homepage():
    return render_template('index.html')