## @file app.py
# @brief A simple flask application
from flask import Flask, render_template
from flask_cors import CORS

## Setup
app = Flask(__name__, static_folder='./templates/styles', template_folder='./templates')
CORS(app)

## Homepage, renders using templates/index.html.
@app.route('/')
def homepage():
    return render_template('index.html')