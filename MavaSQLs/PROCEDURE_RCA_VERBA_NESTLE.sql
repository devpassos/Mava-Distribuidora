CREATE or REPLACE PROCEDURE TESTE_CURSOR_RCA
    
    AS
     USUARIO VARCHAR2; 
     ROTINA INTEGER; 
     NOVOSALDO NUMBER; 
     NOVOLIMITE FLOAT; 
     SALDOANTERIOR FLOAT; 
     LIMITEANTERIOR FLOAT;
     HISTORICO VARCHAR2;
     VLTOTALPEDIDOS FLOAT;
     VLTOTALVERBA FLOAT;
   
    CURSOR CUR_RCAVERBA
    IS
    SELECT 
             DATA,
             codusur AS USUARIO,
            (SELECT NULL FROM DUAL) AS ROTINA,
            (teste.pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR) + (SUM(QT * PVENDA)* 0.03)) NOVOSALDO,
            teste.pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR) NOVOLIMTE,
            teste.pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR) SALDOANTERIOR,
            teste.pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR) LIMTEANTERIOR,
            (SELECT 'VERBA INDENIZAÇÃO NESLTLÉ' FROM DUAL) AS HISTORICO,
            sum(QT * pvenda)  AS VLTOTALPEDIDOS,
            (SUM(QT * PVENDA)* 0.03) AS VLTOTALVERBA
            
            FROM TESTE.pcpedi
            WHERE 
            codprod in (select codprod from teste.pcprodut where codepto = 3)
            AND
            numped in (select numped from teste.pcpedc where codcob <> 'BNF')
            AND
            DATA = TO_CHAR(SYSDATE -2, 'DD/MM/YY')
            
            GROUP BY
            DATA,
           CODUSUR,
           teste.pc_pkg_controlarsaldorca.ccrca_checar_disponivel_atual(CODUSUR),
           teste.pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(CODUSUR),
           teste.pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR);


BEGIN
    OPEN CUR_RCAVERBA;
    LOOP
        FETCH CUR_RCABERBA
        INTO usuario, rotina, novosaldo, novolimite, saldoanterior, limiteanterior, historico, vltotalpedidos, VLTOvltotalverba ;
        EXIT WHEN
            CUR_RCAVERBA%NOTFOUND;
        DBMS_OUTPUT.PUT
                (usuario);
    END LOOP;
    CLOSE CUR_RCAVERBA;
END;