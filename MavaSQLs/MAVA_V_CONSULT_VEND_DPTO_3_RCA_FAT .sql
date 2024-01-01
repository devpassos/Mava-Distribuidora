CREATE OR REPLACE VIEW MAVA_V_CONSULT_VEND_DPTO_3_RCA_FAT
    AS
        SELECT
            --mov.dtmov AS DATA,
            COUNT(MOV.CODPROD) AS MOV_QT_NFS,
            MOV.CODUSUR AS MOV_COD_RCA,
            SUM(MOV.QT) AS MOV_QT_TOTAL_ITEM,
            --MOV.CODPROD AS MOV_CODPROD,
            TRUNC((SUM(MOV.QT * MOV.PUNIT)),2) AS MOV_VL_TOTAL_ITEM_RCA,
            TRUNC((SUM(MOV.QT * MOV.PUNIT)*0.03),2) AS MOV_VL_VERBA_APLICAR
            
        FROM
            PCMOV MOV
        
        WHERE 1 = 1
            AND
            MOV.NUMTRANSVENDA IN 
                     (
                        SELECT 
                            NFE.NUMTRANSVENDA 
                         FROM 
                            PCNFSAID NFE 
                         WHERE 
                            NFE.CODCOB <> 'BNF' 
                            AND nfe.dtcancel IS NULL 
                            AND TO_DATE(NFE.DTFAT,'DD/MM/YY') BETWEEN (TO_DATE(SYSDATE, 'DD/MM/YY') -24) AND (TO_DATE(SYSDATE, 'DD/MM/YY')-1)  
                     )
      
            AND
            MOV.CODEPTO IN (3)
            AND
            MOV.CODUSUR NOT IN (13,14,15)
            AND
            MOV.NUMREGIAO NOT IN (4, 5, 7, 8)
        
        
        GROUP BY
            MOV.CODUSUR
            --MOV.DTMOV
        
        
        ORDER BY
            MOV.CODUSUR
            --MOV.DTMOV
;