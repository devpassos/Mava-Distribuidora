SELECT

PROD.TP_ESTOQUE AS TIPO_ESTOQUE,

PROD.CD_DEPART AS COD_DEPARTAMENTO,

PROD.DEPARTAMENTO AS DESCRICAO_DEPARTAMENTO,

pedi.codprod as CODIGO_PRODUTO,

PROD.CODFAB,

prod.descproduto as DESCRICAO_PRODUTO,

Sum(PEDI.QT) AS TOTAL_ITENS_CARREGAMENTO,

PROD.QTEMBMASTER AS QT_ITENS_EMB_MASTER,

TRUNC((SUM(PEDI.QT) / PROD.QTEMBMASTER)) AS QT_TOTAL_CAIXAS,

trunc((mod((Sum(PEDI.QT)), PROD.QTEMBMASTER)) / (emb.qtembalagem)) AS QT_ITENS_AVULSO,

pedi.numlote,

lote.validade,

tblpedcli.numcar as CARREGAMENTO_TBL_PEDCLI,

CARGA.CODMOTORISTA AS MOTORISTA,

CARGA.NOME_MOTORISTA,

CARGA.CODVEICULO AS CODIGO_VEICULO,

CARGA.DESC_VEICULO AS VEICULO,

CARGA.DESTINO AS DESTINO

---- CAMPOS USADOS PARA TESTE E REMOVIDOS DA CONSULTA FINAL -----

--pedi.numped AS NUMERO_PEDIDO,

-- pedi.data AS DATA_PEDIDO,

--emb.embalagem_PEDIDO AS EMBALAGEM_DO_PEDIDO,

--emb.qtembalagem AS QT_ITENS_EMB_VENDA,

--pedi.qt AS  QT_ITENS_NO_PEDIDO,

--Sum((PEDI.QT * EMB.QTEMBALAGEM)) AS QT_TOTAL_DO_ITEM_NO_PEDIDO,

--pedi.numcar AS NUMERO_CARREGAMENTO,

--tblpedcli.numped as NUMERO_PEDIDO_CLIENTE,

FROM

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

          FROM pclote lt) lote ON lote.numlote = pedi.numlote,

pcpedc tblpedcli
  JOIN (SELECT
          CAR.CODMOTORISTA,
          CAR.NUMCAR,
          CAR.CODVEICULO,
          CAR.DESTINO,
          EMPR.NOME AS NOME_MOTORISTA,
          VCL.DESCRICAO AS DESC_VEICULO

          FROM PCCARREG CAR
              JOIN pcempr empr ON EMPR.MATRICULA = CAR.CODMOTORISTA
              JOIN pcveicul VCL ON VCL.CODVEICULO = CAR.CODVEICULO  ) CARGA ON CARGA.NUMCAR = TBLPEDCLI.NUMCAR


WHERE tblpedcli.numcar = 138

AND tblpedcli.numcar = pedi.numcar

AND tblpedcli.numped = pedi.numped

AND prod.tp_estoque <> 'FR'




GROUP BY

PROD.TP_ESTOQUE,

PROD.CD_DEPART ,

prod.descproduto ,

PROD.CODFAB,

PROD.DEPARTAMENTO,

pedi.codprod ,

PROD.QTEMBMASTER ,

emb.qtembalagem,

pedi.numcar ,

pedi.numlote,

lote.validade,

tblpedcli.numcar,

CARGA.CODMOTORISTA,

CARGA.NOME_MOTORISTA,

CARGA.CODVEICULO,

CARGA.DESC_VEICULO,

CARGA.DESTINO

---- CAMPOS USADOS PARA TESTE E REMOVIDOS DA CONSULTA FINAL -----

--pedi.numped,

-- pedi.data ,

-- emb.embalagem_PEDIDO ,

-- pedi.qt ,

-- (PEDI.QT * EMB.QTEMBALAGEM) ,

-- TRUNC(((PEDI.QT * EMB.QTEMBALAGEM) / PROD.QTEMBMASTER)) ,

-- mod((PEDI.QT * EMB.QTEMBALAGEM),PROD.QTEMBMASTER) ,

-- tblpedcli.numped ,

ORDER BY PROD.TP_ESTOQUE, PROD.CD_DEPART, PROD.DESCPRODUTO

