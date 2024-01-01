from Projeto_Checklist_Vendedores.app import db


class TRCA(db.Model):
    __tablename__ = "rca"

    idrca = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(45), unique=True)

    def __init__(self, nome, idrca=None):
        self.idrca = idrca
        self.nome = nome


class TDEPTO(db.Model):
    __tablename__ = "departamentos"

    iddepartamento = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String)

    def __init__(self, descricao, iddepartamento=None):
        self.iddepartamento = iddepartamento
        self.descricao = descricao


class TItensAvaliacaoRca(db.Model):
    __tablename__ = 'itensavaliacaorca'

    iditem = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String)
    peso = db.column(db.Integer)

    def __init__(self, descricao, peso, iditem=None):
        self.iditem = iditem
        self.descricao = descricao
        self.peso = peso
