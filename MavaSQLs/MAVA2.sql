SELECT
CASE
    WHEN prod.TP_ESTOQUE = 'FR'
        THEN
            pedi.codcli
    WHEN PROD.TP_ESTOQUE <> 'FR'
        THEN 0
END as cod_cliente,

cliente.cliente as cliente,

PROD.TP_ESTOQUE AS TIPO_ESTOQUE,

PROD.CD_DEPART AS COD_DEPARTAMENTO,

PROD.DEPARTAMENTO AS DESCRICAO_DEPARTAMENTO,

pedi.codprod as CODIGO_PRODUTO,

PROD.CODFAB,

prod.descproduto as DESCRICAO_PRODUTO,

LPAD(Sum(PEDI.QT),4,' ')||' - '||LPAD(prod.unidade,3,' ') AS TOTAL_ITENS_CARREGAMENTO,




PROD.QTEMBMASTER AS QT_ITENS_EMB_MASTER,


CASE prod.tp_estoque
WHEN 'FR' 
THEN LPAD(ROUND((SUM(PEDI.QT) / PROD.QTEMBMASTER)),3,' ')||' - '||RPAD(prod.unidademaster,4,' ')
ELSE LPAD(TRUNC((SUM(PEDI.QT) / PROD.QTEMBMASTER)),3,' ')||' - '||RPAD(prod.unidademaster,4,' ')
END  AS QT_TOTAL_CAIXAS,


CASE PROD.TP_ESTOQUE
WHEN 'FR'
THEN LPAD(TRUNC(mod((Sum(PEDI.QT)), PROD.QTEMBMASTER)/ emb.qtembalagem),3,' ')||' - '||RPAD(prod.embalagem,12,' ')
ELSE LPAD(trunc(mod((Sum(PEDI.QT)), PROD.QTEMBMASTER)/ emb.qtembalagem),3,' ')||' - '||RPAD(prod.embalagem,12,' ')
END  AS QT_ITENS_AVULSO,

pedi.numlote,

lote.validade,

tblpedcli.numcar as CARREGAMENTO_TBL_PEDCLI,

CARGA.CODMOTORISTA AS MOTORISTA,

CARGA.NOME_MOTORISTA,

CARGA.CODVEICULO AS CODIGO_VEICULO,

CARGA.DESC_VEICULO AS VEICULO,

CARGA.DESTINO AS DESTINO


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
          DPTO.DESCRICAO AS DEPARTAMENTO,
          p.unidade, p.embalagem, p.unidademaster

          FROM pcprodut p  JOIN PCDEPTO DPTO ON DPTO.CODEPTO = P.CODEPTO ) prod on prod.cdproduto = pedi.codprod

  JOIN (SELECT
          codauxiliar AS cdembalagem,
          embalagem AS embalagem_pedido,
          qtunit AS qtembalagem

          FROM pcembalagem ) emb ON emb.cdembalagem = pedi.codauxiliar

  JOIN (SELECT
          lt.dtvalidade AS validade,
          lt.numlote,
          lt.codprod
        
          FROM pclote lt) lote ON lote.numlote = pedi.numlote and lote.codprod = pedi.codprod,

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
              JOIN pcveicul VCL ON VCL.CODVEICULO = CAR.CODVEICULO  ) CARGA ON CARGA.NUMCAR = TBLPEDCLI.NUMCAR,
              

pcclient cliente


WHERE  tblpedcli.numcar = :numcar

AND cliente.codcli = tblpedcli.codcli

AND tblpedcli.numcar = pedi.numcar

AND tblpedcli.numped = pedi.numped

GROUP BY
pedi.codcli,

cliente.cliente,

PROD.TP_ESTOQUE,

PROD.CD_DEPART ,

prod.descproduto ,

PROD.CODFAB,

PROD.DEPARTAMENTO,

pedi.codprod ,

PROD.QTEMBMASTER ,

emb.qtembalagem,

emb.embalagem_PEDIDO,

prod.unidade,

prod.unidademaster,

prod.embalagem,

pedi.numcar ,

pedi.numlote,

lote.validade,

tblpedcli.numcar,

CARGA.CODMOTORISTA,

CARGA.NOME_MOTORISTA,

CARGA.CODVEICULO,

CARGA.DESC_VEICULO,

CARGA.DESTINO

ORDER BY PROD.TP_ESTOQUE, PROD.CD_DEPART, PROD.DESCPRODUTO
