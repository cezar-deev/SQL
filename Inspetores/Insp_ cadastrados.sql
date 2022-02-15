/* Todos os Inspetores cadastrados */

select bold_id,bold_type,empresa,cod_inspetor,nome,dtentrada,dtsaida
FROM inpinspetor
where 
order by cod_inspetor