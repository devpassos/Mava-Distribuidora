SELECT 'Perc FECP: ' || c.peracrescimofuncep || '%  Valor FECP: '|| 
to_char(c.vlacrescimofuncep * v.qt, 'FM999G999G999D90') FECP
FROM pcmov v, pcmovcomple c
WHERE 1=1
AND v.numtransitem = c.numtransitem
and v.numtransvenda = 1062
AND v.numseq = 17;

select * from pcembalagem;

select produto.codprod, prod.descricao ,produto.percaliqvigint, trib.codst, trib.ufdestino
from pcprodfilial produto,pcprodut prod ,pctabtrib trib
where prod.codprod = produto.codprod
and trib.codprod = produto.codprod
and trib.codst in (1,2,3,9) and (produto.percaliqvigint = 0 or produto.percaliqvigint is null);