from Projeto_Checklist_Vendedores.app import app, db
from Projeto_Checklist_Vendedores.app.models.tables import TRCA
from flask import render_template, flash, redirect, url_for, request


# Página de Cadastro do RCA
@app.route('/cadastrorca')
def cadastrorca():
    lista_rca = db.session.query(TRCA)
    return render_template('frm_cadastro_rca.html', titulo_pagina='Cadastro RCA', rcas=lista_rca)


# Recurso que grava o registro do RCA no banco
@app.route('/gravarca', methods=['POST', ])
def gravarca():

    idrca = request.form.get('codigo')
    nome = request.form.get('nome')
    rca = TRCA(nome, idrca=idrca)

    db.session.add(rca)
    db.session.commit()
    flash('RCA Incluido!')
    return redirect(url_for('cadastrorca'))

# Recurso que deleta o RCA do banco
@app.route('/delete_rca/<int:id>')
def delete_rca(id):
    rca = db.session.query(TRCA).filter_by(idrca=id).all()

    flash('RCA Deletado da Base de dados')
    return redirect(url_for('cadastrorca'))