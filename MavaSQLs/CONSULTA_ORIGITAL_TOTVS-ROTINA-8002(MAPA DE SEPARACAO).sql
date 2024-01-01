 SELECT
 
 P.CODPROD, 
 
 P.DESCRICAO, 
 
 I.NUMLOTE, 
 
 SUM( I.QT), 
 
 car.numcar, 
 
 car.codmotorista, 
 
 car.codveiculo, 
 
 car.destino, 
 
 p.codfab,

--(SELECT dtvalidade FROM pclote WHERE numlote = i.numlote) validade, 

trunc((sum(i.qt) / p.qtunitcx)) || ' CX' qtdcx, 

sum(i.qt) - (trunc((sum(i.qt) / p.qtunitcx)) * p.qtunitcx) || ' ' || p.unidade   UNIDADES,

p.tipoestoque, p.codepto , (SELECT descricao FROM pcdepto WHERE codepto = p.codepto) dep

FROM PCPRODUT P, PCEMBALAGEM E, PCPEDC C, PCPEDI I, pccarreg car

WHERE 1=1
AND P.CODPROD = E.CODPROD
AND I.CODPROD = P.CODPROD
AND E.CODFILIAL =1
AND C.NUMPED = I.NUMPED
AND C.NUMCAR = :numcar
AND c.numcar = car.numcar
--AND E.QTUNIT > 1
--AND I.CODPROD = 5550
--AND P.TIPOESTOQUE <> 'FR'
--and c.dtfat is null
and car.numcar <> 0
and i.codauxiliar = e.codauxiliar


 
GROUP BY  P.CODPROD, P.DESCRICAO, I.NUMLOTE, car.numcar, car.codmotorista, car.codveiculo, car.destino, p.codfab, p.qtunitcx, p.unidade, p.tipoestoque,p.codepto
ORDER BY p.codepto, p.tipoestoque,  P.CODPROD
