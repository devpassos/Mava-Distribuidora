/*
Atualiza a tabela de pre�os por regi�o (no caso a 7)
com base em uma tabela tempor�ria criada a partir de uma planilha
com os pre�os informados
*/

update pctabpr t1 set 

t1.ptabela6 = (select tblpr.pre�o
                from (select p.codprod, p.codfab, prv.pre�o 
                      from pcprodut p 
                      join teste_preco_nestle_reg_7 prv on prv.codfab = p.codfab 
                      join pctabpr pr on pr.codprod = p.codprod and pr.numregiao = 7 )tblpr 
                      where tblpr.codprod = t1.codprod)

WHERE t1.numregiao = 7 and t1.codprod in (select prod.codprod 
                                            from teste_preco_nestle_reg_7 pv
                                            join pcprodut prod on prod.codfab = pv.codfab)
             
             

