from flask import Flask

app = Flask(__name__)

@app.route("/contacts", methods=['POST'])
def contacts():
    #  retrieve all contacts
    pass

@app.route("/add", methods=['POST'])
def add():
    # add contact to the database
    pass

@app.route("/delete", methods=['POST'])
def delete():
    # delete contact from the database
    pass
    
@app.route("/edit", methods=['POST'])
def edit():
    # edit a contact from the database
    pass