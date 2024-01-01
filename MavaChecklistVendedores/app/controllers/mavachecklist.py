from flask import Flask, render_template, request, redirect, flash, url_for
from flask_mysqldb import MySQL
from Projeto_Checklist_Vendedores.app.models import RcaDao, ItemAvalicaoRcaDao
from Projeto_Checklist_Vendedores.app.models import RCA
from Projeto_Checklist_Vendedores.app.models import ItensAvaliacaoRca

app = Flask(__name__)
app.secret_key = 'mava@2021'

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'admin'
app.config['MYSQL_DB'] = 'mavachecklist'
app.config['MYSQL_PORT'] = 3306

db = MySQL(app)

rca_dao = RcaDao(db)
item_aval_rca_dao = ItemAvalicaoRcaDao(db)










# Recurso que grava o cadastro do item de avaliação no banco.
@app.route('/gravaitemavalrca', methods=['POST', ])
def gravaitemavalrca():
    descricao = request.form.get('descricao')
    peso = request.form.get('peso')
    item_aval = ItensAvaliacaoRca(descricao, peso)
    item_aval_rca_dao.salvar(item_aval)
    flash('Item Incluído da Base de Dados')
    return redirect(url_for('cadastro_itens_avaliacao_rca'))

# Recurso que deleta o item de avaliação do banco
@app.route('/deleteitemavalrca/<int:id>')
def delete_item_aval_rca(id):
    item_aval_rca_dao.deletar(id)
    flash('Item deletado da base de dados')
    return redirect(url_for('cadastro_itens_avaliacao_rca'))



