class ItensAvaliacaoRca():
    def __init__(self, descricao, peso, id = None):
        self.__id = id
        self.__descricao = descricao
        self.__peso = peso

    @property
    def id(self):
        return self.__id

    @property
    def descricao(self):
        return self.__descricao
    @descricao.setter
    def descricao(self, descricao):
        self.__descricao = descricao

    @property
    def peso(self):
        return self.__peso
    @peso.setter
    def peso(self, peso):
        self.__peso = peso


class ItensAvaliacaoCliente():
    def __init__(self, descricao, id= None ):
        self.__id = id
        self.__descricao = descricao

    @property
    def descricao(self):
        return self.__descricao

    @descricao.setter
    def descricao(self, descricao):
        self.__descricao = descricao

    @property
    def id(self):
        return self.__id

class Departamento():
    def __init__(self, descricao, id = None):
        self.__id = id
        self.__descricao = descricao

    @property
    def descricao(self):
        return self.__descricao

    @descricao.setter
    def descricao(self, descricao):
        self.__descricao = descricao

    @property
    def id(self):
        return self.__id

class AvaliacaoSupervRcaItem():
    def __init__(self, capaavaliacao, itemavalicao, resposta, id=None):
        self.__id = id
        self.__capaavaliacao = capaavaliacao
        self.__itemavaliacao = itemavalicao
        self.__resposta = resposta

    @property
    def capaavaliacao(self):
        return self.__capaavaliacao

    @property
    def itemavaliacao(self):
        return self.__itemavaliacao

    @property
    def resposta(self):
        return self.__resposta

    @resposta.setter
    def resposta(self, resposta):
        self.__resposta = resposta

    @property
    def id(self):
        return self.__id

class AvaliacaoSupervRcaCapa():
    def __init__(self, rca, data, id=None ):
        self.__id = id
        self.__aprovado = False
        self.__rca = rca
        self.__data = data
        self.__itens = []

    @property
    def rca(self):
        return self.__rca

    @rca.setter
    def rca(self, rca):
        self.__rca = rca

    @property
    def aprovado(self):
        return self.__aprovado

    @property
    def data(self):
        return self.__data
    @data.setter
    def data(self, data):
        self.__data = data

    @property
    def itens(self):
        return self.__itens

    def adiciona_item_de_avaliacao(self, obj_item):
        self.__itens.append(obj_item)





