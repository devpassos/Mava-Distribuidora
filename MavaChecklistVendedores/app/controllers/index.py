from Projeto_Checklist_Vendedores.app  import app
from flask import render_template


# Página Inicial
@app.route('/')
def index():
    return render_template('index_mavachecklist.html', titulo_pagina='Página Inicial do Projeto',
                           titulo_aba='Sistema de Avaliação - Index')