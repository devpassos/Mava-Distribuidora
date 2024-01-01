SELECT 
    i.codprod as codigo_produto,
    p.descricao, 
    count(i.codprod) as total_pedidos,
    i.pvenda as preco_venda,
    sum(i.qt) as total_itens

FROM 
    pcpedi i,
    pcprodut p 

WHERE
    (p.codprod = i.codprod
    AND
    i.codprod in (SELECT codprod FROM pcprodut WHERE codepto in ((:departamento))))
--AND 
--    i.pvenda BETWEEN 7.00 and 8.00

GROUP BY
    i.pvenda,
    i.codprod,
    p.descricao;