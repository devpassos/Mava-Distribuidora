SELECT * FROM PCCLIENT WHERE CODCLI = 10041;

select * from pclote where codprod = 1130;

select * from pcest where codprod = 1130;

select * from pcprodut where codprod = 15102;

update pclote set datafabricacao = TO_DATE('06/10/20', 'DD/MM/YY') WHERE CODPROD = 71241 AND NUMLOTE = 'ABC3';

update pclote set qtreserv = 0 WHERE CODPROD = 1130 AND NUMLOTE = '2012021';


select * from pcusuari;

SELECT * FROM PCMOV WHERE NUMCAR = :NUMCAR;

SELECT * FROM pcnfsaid;

select numcar, numnota, numped,cliente

from pcnfsaid

where 1 = 1
and dtcancel is null 
and condvenda <> 4
and numped is not null
and numcar <> 0
and UPPER(cliente) like '%'||UPPER(:cliente)||'%'
order by numcar, cliente;

select numcar from pcnfsaid where numcar = :numcar;