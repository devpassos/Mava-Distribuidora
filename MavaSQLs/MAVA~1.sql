select 

p.codprod, p.descricao,

t.ptabela AS PRECO_REG_1,
reg2.preco_reg_2,
reg3.preco_reg_3,
reg4.preco_reg_4,
reg5.preco_reg_5,
reg6.preco_reg_6,
reg7.preco_reg_7,
reg8.preco_reg_8,

t.custoprecific AS CUSTO_REG_1, 
reg2.custo_reg_2,
reg3.custo_reg_3,
reg4.custo_reg_4,
reg5.custo_reg_5,
reg6.custo_reg_6,
reg7.custo_reg_7,
reg8.custo_reg_8,

trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG1, 
reg2.cmv_reg_2,
reg3.cmv_reg_3,
reg4.cmv_reg_4,
reg5.cmv_reg_5,
reg6.cmv_reg_6,
reg7.cmv_reg_7,
reg8.cmv_reg_8,

(trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG1,
reg2.margem_liq_reg_2,
reg3.margem_liq_reg_3,
reg4.margem_liq_reg_4,
reg5.margem_liq_reg_5,
reg6.margem_liq_reg_6,
reg7.margem_liq_reg_7,
reg8.margem_liq_reg_8

from pcprodut p join  pctabpr t on t.codprod = p.codprod

join
(select p.codprod AS PROD_REG_2,
        t.ptabela AS PRECO_REG_2, t.custoprecific AS CUSTO_REG_2, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_2, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_2
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 2) REG2
        ON (reg2.prod_reg_2 = P.CODPROD)

JOIN
(select p.codprod AS PROD_REG_3,
        t.ptabela AS PRECO_REG_3, t.custoprecific AS CUSTO_REG_3, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_3, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_3
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG3
        ON (reg3.prod_reg_3 = P.CODPROD)

JOIN
(select p.codprod AS PROD_REG_4,
        t.ptabela AS PRECO_REG_4, t.custoprecific AS CUSTO_REG_4, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_4, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_4
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG4
        ON (reg4.prod_reg_4 = P.CODPROD)
        
JOIN
(select p.codprod AS PROD_REG_5,
        t.ptabela AS PRECO_REG_5, t.custoprecific AS CUSTO_REG_5, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_5, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_5
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG5
        ON (reg5.prod_reg_5 = P.CODPROD)        

JOIN
(select p.codprod AS PROD_REG_6,
        t.ptabela AS PRECO_REG_6, t.custoprecific AS CUSTO_REG_6, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_6, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_6
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG6
        ON (reg6.prod_reg_6 = P.CODPROD)

JOIN
(select p.codprod AS PROD_REG_7,
        t.ptabela AS PRECO_REG_7, t.custoprecific AS CUSTO_REG_7, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_7, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_7
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG7
        ON (reg7.prod_reg_7 = P.CODPROD)

JOIN
(select p.codprod AS PROD_REG_8,
        t.ptabela AS PRECO_REG_8, t.custoprecific AS CUSTO_REG_8, 
        trunc(((t.ptabela*0.03) + t.custoprecific),2) as CMV_REG_8, 
        (trunc(((t.ptabela - ((t.ptabela*0.03) + t.custoprecific)) /t.ptabela),4)*100) as MARGEM_LIQ_REG_8
        from pcprodut p join  pctabpr t on t.codprod = p.codprod WHERE t.numregiao = 3) REG8
        ON (reg8.prod_reg_8 = P.CODPROD)

where P.CODEPTO = 3 AND t.numregiao = 1 

ORDER BY P.CODPROD
 
 
