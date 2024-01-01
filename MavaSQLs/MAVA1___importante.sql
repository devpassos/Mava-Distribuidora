SELECT 

DATA,

codusur AS USUARIO,

(SELECT NULL FROM DUAL) AS ROTINA,

(pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR) + (SUM(QT * PVENDA)* 0.03)) NOVOSALDO,

pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR) NOVOLIMTE,

pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR) SALDOANTERIOR,

pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR) LIMTEANTERIOR,

(SELECT 'VERBA INDENIZAÇÃO NESLTLÉ' FROM DUAL) AS HISTORICO,

sum(QT * pvenda)  AS VLTOTALPEDIDOS,

(SUM(QT * PVENDA)* 0.03) AS VLTOTALVERBA


FROM pcpedi

WHERE 
codprod in (select codprod from pcprodut where codepto = 3)
AND
numped in (select numped from pcpedc where codcob <> 'BNF')
AND
DATA = TO_CHAR(SYSDATE -2, 'DD/MM/YY')

GROUP BY
DATA,
CODUSUR,
pc_pkg_controlarsaldorca.ccrca_checar_disponivel_atual(CODUSUR),
pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR),
pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR)

ORDER BY
USUARIO