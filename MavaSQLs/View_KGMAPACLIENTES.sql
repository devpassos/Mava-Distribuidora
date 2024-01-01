CREATE OR REPLACE FORCE EDITIONABLE VIEW MAVA.V_KGMAPACLIENTES
AS
    SELECT
        i.codprod,
        i.codcli AS CODIGO,
        c.cliente as CLIENTE, 
        LPAD(TRUNC(SUM(i.qt ),2), 6)||' - KG' as TOTAL_KG,
        CASE
            WHEN i.numcar is null
            THEN 0
            WHEN i.numcar is not null
            THEN i.numcar
        END as CARREGAMENTO,
       l.dtvalidade AS VALIDADE
    
    FROM
        pcpedi i,       -- TABELA DE ITENS DO PEDIDO
        pcprodut p,     -- TABELA DE PRODUTOS
        pcclient c,      -- TABELA DE CLIENTES
        pclote l
        
    WHERE
        1 = 1     -- CONDIÇÃO PADRÃO
        AND
        p.codprod = i.codprod
        AND
        c.codcli = i.codcli
        AND
        (l.numlote = i.numlote and l.codprod = i.codprod)
        AND
        p.tipoestoque = 'FR'
    
        -- CONDIÇÕES USADAS SOMENTE PARA VALIDAÇÃO 
        /*
        --and
        --i.numcar = :numcar
        --and
        --p.codprod = :codprod
        */
    
    GROUP BY i.numcar, i.codcli, c.cliente, i.codprod, l.dtvalidade;