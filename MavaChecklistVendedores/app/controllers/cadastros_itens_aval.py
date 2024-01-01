from Projeto_Checklist_Vendedores.app import app
from flask import render_template, redirect, url_for




# Página de cadastro de itens que compõem a lista de avaliação do Supervisor x RCA
@app.route('/cadastroitensavaliacaorca')
def cadastro_itens_avaliacao_rca():
    #itens = item_aval_rca_dao.listar()
    itens = []
    return render_template('frm_item_aval_rca.html', itens=itens,
                           titulo_pagina='Cadastro de Itens de Avaliação dos RCAs')