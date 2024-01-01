/*
Atualiza a tabela de preços por região (no caso a 7)
com base em uma tabela temporária criada a partir de uma planilha
com os preços informados
*/

update pctabpr t1 set 

t1.ptabela6 = (select tblpr.preço
                from (select p.codprod, p.codfab, prv.preço 
                      from pcprodut p 
                      join teste_preco_nestle_reg_7 prv on prv.codfab = p.codfab 
                      join pctabpr pr on pr.codprod = p.codprod and pr.numregiao = 7 )tblpr 
                      where tblpr.codprod = t1.codprod)

WHERE t1.numregiao = 7 and t1.codprod in (select prod.codprod 
                                            from teste_preco_nestle_reg_7 pv
                                            join pcprodut prod on prod.codfab = pv.codfab)
             
             

