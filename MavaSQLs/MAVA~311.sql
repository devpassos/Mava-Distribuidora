--select * from PCPRODUT where codprod NOT IN (SELECT CODPROD FROM pclote) 

--SELECT * FROM PCLOTE where NUMLOTE = 'ABC3'

/*
UPDATE PCLOTE SET
QT = 0
--DATAFABRICACAO = TO_DATE('01/08/20','DD/MM/YY'),
--DTVALIDADE = TO_DATE('31/10/20', 'DD/MM/YY')

WHERE CODPROD = 70599 AND NUMLOTE = 'ABC3'
*/

--select codprod, fora from pcprodut where codprod = 354 

--update pcprodut set codprod = 146 where codprod = 203

select * from pcprodut where codprod = 70599 