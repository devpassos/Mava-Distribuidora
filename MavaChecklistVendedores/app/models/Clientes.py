
class Clientes():
    def __init__(self, cod_rca, dia_semana, sequencia, periodicidade,
                 dtproxvisita, codigo_cliente, razao_social, nome_fantasia,
                 endereco_comercial, bairro, cidade, tel_comercial, tel_cobranca,
                 atividade
                 ):
        self.__codrca = cod_rca
        self.__dia_semana = dia_semana
        self.__sequencia = sequencia
        self.__periodicidade = periodicidade
        self.__dtproxvisita = dtproxvisita
        self.__codigo_cliente = codigo_cliente
        self.__razao_social = razao_social
        self.__nome_fantasia = nome_fantasia
        self.__endereco_comercial = endereco_comercial
        self.__bairro = bairro
        self.__cidade = cidade
        self.__tel_comercial = tel_comercial
        self.__tel_cobranca = tel_cobranca
        self.__atividade = atividade


    @property
    def cod_rca(self):
        return self.__codrca
    @property
    def dia_semana(self):
        return self.__dia_semana