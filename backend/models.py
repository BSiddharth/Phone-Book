from app import app
from flask_sqlalchemy import SQLAlchemy

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test.db'
db = SQLAlchemy(app)

class Contact(db.Model):
    id = db.Column(db.Integer, primary_key = True)    
    name = db.Column(db.String)
    number = db.Column(db.String)
    uid = db.Column(db.String)

    def __repr__(self):
        return self.name + ' ' + self.number