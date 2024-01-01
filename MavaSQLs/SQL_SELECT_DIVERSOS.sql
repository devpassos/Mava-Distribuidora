---- COMANDOS DE SELEÇÃO DE ITENS X PEDIDOS ----


-- SELECIONAR DADOS DA TABELA DE CARREGAMENTO (AJUDANTES)
select codfuncajud, codfuncajud2, codfuncajud3 from pccarreg;


-- TOTAL (QUANTIDADE) DE ITENS DO PEDIDO (TABELA PCPEDI)
select sum(item.qt), item.codprod --item.numlote

from pcpedi item

where item.numcar = 71

group by item.codprod -- item.numlote

order by item.codprod;


-- SELECIONAR TOTAL(QUANTIDADE) DO ITEM E SUA QUANTIDADE NA CAIXA ALÉM DO LOTE
SELECT
item.codprod, 
mod(SUM(item.QT),(SELECT prod.qtunitcx from pcprodut prod where prod.codprod = 6300)),
item.numlote 

from 
pcpedi item

where numcar = 71 and codprod = 6300 

group by item.codprod, item.numlote;