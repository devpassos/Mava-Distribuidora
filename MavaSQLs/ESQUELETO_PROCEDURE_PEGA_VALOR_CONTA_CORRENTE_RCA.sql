
SELECT
    v_vlverba.mov_cod_rca,
    v_vlverba.mov_vl_verba_aplicar,
    (SELECT NULL FROM DUAL) AS ROTINA,
    pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(v_vlverba.mov_cod_rca) SALDOANTERIOR,
    (pc_pkg_controlarsaldorca.ccrca_checar_saldo_atual(v_vlverba.mov_cod_rca) + (v_vlverba.mov_vl_verba_aplicar)) NOVOSALDO,
    (SELECT 'VERBA INDENIZAÇÃO NESLTLÉ' FROM DUAL) AS HISTORICO,
    v_vlverba.mov_vl_total_item_rca

FROM 
    mava_v_consult_vend_dpto_3_rca_fat V_VLVERBA;