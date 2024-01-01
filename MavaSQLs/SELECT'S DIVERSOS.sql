--- SELECT'S DIVERSOS ---


select
cliente 

from 
pcpedi item, 
pcclient cliente 

where cliente.codcli IN (SELECT item.codcli from pcpedi item where item.numcar = 4)
and item.numcar = 4 
and item.codprod = 15006;

select 
cliente 

from 
pcpedi item, 
pcclient cliente, 
pcprodut prod 

where item.codprod = prod.codprod 
and prod.tipoestoque ='PA' 
and cliente.codcli IN (SELECT item.codcli from pcpedi item where item.numcar = :numcar) 
and item.numcar = :numcar and item.codprod = :codprod;


select 
codcli, 
cliente, 
prazomaxvalidade 

from pcclient 

where prazomaxvalidade > 1;


update pcclient set prazomaxvalidade = (prazomaxvalidade +1) where prazomaxvalidade > 1;


update pcclient set prazomaxvalidade = 14  where codcli = 5264;