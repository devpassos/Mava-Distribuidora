
class RCA():
    def __init__(self, nome, id=None):
        self.__id = id
        self.__nome = nome

    @property
    def nome(self):
        return self.__nome
    @nome.setter
    def nome(self, nome):
        self.__nome = nome

    @property
    def id(self):
        return self.__id

    @id.setter
    def id(self, id):
        self.__id = id

    def __str__(self):
        return f'RCA: {self.id}  None: {self.nome}'

if __name__ == '__main__':

    rca = RCA(1, 'Peixe')
    print(rca)