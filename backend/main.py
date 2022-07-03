from flask import Flask, jsonify,request
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


class Contact(db.Model):
    id = db.Column(db.Integer, primary_key = True)    
    name = db.Column(db.String)
    number = db.Column(db.String)
    uid = db.Column(db.String)

    def __repr__(self):
        return self.name + ' ' + self.number


db.create_all()

@app.route("/contacts", methods=['POST'])
def contacts():
    data = {}
    for x in Contact.query.all():
        data[x.name] = x.number
    
    return jsonify(data),200 

@app.route("/add", methods=['POST'])
def add():
    name = request.form['name']
    number = request.form['number']
    uid = request.form['uid']
    contact = Contact(name = name, uid = uid, number = number)
    db.session.add(contact)
    db.session.commit()
    return '',200

@app.route("/delete", methods=['POST'])
def delete():
    uid = request.form['uid']
    toDelete = Contact.query.filter_by(uid=uid).first()
    db.session.delete(toDelete)
    db.session.commit()
    return '',200
    
@app.route("/edit", methods=['POST'])
def edit():
    # edit a contact from the database
    pass

if __name__ == "__main__":
    app.run(debug=True)
