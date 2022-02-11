

WHEN JNT.EXECUCAO = 0 THEN 'OFC'
          WHEN JNT.EXECUCAO = 1 THEN 'MNT'
          WHEN JNT.EXECUCAO = 2 THEN 'PMN'
          WHEN JNT.EXECUCAO = 3 THEN 'EDF'
          END AS TIPO

//----------------------------------------------

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
        WHERE execucao = 0