SELECT 
c.numped,  
P.CODPROD, 
P.DESCRICAO, 
I.NUMLOTE, 
I.QT, 
car.numcar, 
car.codmotorista, 
car.codveiculo, 
car.destino, 
p.codfab,

LT.DTVALIDADE AS validade, 
ROUND(i.qt / e.qtunit) qtdcx, 
i.qt - (trunc(i.qt / p.qtunitcx) * e.qtunit) unidades, 
cli.codcli, 
cli.cliente, 
e.embalagem,
e.qtunit

FROM PCPRODUT P, PCEMBALAGEM E, PCPEDC C, PCPEDI I, pccarreg car, pcclient cli, pclote lt

WHERE 1=1
AND P.CODPROD = E.CODPROD
AND I.CODPROD = P.CODPROD
AND c.codcli = cli.codcli
AND E.CODFILIAL =1
AND C.NUMPED = I.NUMPED
AND C.NUMCAR = :numcar
AND c.numcar = car.numcar
AND LT.NUMLOTE = I.NUMLOTE AND LT.CODPROD = P.CODPROD
AND E.QTUNIT > 1
AND i.codauxiliar = e.codauxiliar
AND P.TIPOESTOQUE = 'FR'

order by  p.codprod
