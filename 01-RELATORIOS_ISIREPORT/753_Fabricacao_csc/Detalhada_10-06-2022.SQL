

select
    'P71' as projeto
    , mdl.nome_modulo
    , dmt.cod_dm
    , dfb.cod_df
    , coalesce(av.jnt_qtd, 0) as jnt_qtd
    , dfb.peso_total

    , case
      when substring(dfb.no2 from 1 for 3) = '---' then ''
      else substring(dfb.no2 from 1 for 3)
    end as sem_programada_va
    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', dfb.peso_total, 0), coalesce(((cast(av.va_jnt_qtd as float) / cast(av.jnt_qtd as float)) * dfb.peso_total), 0)) as peso_va
    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', 1, 0), coalesce(((cast(av.va_jnt_qtd as float) / cast(av.jnt_qtd as float))), 0)) as perc_va
    , case
      when substring(dfb.no2 from 4 for 3) = '---' then ''
      else substring(dfb.no2 from 4 for 3)
    end as sem_realizada_va

    , case
      when substring(dfb.no2 from 7 for 3) = '---' then ''
      else substring(dfb.no2 from 7 for 3)
    end as sem_programada_rs
    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', dfb.peso_total, 0), coalesce(((cast(av.rs_jnt_qtd as float) / cast(av.jnt_qtd as float)) * dfb.peso_total), 0)) as peso_rs
    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', 1, 0), coalesce(((cast(av.rs_jnt_qtd as float) / cast(av.jnt_qtd as float))), 0)) as perc_rs
    , case
      when substring(dfb.no2 from 10 for 3) = '---' then ''
      else substring(dfb.no2 from 10 for 3)
    end as sem_realizada_rs

    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', dfb.peso_total, 0), coalesce(((cast(av.lib_jnt_qtd as float) / cast(av.jnt_qtd as float)) * dfb.peso_total), 0)) as peso_end
    , decode(coalesce(av.jnt_qtd, 0), 0, decode(dfb.status_df_fab, 'Liberado Para Montagem', 1, 0), coalesce(((cast(av.lib_jnt_qtd as float) / cast(av.jnt_qtd as float))), 0)) as perc_end

from
    dfbdesenhofabricacao dfb
    inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
    inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id
    left join gat_avancodf_fab av on av.pdfbdf = dfb.bold_id
where
    dfb.cod_df not like '%FND%' and dfb.tipo_estrutura <> 'TERCIARIA' and mdl.nome_modulo not like '%EQP-BASES%' and av.jnt_qtd is not null  -- and dmt.cod_dm not like '%R%'
