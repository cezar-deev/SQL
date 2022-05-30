/* Resumo de juntas por Local, Sem First Dimensional */

select tipo, count(cod_junta)
from vw_juntainspecionada
where cod_junta  not like '#%' and status_junta not like 'Finaliz%' and status_junta not like '%First Dimen%'
group by tipo
order by 1,2