
1) /* RESUMO DE JUNTAS SMP - MANUAL */


SELECT B.SMP, B. TOTAL AS TOTAL_JUNTAS,B.PEND AS PENDENTE,B.LIB AS LIBERADA,
CASE WHEN B.TOTAL=B.LIB THEN 'LIBERADO' ELSE 'PENDENTE' END AS STATUS

FROM 
(SELECT
A.SMP SMP,
SUM(A.TOTAL) TOTAL,
SUM(A.PEND) PEND,
SUM(A.LIB) LIB
FROM (

SELECT 
    CASE WHEN JNT.COD_JUNTA LIKE '%SMP-063%' THEN 'SMP-063'
            WHEN JNT.COD_JUNTA LIKE '%SMP63%' THEN 'SMP-063'  
            WHEN JNT.COD_JUNTA LIKE '%SMP105%' THEN 'SMP-105'
            WHEN JNT.COD_JUNTA LIKE '%SMP138%' THEN 'SMP-138'
            WHEN JNT.COD_JUNTA LIKE '%SMP179%' THEN 'SMP-179'
            WHEN JNT.COD_JUNTA LIKE '%SMP201%' THEN 'SMP-201'    
    END AS SMP,
    JNT.COD_JUNTA,
    VW.TIPO AS "EXECUCAO",
    JNT.STATUS_JUNTA,
    1 AS TOTAL,
    CASE WHEN JNT.STATUS_JUNTA LIKE '%Finaliz%' THEN 1 ELSE 0 END AS LIB,
    CASE WHEN JNT.STATUS_JUNTA NOT LIKE '%Finaliz%' THEN 1 ELSE 0 END AS PEND

FROM JNTJUNTA JNT JOIN VW_JUNTAINSPECIONADA VW ON (JNT.COD_JUNTA = 
VW.COD_JUNTA)

WHERE JNT.COD_JUNTA NOT LIKE '#%' AND JNT.COD_JUNTA LIKE '%SMP%' 
ORDER BY SMP,JNT.COD_JUNTA) A 

GROUP BY A.SMP) B


---------------------------------------------------------------------------
2) /* RESUMO DE JUNTAS SMP - AUTOMATICA */

SELECT 
B.SMP*,
B.TOTAL_JUNTA,
B.PENDENTE,
B.LIBERADA,
CASE WHEN LIBERADA=TOTAL_JUNTA THEN 'LIBERADA' ELSE 'PENDENTE' END AS STATUS

FROM
    (SELECT a.SMP,
    SUM(A.TOTAL_JUNTA) TOTAL_JUNTA,
    SUM(A.LIB) LIBERADA,
    SUM(A.PEND) PENDENTE
    FROM

        (SELECT 
        dfb.romaneio as SMP,
        jnt.cod_junta,
        jnt.status_junta as STATUS,
        1 "TOTAL_JUNTA",
        case when jnt.status_junta like 'Finaliz%' then 1 else 0 END as LIB,
        case when jnt.status_junta not like 'Finaliz%' then 1 else 0 END as PEND

        from jntjunta jnt
        left join jutjunta_df jutf on jutf.bold_id = jnt.bold_id
        left join jutjunta_dm jutd on jutd.bold_id = jnt.bold_id
        inner join dfbDesenhoFabricacao dfb on (dfb.bold_id = jutF.pdfbdf)
        WHERE COD_JUNTA LIKE '%SMP%'

        UNION

        SELECT 
        dfb.romaneio as SMP,
        jnt.cod_junta,
        jnt.status_junta as STATUS,
        1 "TOTAL_JUNTA",
        case when jnt.status_junta like 'Finaliz%' then 1 else 0 END as LIB,
        case when jnt.status_junta not like 'Finaliz%' then 1 else 0 END as PEND

        from jntjunta jnt
        left join jutjunta_df jutf on jutf.bold_id = jnt.bold_id
        left join jutjunta_dm jutd on jutd.bold_id = jnt.bold_id
        inner join dfbDesenhoFabricacao dfb on (dfb.bold_id = jutd.pdfbdf1)
        WHERE COD_JUNTA LIKE '%SMP%') A 

    GROUP BY A.SMP,A.TOTAL_JUNTA) B



 



