
select dtvalidade 
from pclote 
where codprod = 24210;


select numped from pcpedc where numcar = 59;

SELECT PP.CODPROD, SUM(PP.QT),PP.NUMLOTE, LT.DTVALIDADE
FROM PCPEDI PP, PCLOTE LT
WHERE (PP.CODPROD = LT.CODPROD AND PP.NUMLOTE = LT.NUMLOTE)
AND PP.NUMCAR = 49 

GROUP BY PP.codprod, PP.NUMLOTE, LT.DTVALIDADE

ORDER BY PP.CODPROD;

select codprod, descricao, unidademaster from pcprodut where codprod = 30305;




((select prod.unidademaster from pcprodut prod where prod.codprod = item.codprod) = 'CX'));

select codepto, temrepos from pcprodut where codepto = 3;

update pcprodut set temrepos = 10 where codepto = 3;