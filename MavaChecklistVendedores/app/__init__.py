from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.secret_key = 'mava@2021'

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:admin@localhost/mavachecklist'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


from Projeto_Checklist_Vendedores.app.models import tables
from Projeto_Checklist_Vendedores.app.controllers import index, cadastros_rca, cadastros_itens_aval


