import os
from xml.etree import ElementTree as ET  
from xml.parsers.expat import ExpatError


def nomeiaTag(obj_tag):
    '''
    Recebe Obejto de uma lista de objetos de tag da NFE e retorna o nome da tag
    de acordo com a string relacionada nas regras abaixo
    '''

    if 'cProd' in obj_tag.tag[-8:]:
        return 'Codigo do Fornecedor: '
    elif 'cEAN' in obj_tag.tag[-4:]:
        return 'Codigo EAN: '
    elif 'xProd' in obj_tag.tag[-8:]:
        return 'Descricao do Produto: '
    elif 'NCM' in obj_tag.tag[:-8]:
        return 'Codigo NCM: '
    elif 'qCom' in obj_tag.tag[-4:]:
        return 'Quantidade de Compra: '
    
    else:
        return 0

def imprimeProdutosXML(listaObj):
    '''
    Percorre a lista de objetos do tipo detalhe pegando o primeiro elemento do array
    {http://www.portalfiscal.inf.br/nfe}det que é {http://www.portalfiscal.inf.br/nfe}prod
    listando todas as tags de dentro dele e seu texto.
    '''
    for det in listaObj:
        print("="*12 + f' Item: {det.attrib["nItem"]} ' + '='*12)
        prod = det[0] # Passa a lista de objetos da tag prod para a variável prod
        for dtl_produto in prod:
            if nomeiaTag(dtl_produto):
                print(nomeiaTag(dtl_produto), dtl_produto.text)
        print("="*34 + "\n")


def incluirLoteXML(xml_name):
    ''' Recebe como argumento o nome (diretório) de um arquivo
        XML e inclui as tags de reatreio (Rastro / nLote, qtLote, etc.)
        serve para incluir lotes para importação no sistema Wintor TOTVs
        quando o XML não contempla os lotes de produtos
    '''

    # Registra o namespace padrão para se trabalhar no xml
    ET.register_namespace('','http://www.portalfiscal.inf.br/nfe')

    # Abre o XML da NFE
    xml = ET.parse(xml_name)

    # Cria o Root (tag nfeProc)
    root = xml.getroot()


    nome_Fornec = root[0][0][1].find('{http://www.portalfiscal.inf.br/nfe}xFant').text
    nr_nfe = root[0][0][0].find('{http://www.portalfiscal.inf.br/nfe}nNF').text
    nmarq = str(nome_Fornec+'-'+nr_nfe+'.xml')


    # Cria variáveis que serão os nomes das tags a serem inclusas no XML
    tag_rastro = "rastro"
    tag_nLote = "nLote"
    tag_qLote = "qLote"
    tag_dFab = "dFab"
    tag_dVal = "dVal"

    
    # Define o conteúdo que será passado para essas tags
    nrLote = nome_Fornec[:3] + nr_nfe
    dtValidLote = "2050-12-31"
    dtFabLote = "2000-01-01"

    for x in root[0][0]:
        if x.tag == '{http://www.portalfiscal.inf.br/nfe}det':
            ET.SubElement(x[0], tag_rastro)
            ET.SubElement(x[0].find(tag_rastro), tag_nLote)
            ET.SubElement(x[0].find(tag_rastro), tag_qLote)
            ET.SubElement(x[0].find(tag_rastro), tag_dFab)
            ET.SubElement(x[0].find(tag_rastro), tag_dVal)
            x[0].find(tag_rastro).find(tag_nLote).text = nrLote
            qtCompra = x[0].find('{http://www.portalfiscal.inf.br/nfe}qCom').text
            x[0].find(tag_rastro).find(tag_qLote).text = qtCompra
            x[0].find(tag_rastro).find(tag_dFab).text = dtFabLote
            x[0].find(tag_rastro).find(tag_dVal).text = dtValidLote

   


    xml.write(nmarq, encoding= "UTF-8")


incluirLoteXML('Nfe_33201002914460031625550010003725591795396829_2079905345.xml')



