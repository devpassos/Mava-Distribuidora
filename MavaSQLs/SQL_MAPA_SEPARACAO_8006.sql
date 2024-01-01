SELECT
produto.tipoestoque as tp_estoque,
produto.codepto as cod_depart,
depart.descricao as descricao_depart,
item.codprod as cod_produto,
produto.codfab as cod_fabrica,
produto.descricao as descricao_produto,

        ---- CONVERSÕES PARA CAIXA E UNIDADES ----

LPAD(sum(item.qt),6,' ')||' - '||produto.unidade  as total_itens_carregamento,
LPAD(trunc(sum(item.qt) / produto.qtunitcx),6,' ')||' - '||produto.unidademaster as qt_caixas,

CASE 
    WHEN produto.unidade = 'UN'
        THEN LPAD(mod(sum(item.qt), produto.qtunitcx),6,' ')||' - '||produto.unidade  
    WHEN produto.unidade = 'KG'
    THEN 
        LPAD(trunc(nvl((mod(sum(item.qt), produto.qtunitcx) / 
            (SELECT tmpemb.qtunit
                FROM pcembalagem tmpemb 
                WHERE tmpemb.unidade = 'UN' AND tmpemb.codprod = produto.codprod)),0)),6,' ')||' - UN'
END  as qt_unidades,
        -------------------------------------------

item.numlote as numero_lote_pedido,
lote.dtvalidade as validade_lote,
item.numcar as numero_carregamento,
carregamento.codmotorista as cod_motorista,
empregados.nome as nome_motorista,
carregamento.codveiculo as cod_veiculo,
veiculos.descricao as descricao_veiculo,
carregamento.destino as destino

FROM 
pcpedi item, 
pcprodut produto,
pcdepto depart,
pclote lote,
pccarreg carregamento,
pcveicul veiculos,
pcempr empregados,
pcembalagem embalagem


WHERE 1 = 1
--- CONDIÇÕES DE LIGAÇÃO ---
AND
produto.codprod = item.codprod
AND
depart.codepto = produto.codepto
AND
(item.numlote = lote.numlote AND item.codprod = lote.codprod)
AND
embalagem.codauxiliar = item.codauxiliar
AND
carregamento.numcar = item.numcar
AND
veiculos.codveiculo = carregamento.codveiculo
AND
empregados.matricula = carregamento.codmotorista


-- RESTRIÇÕES DA CONSULTA --
AND
produto.tipoestoque <> 'FR'
AND
item.numcar = :numcar
                 
GROUP BY
produto.tipoestoque,
produto.codepto,
depart.descricao,
produto.codprod,
item.codprod,
produto.codfab,
produto.descricao,
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
carregamento.destino

ORDER BY 
produto.tipoestoque,
produto.codepto,
produto.descricao;