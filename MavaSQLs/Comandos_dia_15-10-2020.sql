select * from pcprodut order by descricao;
select * from pcembalagem where codprod = 50024;

select codprod, embalagem, qtunit, (qtunit * 12) from pcembalagem where codprod = 50024;

select * from pcnfsaid where numnota = 250196;
update pcnfsaid set dtSAIDA = to_date('14/10/20','DD/MM/YY') where numnota = 250196;

select * from pcest where codprod = 27056;

INSERT into pclote(codfilial,codprod, qt, dtvalidade, datafabricacao, numlote)
values (1, 27056, 3, to_date('23/05/20','DD/MM/YY'), to_date('01/12/19','DD/MM/YY'), 'ABC27056');

update pcest set qtest = 3, qtestger = 3, custoreal = 4.99, custorealliq = 4.99, custofin = 4.99 where codprod = 27056;

select * from pclote where codprod = 20890;

select * from pctabpr where codprod = 27056;

select * from pclote where dtvalidade = TO_DATE('31/12/20', 'DD/MM/YY');


UPDATE pctabpr
    SET
        pvenda = 4.99,
        pvenda1 = 4.99,
        pvenda2 = 4.99,
        pvenda3 = 4.99,
        pvenda4 = 4.99,
        pvenda5 = 4.99,
        pvenda6 = 4.99,
        pvenda7 = 4.99,
        ptabela = 4.99,
        ptabela1 = 4.99,
        ptabela2 = 4.99,
        ptabela3 = 4.99,
        ptabela4 = 4.99,
        ptabela5 = 4.99,
        ptabela6 = 4.99,
        ptabela7 = 4.99

    where codprod = 27056;
    
    
UPDATE PCLOTE SET dtvalidade = TO_DATE('30/01/21', 'DD/MM/YY') WHERE CODPROD = 5185 and numlote = 'ABC2';
UPDATE PCLOTE SET dtvalidade = TO_DATE('21/01/21', 'DD/MM/YY') WHERE CODPROD = 20890 and numlote = 'ABC1';

SELECT NUMPED, posicao FROM PCPEDC;

