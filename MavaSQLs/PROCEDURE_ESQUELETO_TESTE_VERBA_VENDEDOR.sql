BEGIN
    FOR RCAVERBA IN (SELECT 
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
                    teste.pc_pkg_controlarsaldorca.ccrca_checar_limite_credito(CODUSUR)

                    ORDER BY
                    USUARIO) -- aqui vc usa o select que quiser
        LOOP 
        INSERT INTO TESTE.PCLOGRCA(
                            TESTE.PCLOGRCA.DATA,
                            TESTE.PCLOGRCA.CODUSUR,
                            TESTE.PCLOGRCA.ROTINA,
                            TESTE.PCLOGRCA.VLCORRENTE,
                            TESTE.PCLOGRCA.VLCORRENTEANT,
                            TESTE.PCLOGRCA.HISTORICO
                            ) 
        VALUES (
        (SELECT SYSDATE FROM DUAL),
        RCAVERBA.USUARIO, 
        RCAVERBA.ROTINA, 
        RCAVERBA.NOVOSALDO, 
        RCABERBA.SALDOANTERIOR,
        RCABERBA.HISTORICO
        );
        
        END LOOP; 
END;