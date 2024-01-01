--select * from pcpedc where numcar = 180
SELECT * FROM
pcpedi pedi
  JOIN (SELECT
          p.codprod AS cdproduto,
          P.CODFAB,
          p.descricao AS descproduto,
          P.QTUNITCX AS QTEMBMASTER,
          P.CODFAB AS CODIGO_FABRICA,
          P.TIPOESTOQUE AS TP_ESTOQUE,
          P.CODEPTO AS CD_DEPART,
          DPTO.DESCRICAO AS DEPARTAMENTO

          FROM pcprodut p  JOIN PCDEPTO DPTO ON DPTO.CODEPTO = P.CODEPTO ) prod on prod.cdproduto = pedi.codprod

  JOIN (SELECT
          codauxiliar AS cdembalagem,
          embalagem AS embalagem_pedido,
          qtunit AS qtembalagem

          FROM pcembalagem ) emb ON emb.cdembalagem = pedi.codauxiliar

  JOIN (SELECT
          lt.dtvalidade AS validade,
          lt.numlote
        
          FROM pclote lt WHERE lt.qt != 0) lote ON lote.numlote = pedi.numlote
          
WHERE pedi.codprod = 70599