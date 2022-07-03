from flask import Flask, jsonify,request
from flask_cors import cross_origin
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
@cross_origin()
def contacts():
    response = []
    for x in Contact.query.all():
        data = {}
        data['number'] = str(x.number)
        data['name'] = str(x.name)
        data['uid'] = str(x.uid)
        response.append(data)
    return jsonify(response),200 

@app.route("/add", methods=['POST'])
@cross_origin()
def add():
    name = request.form['name']
    number = request.form['number']
    uid = request.form['uid']
    contact = Contact(name = name, uid = uid, number = number)
    db.session.add(contact)
    db.session.commit()
    return '',200

@app.route("/delete", methods=['POST'])
@cross_origin()
def delete():
    uid = request.form['uid']
    toDelete = Contact.query.filter_by(uid=uid).first()
    db.session.delete(toDelete)
    db.session.commit()
    return '',200

@app.route("/edit", methods=['POST'])
@cross_origin()
def edit():
    name = request.form['name']
    number = request.form['number']
    uid = request.form['uid']
    toEdit = Contact.query.filter_by(uid=uid).first()
    toEdit.name = name
    toEdit.number = number
    db.session.commit()
    return '',200



if __name__ == "__main__":
    app.run(debug=True)
