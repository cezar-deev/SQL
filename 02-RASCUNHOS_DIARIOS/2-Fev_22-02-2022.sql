select cod_junta,soldadores,RS_DATA,RS

from VW_JUNTAINSPECIONADA

where soldadores like '%EJA-0031' AND RS_DATA >='2022-01-15'