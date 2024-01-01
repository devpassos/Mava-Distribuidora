SELECT
produto.codlinhaprod as cod_linha_produto,
linha.descricao as Linha_prod,
produto.tipoestoque as tp_estoque,
produto.codepto as cod_depart,
depart.descricao as descricao_depart,
item.codprod as cod_produto,
produto.codfab as cod_fabrica,
produto.descricao as descricao_produto,

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                --- CALCULO DAS QUANTIDADES TOTAIS -----
SUM(ITEM.QT) as total_itens_carregamento,

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    --- CALCULO DAS CAIXAS -----

       

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                --- CALCULO DAS UNIDADES -----

 
------------------------------------------------------------------------------------------------------------------------------------------------------------------

item.numlote as numero_lote_pedido,
lote.dtvalidade as validade_lote,
item.numcar as numero_carregamento,
carregamento.codmotorista as cod_motorista,
carregamento.codfuncajud as cod_ajudante,
ajudantes.nome as ajudante,
empregados.nome as nome_motorista,
carregamento.codveiculo as cod_veiculo,
veiculos.descricao as descricao_veiculo,
carregamento.destino as destino,
(SELECT sum( i.qt * p.pesobruto) FROM pcpedc c , pcpedi i , pcprodut p WHERE c.numped = i.numped AND i.codprod = p.codprod AND c.numcar in (&numcar)) as PESO_BRUTO,
(select count(numped) from pcpedc where numcar in (&numcar)) as numero_de_pedidos

FROM 
pcpedi item, 
pcprodut produto,
pcdepto depart,
pclote lote,
pccarreg carregamento,
pcveicul veiculos,
pcempr empregados,
pcempr ajudantes,
pclinhaprod linha

WHERE 1 = 1
--- CONDIÇÕES DE LIGAÇÃO ---
AND
produto.codprod = item.codprod
AND
depart.codepto = produto.codepto
AND
(item.numlote = lote.numlote AND item.codprod = lote.codprod)
AND
carregamento.numcar = item.numcar
AND
veiculos.codveiculo = carregamento.codveiculo
AND
empregados.matricula = carregamento.codmotorista
AND
ajudantes.matricula = carregamento.codfuncajud
AND
linha.codlinha = produto.codlinhaprod


-- RESTRIÇÕES DA CONSULTA --
AND
item.numcar in (&numcar)
                 
GROUP BY
produto.codlinhaprod,
linha.descricao,
produto.tipoestoque,
produto.codepto,
depart.descricao,
item.codprod,
produto.codfab,
produto.descricao,
item.numlote,
lote.dtvalidade,
item.numcar,
carregamento.codmotorista,
carregamento.codfuncajud,
ajudantes.nome,
empregados.nome,
carregamento.codveiculo,
veiculos.descricao,
carregamento.destino

ORDER BY 
produto.codlinhaprod;