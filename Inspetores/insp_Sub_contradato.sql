/*Inspetores Subcontratados*/

select bold_id,bold_type,empresa,cod_inspetor,nome,dtentrada,dtsaida
FROM inpinspetor
where empresa<> 'JURONG'
order by cod_inspetor