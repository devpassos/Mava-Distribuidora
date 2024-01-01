set SERVEROUTPUT ON

declare
cursor produto_cursor
is
select codprod, descricao from pcprodut;

begin

for reg_produto in produto_cursor
    loop
        IF  REG_PRODUTO.DESCRICAO LIKE '%CHAMBINHO%'
        THEN dbms_output.put_line(reg_produto.codprod || ' - ' || reg_produto.descricao);
        END IF;
    end loop;
end;

