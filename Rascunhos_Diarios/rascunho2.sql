
// COM DATA ESPECIFICA //

select crs.nome,crs.cod_coletor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 0 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 0 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 0 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 0 else 0 end)TJUS,
sld.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        crs.nome, 
                        cod,        
                        data_Desc

union 

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 0 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)TJUS,
ens.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(ens.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc




//----------------------------------------------------------------------


select crs.nome,crs.cod_coletor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
'0' AS PF,
'0' AS VA,
sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)RS,
'0' AS VS,
'0' AS PM,
'0' AS US,
sld.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        crs.nome, 
                        cod,        
                        data_Desc

union 

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
                cast(ens.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc


union

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when atd.cod_ensaio <> '' then 1 else 0 end) as TJ,
sum(case when atd.cod_ensaio like '%DI%' then 1 else 0 end)PF,
'0' AS VA,
'0' AS RS,
'0' AS VS,
'0' AS PM,
'0' AS US,
atd.data_descarregamento as data_Desc

        from atdatividade atd 
        inner join inpinspetor as inp on atd.pinpinspetor = inp.bold_id
                where 
                cast(atd.data_descarregamento as date) = CURRENT_DATE
                        group by
                        nome, 
                        cod,        
                        data_Desc

