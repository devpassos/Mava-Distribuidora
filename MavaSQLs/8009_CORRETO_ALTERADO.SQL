SELECT
produto.tipoestoque as tp_estoque,
produto.codepto as cod_depart,
depart.descricao as descricao_depart,
item.codprod as cod_produto,
produto.codfab as cod_fabrica,
produto.descricao as descricao_produto,

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                --- CALCULO DAS QUANTIDADES TOTAIS -----
LPAD(TO_CHAR((select qtdtot from (SELECT SUM(PP.QT) as qtdtot, pp.codprod, pp.numlote
                       FROM PCPEDI PP, PCLOTE LT
                       WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote  and pp.numped in(:numped)) 
                       AND    pp.codprod = item.codprod
                       AND    pp.numlote = item.numlote
                       AND    pp.numcar = item.numcar
                       GROUP BY pp.codprod, pp.numlote)),'99990D99'),10,' ')||' - '||RPAD((SELECT prod.unidade from pcprodut prod where prod.codprod = item.codprod),4,' ') as total_itens_carregamento,

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                    --- CALCULO DAS CAIXAS -----
CASE produto.tipoestoque
    WHEN 'FR' 
        THEN          
            LPAD(FLOOR(
                    (TO_NUMBER(
                            ((SELECT qtdtot
                                FROM (SELECT SUM(PP.QT) as qtdtot, pp.codprod, pp.numlote
                                      FROM PCPEDI PP, PCLOTE LT
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote  and pp.numped in(:numped)) 
                                      AND    pp.codprod = item.codprod
                                      AND    pp.numlote = item.numlote
                                      AND    pp.numcar = item.numcar
                                      GROUP BY pp.codprod, pp.numlote)) / 
                              (SELECT prod.qtunitcx from pcprodut prod where prod.codprod = item.codprod))))),3,' ')||' - '||RPAD((SELECT prod.unidademaster from pcprodut prod where prod.codprod = item.codprod),4,' ')
        ELSE
            LPAD(TRUNC(
                    (TO_NUMBER(
                            ((SELECT qtdtot
                                FROM (SELECT SUM(PP.QT) as qtdtot, pp.codprod, pp.numlote
                                      FROM PCPEDI PP, PCLOTE LT
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote and pp.numped in(:numped)) 
                                      AND    pp.codprod = item.codprod
                                      AND    pp.numlote = item.numlote
                                      AND    pp.numcar = item.numcar
                                      GROUP BY pp.codprod, pp.numlote)) / 
                              (SELECT prod.qtunitcx from pcprodut prod where prod.codprod = item.codprod))))),3,' ')||' - '||RPAD((SELECT prod.unidademaster from pcprodut prod where prod.codprod = item.codprod),4,' ')
END  AS qt_caixas,

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                --- CALCULO DAS UNIDADES -----
CASE 
    WHEN (((SELECT prod.unidade from pcprodut prod where prod.codprod = item.codprod) IN ('UN', 'KG', 'CX')) AND (produto.tipoestoque <> 'FR'))
        THEN 
            LPAD(TO_CHAR(
                 trunc(
                    nvl(
                        (mod((SELECT qtdtot
                                FROM (SELECT SUM(PP.QT) as qtdtot, pp.codprod, pp.numlote
                                      FROM PCPEDI PP, PCLOTE LT
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote  and pp.numped in(:numped)) 
                                      AND    pp.codprod = item.codprod
                                      AND    pp.numlote = item.numlote
                                      AND    pp.numcar = item.numcar
                                      GROUP BY pp.codprod, pp.numlote)), (SELECT prod.qtunitcx from pcprodut prod where prod.codprod = item.codprod)) / 
                           (SELECT tmpemb.qtunit FROM pcembalagem tmpemb WHERE tmpemb.unidade = 'UN' AND tmpemb.codprod = item.codprod)),0),4),'990D99'),9,' ')||' - UN'
                           
   WHEN ((SELECT prod.unidade from pcprodut prod where prod.codprod = item.codprod) = 'KG' AND (produto.tipoestoque = 'FR'))
        THEN 
            LPAD(
                TO_CHAR(
                        nvl(
                            (mod((SELECT qtdtot
                                  FROM (SELECT SUM(PP.QT) as qtdtot, pp.codprod, pp.numlote
                                        FROM PCPEDI PP, PCLOTE LT
                                        WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote  and pp.numped in(:numped)) 
                                        AND    pp.codprod = item.codprod
                                        AND    pp.numlote = item.numlote
                                        AND    pp.numcar = item.numcar
                                        GROUP BY pp.codprod, pp.numlote)), (SELECT prod.qtunitcx from pcprodut prod where prod.codprod = item.codprod))),0),'990D99'),9,' ')||' - KG'  -- '99G9990D99999','nls_numeric_characters='',.'''
END  as qt_unidades,
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------

CASE    
    WHEN  item.numlote IS NULL
        THEN 'LOTE NÃO ATRIBUIDO'
    ELSE
        item.numlote
END as numero_lote_pedido,

CASE    
    WHEN  item.numlote IS NULL
        THEN 'LOTE NÃO ATRIBUIDO'
    ELSE
        TO_CHAR((select lttmp.dtvalidade from pclote lttmp where item.numlote = lttmp.numlote and item.codprod = lttmp.codprod),'DD/MM/YYYY')
END  as validade_lote,
item.numcar as numero_carregamento,
carregamento.codmotorista as cod_motorista,
empregados.nome as nome_motorista,
carregamento.codveiculo as cod_veiculo,
veiculos.descricao as descricao_veiculo,
carregamento.destino as destino
--(SELECT LISTAGG(:numped, ',') WITHIN group (order by :numped)) as pedidos_filtrados

FROM 
pcpedi item, 
pcprodut produto,
pcdepto depart,
pclote lote,
pccarreg carregamento,
pcveicul veiculos,
pcempr empregados

WHERE 1 = 1
--- CONDIÇÕES DE LIGAÇÃO ---
AND
produto.codprod = item.codprod
AND
depart.codepto = produto.codepto
AND
(item.numlote = lote.numlote AND item.codprod = lote.codprod)
AND
carregamento.numcar = item.numcar
AND
veiculos.codveiculo = carregamento.codveiculo
AND
empregados.matricula = carregamento.codmotorista


-- RESTRIÇÕES DA CONSULTA --
--AND
--item.numcar = :numcar
AND
item.numped in (:numped)
                 
GROUP BY
produto.tipoestoque,
produto.codepto,
depart.descricao,
item.codprod,
produto.codfab,
produto.descricao,
item.numlote,
lote.dtvalidade,
item.numcar,
carregamento.codmotorista,
empregados.nome,
carregamento.codveiculo,
veiculos.descricao,
carregamento.destino

ORDER BY 
produto.tipoestoque,
produto.codepto,
produto.descricao;