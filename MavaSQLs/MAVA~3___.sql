select a_atualizanumviasmapa(182,(SELECT max(numviasmapasep) FROM pcpedc WHERE numcar = 182))
from dual


--select numviasmapasep from pcpedc where numcar = 182

--update pcpedc set numviasmapasep = 10 where numcar = 182