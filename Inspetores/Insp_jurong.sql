/* INSPETORES CADASTRADOS DO JUTONG */

select bold_id,bold_type,empresa,cod_inspetor,nome,dtentrada,dtsaida
FROM inpinspetor
where empresa like 'JURONG%'
order by cod_inspetor