-- 1151 Resumo rev 2

select*
from (select
    dados.tipo_estrutura
    , dados.nome_modulo
    , dados.cod_dm

    , pesos.peso_total
    , sum(dados.peso_total) as peso_escopo

   -- , coalesce(sum(dados.peso_corte), 0) as peso_corte
    , CASE WHEN coalesce(sum(dados.peso_corte), 0)< sum(dados.peso_va) THEN sum(dados.peso_va) ELSE coalesce(sum(dados.peso_corte), 0) END AS PESO_CORTE

    --, decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_corte) / sum(dados.peso_total))) as perc_corte
    , CASE WHEN decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_corte) / sum(dados.peso_total)))  <
    Decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_va) / sum(dados.peso_total))) THEN Decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_va) / sum(dados.peso_total)))
    ELSE decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_corte) / sum(dados.peso_total)))END AS PERC_CORTE

    , sum(dados.peso_va) as peso_va
    , decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_va) / sum(dados.peso_total))) as perc_va

    , sum(dados.peso_solda) as peso_solda
    , decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_solda) / sum(dados.peso_total))) as perc_solda

    , sum(dados.peso_ndt) as peso_ndt
    , decode(sum(dados.peso_total), 0, 0, (sum(dados.peso_ndt) / sum(dados.peso_total))) as perc_ndt

    , (case when list(dados.dimensional) like '%NOK%' then 'NOK' else 'OK' end) as dimensional
from
    (
    select
        dfb.tipo_estrutura
        , mdl.nome_modulo
        , dmt.cod_dm
        , dfb.cod_df
        , coalesce(av.jnt_qtd, 0) as jnt_qtd
        , dfb.peso_total

        , substring(dfb.no1 from 1 for 3) as corte_programado
        , cmps.cmp_peso_cortado as peso_corte
        , decode(cmps.cmp_peso, 0, 0, (cmps.cmp_peso_cortado / cmps.cmp_peso)) as perc_corte
        , substring(dfb.no1 from 4 for 3) as corte_realizado

        , substring(dfb.no1 from 7 for 3) as ajuste_programado
        , case when av.jnt_qtd > 0 then (av.va_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else dfb.peso_total  end as peso_va
        --, case when av.jnt_qtd > 0 then (av.va_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else cmps.cmp_peso_cortado end as peso_va
        , case when av.VA_JNT_QTD > 0 then (av.va_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as perc_va
        , substring(dfb.no1 from 10 for 3) as ajuste_realizado

        , substring(dfb.no1 from 13 for 3) as solda_programada
        , case when av.jnt_qtd > 0 then (av.rs_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else dfb.peso_total end as peso_solda
        --, case when av.jnt_qtd > 0 then (av.rs_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else cmps.cmp_peso_cortado end as peso_solda
        , case when av.rs_JNT_QTD > 0 then (av.rs_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as perc_solda
        , substring(dfb.no1 from 16 for 3) as solda_realizada
        
        
        
        , case when av.jnt_qtd > 0 then (av.lib_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else dfb.peso_total end as peso_ndt
        --, case when av.jnt_qtd > 0 then (av.lib_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else cmps.cmp_peso_cortado end as peso_ndt
        , case when av.lib_jnt_qtd > 0 then (av.lib_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as perc_ndt
        , case when (dfb.statusdi = 'AP') or (dfb.statusdi = 'NA') then 'OK' else 'NOK' end as dimensional

    from
        dfbdesenhofabricacao dfb
        inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
        inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id
        left join gat_avancodf_fab av on dfb.bold_id = av.pdfbdf
        left join gat_avancocmp cmps on dfb.bold_id = cmps.pdfbdf
where dfb.tipo_estrutura = 'JURONG'
--and dfb.cod_df ='LDSF-F239HA'


   
    ) dados
    inner join (select
                    dmt.cod_dm
                    , sum(dfb.peso_total) as peso_total
                from
                    dfbdesenhofabricacao dfb
                    inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
                group by 1) pesos on dados.cod_dm = pesos.cod_dm
where dados.tipo_estrutura = 'JURONG'
group by 1, 2, 3, 4)a
where  a.cod_dm not like '%BDE%'
and a.cod_dm <>'CAISSON'
and a.cod_dm <>'FORECASTLE'
and a.cod_dm <>'M00-LDPF/TR'
and a.cod_dm <>'MAIN DECK'
and a.cod_dm <> 'TROLLEY'
and a.cod_dm <> 'M09'
and a.cod_dm <> 'PPS'
and a.cod_dm <> 'M08'
and a.cod_dm <> 'M10'
and a.cod_dm not like  'SS%'