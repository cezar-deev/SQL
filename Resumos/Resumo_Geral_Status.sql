/* Resumo de juntas por Status */


select status_junta, count(cod_junta)
    from vw_juntainspecionada
    where cod_junta  not like '#%'
    group by status_junta
    order by 1


------------------------------------------------------------------------------

------------------------------------------------------------------------------


select Sub_bloco,painel as Modulo, count(cod_junta) as QTD
    from vw_juntainspecionada
    where cod_junta  not like '#%' and status_junta not like 'Finaliz%'
    group by sub_bloco,painel
    order by 1,2,3
