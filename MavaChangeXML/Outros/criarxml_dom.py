# coding:utf-8

from xml.dom.minidom import Document


# Cria documento do tipo xml
doc = Document()


# Criando elementos a serem adicionados ao documento
root = doc.createElement('Pais')
sp = doc.createElement('Estado')
rj = doc.createElement('Estado')
angra = doc.createElement('cidade')
paraty = doc.createElement('cidade')


# adicionando elementos ao documento
doc.appendChild(root)
root.appendChild(sp)
root.appendChild(rj)
rj.appendChild(angra)
rj.appendChild(paraty)


# Colocando atributos (nomes) nas tags(elementos) criados
root.setAttribute('nome', 'Brasil')
angra.setAttribute('nome','Angra dos Reis')
paraty.setAttribute('nome', "Paraty")
rj.setAttribute('nome', 'Rio de Janeiro')
sp.setAttribute('nome', "Sao Paulo")


# Criaond mais um elemento mesmo depois de ter criado
# e adicionado elementos anteriormente
hab = doc.createElement('Habitantes')


# adicionando elemento criado como sub-elemento de um outro
# criado anteriormente
angra.appendChild(hab)


# Criando um texto como centeúdo para um elemento
txt = doc.createTextNode('320.000')

# Adicioanando este texto como sub-elemento (conteúdo) da tag hab
hab.appendChild(txt)

# Criando o arquivo no mesmo diretório de execução do sistema
doc.writexml(open('firstXML.xml', 'w'), encoding="UTF-8") # possui mais parâmetros que podem ser usados como
                                                          # ident, addident e newl


# Liberando o arquivo criado para não ficar 'preso' no editor
doc.unlink()
