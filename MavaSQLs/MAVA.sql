--SELECT * FROM pclogrca WHERE CODPROD IS NULL AND codusur = 2
UPDATE PCLOGRCA SET vlcorrente = vlcorrente * 1.10 WHERE codusur = 2 AND CODFUNC = 54