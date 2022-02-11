

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
'0' AS PF,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)VA,
'0' AS RS,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)VS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)PM,
sum(case when ens.cod_ensaio like 'US%' then 1 else 0 end)US,
ens.data_descarregamento as data_Desc
        from ensensaio ens 
        left join tretrecho tre on ens.ptretrecho = tre.bold_id
        left join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        left join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        left join sldsolda sld on sld.ptretrecho = tre.bold_id
        left join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(ens.data_descarregamento as date) = CURRENT_DATE-1  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc


// -----------------------------------------------------------------------

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
'0' AS PF,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)VA,
'0' AS RS,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)VS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)PM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)US,
ens.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(ens.data_descarregamento as date) = (CURRENT_DATE)-1  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc

// ----------------------------------------

SELECT 
B.SMP as SMP_,
B.TOTAL_JUNTA,
B.PENDENTE,
B.LIBERADA,
CASE WHEN LIBERADA=TOTAL_JUNTA THEN 'LIBERADA' ELSE 'PENDENTE' END AS 
STATUS

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
        WHERE COD_JUNTA LIKE '%SMP%' and jnt.COD_JUNTA NOT LIKE '#%'

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
        WHERE jnt.COD_JUNTA LIKE '%SMP%' and jnt.COD_JUNTA NOT LIKE '#%') A 

    GROUP BY A.SMP,A.TOTAL_JUNTA) B
