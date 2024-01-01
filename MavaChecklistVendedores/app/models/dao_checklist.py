from RCA import RCA
from Avaliacao import ItensAvaliacaoRca

SQL_CRIA_RCA = 'INSERT into rca (idrca, nome) values (%s, %s)'
SQL_DELETA_RCA = 'delete from rca where idrca = %s'
SQL_RCA_POR_ID = 'SELECT idrca, nome from rca where id = %s'
SQL_ATUALIZA_RCA = 'UPDATE rca SET nome=%s, where idrca = %s'
SQL_BUSCA_RCAS = 'SELECT idrca, nome from rca'

SQL_CRIA_ITEM_AVAL_RCA = 'INSERT into itensavaliacaorca (descricao, peso) values (%s, %s)'
SQL_DELETA_ITEM_AVAL_RCA = 'delete from itensavaliacaorca where iditem = %s'
SQL_ITEM_AVAL_RCA_POR_ID = 'SELECT iditem, descricao, peso from itensavaliacaorca where iditem = %s'
SQL_ATUALIZA_ITEM_AVAL_RCA = 'UPDATE itensavaliacaorca SET descricao=%s, peso=%s where iditem = %s'
SQL_BUSCA_ITEM_AVAL_RCA = 'SELECT iditem, descricao, peso from itensavaliacaorca'




class RcaDao():
    def __init__(self, db):
        self.__db = db

    def salvar(self, rca):
        cursor = self.__db.connection.cursor()

        busca_id = cursor.execute('SELECT idrca FROM rca where idrca = %s', (rca.id,))

        if busca_id:
            cursor.execute(SQL_ATUALIZA_RCA, (rca.nome))
        else:
            cursor.execute(SQL_CRIA_RCA, (rca.id, rca.nome))

        self.__db.connection.commit()

        return rca

    def listar(self):
        cursor = self.__db.connection.cursor()
        cursor.execute(SQL_BUSCA_RCAS)
        rca = traduz_rca(cursor.fetchall())
        return rca

    def busca_por_id(self, id):
        cursor = self.__db.connection.cursor()
        cursor.execute(SQL_RCA_POR_ID, (id,))
        tupla = cursor.fetchone()
        return RCA(tupla[1], id=tupla[0])

    def deletar(self, id):
        self.__db.connection.cursor().execute(SQL_DELETA_RCA, (id, ))
        self.__db.connection.commit()

class ItemAvalicaoRcaDao():
    def __init__(self, db):
        self.__db = db

    def salvar(self, item):
        cursor = self.__db.connection.cursor()

        busca_id = cursor.execute('SELECT iditem FROM itensavaliacaorca where iditem = %s', (item.id,))

        if busca_id:
            cursor.execute(SQL_ATUALIZA_ITEM_AVAL_RCA, (item.descricao, item.peso))
        else:
            cursor.execute(SQL_CRIA_ITEM_AVAL_RCA, (item.descricao, item.peso))

        self.__db.connection.commit()

    def listar(self):
        cursor = self.__db.connection.cursor()
        cursor.execute(SQL_BUSCA_ITEM_AVAL_RCA)
        itens = traduz_item_aval_rca(cursor.fetchall())
        return itens

    def busca_por_id(self, id):
        cursor = self.__db.connection.cursor()
        cursor.execute(SQL_ITEM_AVAL_RCA_POR_ID, (id,))
        tupla = cursor.fetchone()
        return ItensAvaliacaoRca(tupla[1], tupla[2], id=tupla[0])

    def deletar(self, id):
        self.__db.connection.cursor().execute(SQL_DELETA_ITEM_AVAL_RCA, (id, ))
        self.__db.connection.commit()



def traduz_rca(rca):
    def cria_rca_com_tupla(tupla):
        return RCA(tupla[1], id=tupla[0])
    return list(map(cria_rca_com_tupla, rca))

def traduz_rca_por_id(tupla_rca):
    return RCA(tupla_rca[1], id=tupla_rca[0])

def traduz_item_aval_rca(item):
    def cria_item_com_tupla(tupla):
        return ItensAvaliacaoRca(tupla[1], tupla[2], id=tupla[0])
    return list(map(cria_item_com_tupla, item))

def traduz_item_aval_rca_por_id(tupla_item):
    return ItensAvaliacaoRca(tupla_item[1], tupla_item[2], id=tupla_item[0])
