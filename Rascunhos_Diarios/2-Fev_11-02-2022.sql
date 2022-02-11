
SELECT
datacadastro,
cod_junta,
CASE
when execucao = 0 then 'OFC'
when execucao = 1 then 'MNT'
when execucao = 2 then 'PMN'
when execucao = 3 then 'EDF'
END as Tipo,  
status_junta
    FROM jntjunta
        WHERE execucao <> 0 and datacadastro='11.02.2022'
               ORDER BY datacadastro desc,cod_junta
