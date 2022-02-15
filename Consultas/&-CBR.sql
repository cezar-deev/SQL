/* Consulta de Baixas de Resold */ 

SELECT
s.junta,
s.sinete,
v.rs_data,
s.consumivel,
s.ieis,
s.relatorio,
s.inspetor,
s.processo_Soldagem

FROM vw_solda s left join vw_juntainspecionada v on s.junta=v.cod_junta

WHERE s.junta like 'SS-M02/FP2-11%'

ORDER BY s.junta
