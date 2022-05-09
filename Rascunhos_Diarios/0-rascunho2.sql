
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


//-----------------------------------------------------------


select
    mdl.nome_modulo as Sub_Bloco,
    dmt.cod_dm as Modulo,
    dfb.cod_df as DF,
    dfb.romaneio as SMP,
    dfb.tipo_estrutura as Fabricante, 
    cmp.cod_componente,
    cmp.componente as Componente,
        case
        when cmp.tipo_componente = 0 then 'PERFIL'
        when cmp.tipo_componente = 1 then 'TUBO'
        when cmp.tipo_componente = 2 then 'CONE'
        when cmp.tipo_componente = 3 then 'CHAPA TRAP'
        when cmp.tipo_componente = 4 then 'CHAPA'
        when cmp.tipo_componente = 5 then 'ANEL'
        when cmp.tipo_componente = 6 then 'BARRA'
        when cmp.tipo_componente = 7 then 'CAP'
        when cmp.tipo_componente = 8 then 'FLANGE'
        when cmp.tipo_componente = 9 then 'CURVA'
        else ''
    end as Tipo,

    dfb.desenhobr as Desenho,
    cmp.Peso,
    pct.cod_pc as Plano_de_Corte,

    case 
        when mpr.cod_mp is null then 'Pendente' else 'Aprov' 
    end as Status_Corte, 

    case 
        when cmp.datacorte='1899.12.30' then ' ' else 
                cast(substring (cmp.datacorte from 9 for 2 )as varchar(2)) 
        ||'/'|| cast(substring (cmp.datacorte from 6 for 2 )as varchar(2))
        ||'/'|| cast(substring (cmp.datacorte from 1 for 4 )as varchar(4))


    end as Data_Corte,

    mpr.cod_mp as Material,
    cmp.Status_Comp as Status_Componentes

        from  cmpcomponente cmp
        left join pctplano_corte pct on pct.bold_id = cmp.ppctpcorte
        left join dfbdesenhofabricacao dfb on dfb.bold_id = cmp.pdfbdf
        left join crtcorte crt on crt.ppctplanocorte = pct.bold_id
        left join mprmateriaprima mpr on mpr.bold_id = crt.pmprmateriaprima
        left join dmtdesenhomontagem dmt on dmt.bold_id = dfb.pdmtdm
        left join mdlmodulo mdl on mdl.bold_id = dmt.pmdlmodulo

where dmt.cod_dm is not null         
order by 1,2,3,6


SELECT 
        pct.cod_pc as Plano_Corte,
        pct.datacorte,
        crt.codensaio

FROM 
        pctplano_corte pct left join crtcorte crt on (pct.bold_id = crt.PPCTPLANOCORTE)
where 
        pct.cod_pc='M0008A01'or
        pct.cod_pc='M0025A03'or
        pct.cod_pc='M0025E01'or
        pct.cod_pc='M12B10A03'or
        pct.cod_pc='M12B10A04'or
        pct.cod_pc='M12B10A07'or
        pct.cod_pc='M12C09A04'or
        pct.cod_pc='M12C09A05'or
        pct.cod_pc='M1406A02'or
        pct.cod_pc='M1410A02'


------------------------------------------------------

SELECT 
        AREA,
        SINETE, 
        NOME,
        DTENTRADA,
        DTAFASTAMENTO,
        DTSAIDA
FROM 
     SOLSOLDADOR

WHERE AREA='JURONG' AND SINETE LIKE 'EJA%'

ORDER BY AREA,SINETE


--------------------------------------------------------------------------

SELECT  W.SINETE,
        W.PROCESSO_SOLDAGEM,
        W.COUNT(JUNTA) AS QTD_AS
FROM VW_SOLDA

GROUP BY W.SINETE,W.PROCESSO_SOLDAGEM
ORDER BY W.SINETE