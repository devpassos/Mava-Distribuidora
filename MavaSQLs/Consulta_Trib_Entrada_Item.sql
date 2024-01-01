select p.codprod, p.descricao, p.codfab, codncmex, tbe.*, tbf.* from pcprodut p
left join pctribentrada tbe on tbe.ncm = p.codncmex
left join pctribfigura tbf on tbf.codfigura = tbe.codfigura

where p.codncmex in ('02101900.') and tbe.tipofornec != 'D'
--where tbe.uforigem is null
--where tbe.tipofornec != 'D'
order by p.descricao