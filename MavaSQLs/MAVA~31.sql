select * from pclote where codprod = 401;
update pclote set datafabricacao = to_date('01/06/2020') where numlote = 'hjhk';

select item.numped, item.data, item.codcli,
       item.codprod, item.qt, item.numlote, lote.dtvalidade, item.codauxiliar
from pcpedi item, pclote lote
where
(lote.numlote = item.numlote and lote.codprod = item.codprod)
and
numped = 1000593;

select * from pcembalagem where codprod = 6300;


select pedi.codprod, pedi.codauxiliar, embalagem.embalagem, embalagem.unidade
from pcpedi pedi, pcembalagem embalagem
where
embalagem.codauxiliar = pedi.codauxiliar
and
pedi.numped = 1000593;

select * from pcclient where codcli = 6658;

