
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

// -----------------------------------

SELECT
MDL.NOME_MODULO AS MODULO,
DMT.COD_DM

     FROM DMTDESENHOMONTAGEM DMT 
     LEFT JOIN MDLMODULO MDL ON MDL.BOLD_ID = DMT.PMDLMODULO
