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
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote) 
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
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote) 
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
                                      WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote) 
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
                                        WHERE (pp.codprod = lt.codprod and pp.numlote = lt.numlote) 
                                        AND    pp.codprod = item.codprod
                                        AND    pp.numlote = item.numlote
                                        AND    pp.numcar = item.numcar
                                        GROUP BY pp.codprod, pp.numlote)), (SELECT prod.qtunitcx from pcprodut prod where prod.codprod = item.codprod))),0),'990D99'),9,' ')||' - KG'  -- '99G9990D99999','nls_numeric_characters='',.'''
END  as qt_unidades,
 
------------------------------------------------------------------------------------------------------------------------------------------------------------------


