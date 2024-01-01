SELECT
item.codcli as cod_cliente,
clientes.cliente as nome_cliente,
item.numped as numero_pedido,
produto.tipoestoque as tp_estoque,
produto.codepto as cod_depart,
depart.descricao as descricao_depart,
item.codprod as cod_produto,
produto.codfab as cod_fabrica,
produto.descricao as descricao_produto,
embalagem.embalagem as embalagem_produto,

        ---- CONVERSÕES PARA CAIXA E UNIDADES ----
LPAD(sum(item.qt),6,' ')||' - '||produto.unidade  as total_itens_carregamento,

CASE
    WHEN produto.unidademaster = 'CX'
        THEN LPAD(trunc((sum(item.qt) / produto.qtunitcx)),6,' ')||' - '||produto.unidademaster
    WHEN produto.unidademaster = 'KG'
        THEN LPAD('0', 6, ' ')||' - CX'

END as qt_caixas,

CASE
    WHEN embalagem.unidade = 'PC'
        THEN
        (trunc(mod(sum(item.qt), produto.qtunitcx),2) / embalagem.qtunit)||' - '||embalagem.embalagem
    WHEN embalagem.unidade = 'CX'
    THEN 
        (trunc(mod(sum(item.qt), produto.qtunitcx),2) / embalagem.qtunit)||' - '||produto.unidade
END as qt_unidade,
        -------------------------------------------

item.numlote as numero_lote_pedido,
lote.dtvalidade as validade_lote,
item.numcar as numero_carregamento,
carregamento.codmotorista as cod_motorista,
empregados.nome as nome_motorista,
carregamento.codveiculo as cod_veiculo,
veiculos.descricao as descricao_veiculo

FROM 
pcpedi item, 
pcprodut produto,
pcdepto depart,
pclote lote,
pccarreg carregamento,
pcveicul veiculos,
pcempr empregados,
pcembalagem embalagem,
pcclient clientes


WHERE 1 = 1
--- CONDIÇÕES DE LIGAÇÃO ---
AND
produto.codprod = item.codprod
AND
depart.codepto = produto.codepto
AND
(lote.numlote = item.numlote and lote.codprod = item.codprod)
AND
embalagem.codauxiliar = item.codauxiliar
AND
carregamento.numcar = item.numcar
AND
veiculos.codveiculo = carregamento.codveiculo
AND
empregados.matricula = carregamento.codmotorista
AND
clientes.codcli = item.codcli

-- RESTRIÇÕES DA CONSULTA --
AND
produto.tipoestoque ='FR'
AND
item.numcar = :numcar
                 
GROUP BY
item.codcli,
clientes.cliente,
item.numped,
produto.tipoestoque,
produto.codepto,
depart.descricao,
produto.codprod,
item.codprod,
produto.codfab,
produto.descricao,
embalagem.embalagem,
produto.unidade,
produto.unidademaster,
produto.qtunitcx,
item.numlote,
lote.dtvalidade,
item.numcar,
carregamento.codmotorista,
empregados.nome,
carregamento.codveiculo,
veiculos.descricao,
embalagem.unidade,
embalagem.qtunit


ORDER BY 
produto.tipoestoque,
produto.codepto,
produto.descricao
