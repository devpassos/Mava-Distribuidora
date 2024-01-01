CREATE OR REPLACE VIEW MAVA_V_CONSULTA_VL_DEV_RCA
AS
        
        SELECT 
            datacanc AS DATA_CANCELAMENTO,
            CODUSUR, 
            SUM(PVENDA * QT) AS QT_CANCELADO,
            SUM(PVENDA * QT) * 0.03 AS VL_DEBITO_RCA
            
            
        FROM 
            pcnfcanitem 
        
        WHERE 1 = 1
            AND
            CODPROD IN (SELECT 
                            CODPROD 
                        FROM 
                            PCPRODUT 
                        WHERE 
                            CODEPTO IN (3))
            AND
                CODUSUR NOT IN (13,14,15)
        
        GROUP BY
            CODUSUR,
            DATACANC
            
        ORDER BY
            CODUSUR;
