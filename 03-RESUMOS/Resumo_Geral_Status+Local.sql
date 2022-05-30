/* Resumo de juntas por Local */


select tipo,status_junta, count(cod_junta)
from vw_juntainspecionada
where cod_junta  not like '#%' and status_junta not like 'Finaliz%'
group by tipo,status_junta
order by 1,3
