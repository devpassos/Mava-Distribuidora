select * from pclote where codprod = 71;

update pclote set datafabricacao = to_date('01/01/20', 'DD/MM/YY') where codprod = 71; --and numlote = 'ABC3';

select pedido.numped AS Pedido, cliente.cliente as Cliente, pedido.numcar as Carregamento,
(:numcar) as CARREG_FILTRADO
from pcpedc pedido, pcclient cliente

where
cliente.codcli = pedido.codcli
and
pedido.posicao = 'M';


select pedido.numped, cliente.cliente 
from pcpedc pedido, pcclient cliente

where
cliente.codcli = pedido.codcli
and
pedido.posicao = 'M'
and
pedido.numcar = TO_NUMBER(:numcar);


select produto.codprod, produto.descricao, produto.embalagem, embl.embalagem ,embl.qtunit
from pcprodut produto, pcembalagem embl

where embl.codprod = produto.codprod
AND PRODUTO.CODPROD = 57815;

SELECT * from pcmov WHERE NUMNOTA = 249975;

select *from pcembalagem where codprod = 57815;

--- ATUALIZAÇÃO DE PREÇOS DAS REGIÕES COM BASE EM PLANIÇHA PASSADA PELO HUGO ----

select * from tmp_prc_reg_6;

create table TESTE_PRC_REG_6 AS
SELECT TMP.*,PRODUTO.CODPROD, PRODUTO.CODFAB ,PRODUTO.DESCRICAO FROM tmp_prc_reg_6 TMP, PCPRODUT PRODUTO
WHERE PRODUTO.CODFAB = tmp.coluna1;

select * from teste_prc_reg_6;


UPDATE pctabpr
    SET
        pvenda = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda1 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda2 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda3 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda4 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda5 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda6 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        pvenda7 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela1 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela2 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela3 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela4 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela5 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela6 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod),
        ptabela7 = (select tmp.coluna2 from teste_prc_reg_6 tmp where tmp.codprod = pctabpr.codprod)

    where pctabpr.codprod in (select tmp.codprod from teste_prc_reg_6 tmp)
    and pctabpr.numregiao = 6;

select codprod, pvenda, pvenda1, pvenda2 from pctabpr where codprod in (select tmp.codprod from teste_prc_reg_6 tmp) and numregiao = 6 order by codprod;