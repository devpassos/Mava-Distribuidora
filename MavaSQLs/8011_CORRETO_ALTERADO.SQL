SELECT
pedidos.numregiao COD_REGIAO,
regiao.regiao as REGIAO,
falta.numped AS PEDIDO, 
falta.codprod AS CODIGO_PRODUTO, 
produto.descricao, 
falta.codcli AS CODIGO_CLIENTE,
cliente.cliente,
falta.qt as QT_FALTA,
falta.pvenda AS PRECO_NO_PEDIDO,
ESTOQUE.QTEST AS QT_ESTOQUE_ATUAL


FROM 
PCFALTA falta,
pcprodut produto,
pcest estoque,
pcclient cliente,
pcpedc pedidos, 
pcregiao regiao

where falta.numped in ( select capapedido.numped from pcpedc capapedido where capapedido.posicao = 'L')
and
falta.codprod = estoque.codprod
and
produto.codprod = falta.codprod
and
cliente.codcli = falta.codcli
and 
pedidos.numped = falta.numped
and
regiao.numregiao = pedidos.numregiao
and
estoque.qtest > 0

order by falta.numped

;