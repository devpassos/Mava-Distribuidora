SELECT
PCUSUARI.CODUSUR,
PCUSUARI.NOME RCA,
PCUSUARI.VLLIMCRED, PCSUPERV.CODSUPERVISOR, PCSUPERV.NOME SUPERVISOR,
pc_pkg_controlarsaldorca.ccrca_checar_disponivel_atual(PCUSUARI.CODUSUR ) SALDO,
pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(PCUSUARI.CODUSUR) SALDOATUAL,
0 CHECKOUT
FROM PCUSUARI, PCSUPERV
WHERE PCUSUARI.CODSUPERVISOR = PCSUPERV.CODSUPERVISOR AND PCUSUARI.CODUSUR <> '9999'
AND NVL(PCSUPERV.POSICAO,'A') = 'A'
AND PCUSUARI.DTTERMINO IS NULL
ORDER BY PCUSUARI.CODSUPERVISOR, PCUSUARI.CODUSUR;


SELECT 
PCUSUARI.CODUSUR, 
PCUSUARI.NOME RCA, 
PCUSUARI.VLLIMCRED, 
pc_pkg_controlarsaldorca.ccrca_checar_disponivel_atual(PCUSUARI.CODUSUR) SALDO,
pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(PCUSUARI.CODUSUR) SALDOATUAL,
0 VALORLANCAR
FROM PCUSUARI
WHERE CODUSUR = 7;


SELECT
    nvl(pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(:CODIGO),0) VLCORRENTE,
    nvl(pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(:CODIGO),0) VLLIMCRED
    FROM DUAL;



INSERT INTO PCLOGRCA(
PCLOGRCA.DATA,
PCLOGRCA.CODUSUR,
PCLOGRCA.ROTINA,
PCLOGRCA.VLCORRENTE,
PCLOGRCA.VLLIMCRED,
PCLOGRCA.VLCORRENTEANT,
PCLOGRCA.VLLIMCREDANT,
PCLOGRCA.HISTORICO,
PCLOGRCA.HISTORICO2,
PCLOGRCA.VLDIFERENCA
)
VALUES
(
(SELECT SYSDATE FROM DUAL),
:CODFUNC,
:CODIGO,
356,
:VLCORRENTE,
:VLLIMCRED,
:VLCORRENTEANT,
:VLLIMCREDANT,
:HISTORICO,
:HISTORICO2,
:VLDIFERENCA
);