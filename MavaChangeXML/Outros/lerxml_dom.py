# coding:utf-8

# importa o minidom para abrir arquivos
from xml.dom.minidom import parse, Document

alt = Document()

rastro = alt.createElement('rastro')
nLote = alt.createElement('nLote')
dFab = alt.createElement('dFab')
dVal = alt.createElement('dVal')

nLoteTxt = alt.createTextNode('11')
dFabTxt = alt.createTextNode('2020-01-01')
dValTxt = alt.createTextNode('2020-12-31')

dVal.appendChild(dValTxt)
dFab.appendChild(dFabTxt)
nLote.appendChild(nLoteTxt)

rastro.appendChild(nLote)
rastro.appendChild(dFab)
rastro.appendChild(dVal)

# abre o arquivo e passa como objeto para a variável doc
with open('firstXML.xml', 'r+') as docxml:

    doc = parse(docxml)


    # passa os elementos do arquivos para a variável xml
    xml = doc.documentElement



    # Verifica se o xml tem em sua tag raiz o atributo nome
    if xml.hasAttribute('nome'):
        # Printa na tela o conteúdo do atributo se ele existir
        print(f'País: {xml.getAttribute("nome")}')

        # Cria um array com os sub-elementos do elemento raiz pela tagname
        estados = doc.getElementsByTagName('Estado')

        # percorre a lista de objetos criada com os subelementos do elemento raiz
        for estado in estados:
            print(f"Estado: {estado.getAttribute('nome')}")
            
            # Cria uma lista com sub-elementos de estado (cidades)
            cidades  = estado.getElementsByTagName('cidade')
            
            # percorre a lista de cidades criada a partir o get tag name
            for cidade in cidades:
                
                print(f'Cidade: {cidade.getAttribute("nome")}')
                
                # Cria uma outra lista como sublista de cidades, agora com os habitantes
                # pega o nome tag e printa seu conteúdo
                habi = cidade.getElementsByTagName('Habitantes')
                
                # se essa lista for maior que 0 ele printa ta tela o conteúdo da tag habitantes
                if len(habi) > 0:
                    for h in habi:
                        print(f"Nr Habitantes de {cidade.getAttribute('nome')}: {h.childNodes[0].data}")
                        cidade.appendChild(rastro)
                

    print(doc.toxml(encoding='UTF-8'))
    doc.writexml(open('1' + str(docxml.name), 'w'))