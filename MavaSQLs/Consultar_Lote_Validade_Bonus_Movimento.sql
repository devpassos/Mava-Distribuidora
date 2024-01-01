select mov.numtransent as MOV_TRANSENT, mov.codprod AS MOV_CODPROD, mov.numnota AS MOV_NUMNOTA, mov.qt AS MOV_QT, mov.datafabricacao AS MOV_DTFAB, mov.datavalidade AS MOV_DTVALID, mov.numbonus AS MOV_BONUS,
       bonus.numbonus AS B_BONUS, bonus.codprod AS B_CODPROD, bonus.numlote AS B_NUMLOTE, bonus.numlotefab AS B_LOTEFAB ,bonus.qtentrada AS B_QTENT, bonus.datafabricacao AS B_DTFAB, bonus.dtvalidade AS B_VALID,
       lote.numtransent AS LT_TRANSENT, lote.codprod AS LT_CODPROD, lote.qt AS LT_QT , lote.numlote as LT_NUMLOTE, lote.numlotefab AS LT_NUMLOTEFAB, lote.datafabricacao AS LT_DTFAB ,lote.dtvalidade AS LT_VALID
       
from pcmov mov, pcbonusi bonus, pclote lote
where 
(bonus.codprod = mov.codprod and bonus.numbonus = mov.numbonus)
and
(lote.numtransent = mov.numtransent and lote.codprod = mov.codprod)
and mov.numbonus is not null
and mov.numbonus not in (select numbonus from pcbonusc where dtcancel is not null)
and lote.qt > 0
and lote.dtvalidade <> bonus.dtvalidade
and mov.qt = bonus.qtentrada;

UPDATE PCLOTE LOTE SET LOTE.DTVALIDADE = (select B_VALID from arruma_lote_mava WHERE mov_codprod = LOTE.CODPROD AND mov_transent = lote.numtransent)
WHERE 
LOTE.numtransent = (select mov_transent from arruma_lote_mava where mov_codprod = LOTE.CODPROD AND mov_transent = lote.numtransent)
and
lote.codprod = (select mov_codprod from arruma_lote_mava where mov_codprod = LOTE.CODPROD AND mov_transent = lote.numtransent);