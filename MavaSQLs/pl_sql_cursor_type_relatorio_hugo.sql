set SERVEROUTPUT on;
DECLARE

type mava_t_param is table of varchar(20);

v_depto mava_t_param := mava_t_depto(&depto);

p_count mava_t_param := v_depto.first;

cursor deptos is
    select codepto, descricao from pcdepto;
    
type mava_t_depto is table of pcdepto.descricao%type;

ref_depto mava_t_depto := mava_t_depto();

ref_count integer :=0;

begin    
       
    while p_count is not null
        loop
            dbms_output.put_line(v_depto(p_count));
            for i in deptos
                LOOP 
                    if i.codepto = v_depto(p_count)
                        then
                        ref_count := ref_count +1;
                        ref_depto.extend;
                        ref_depto(ref_count) := i.descricao;
                        dbms_output.put_line(ref_depto(ref_count));
                    end if;
                END LOOP;
            p_count := v_depto.next;
        end loop;
end;