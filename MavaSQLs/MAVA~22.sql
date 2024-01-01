
SELECT REPLACE((:numped),',',' - ') FROM DUAL;

(select REPLACE(TO_CHAR(column_value),',',' - ') from table(sys.odcinumberlist(:numped)));

select LISTAGG(:numped, ',') WITHIN group (order by :numped)AS lista_disciplinas from dual;






