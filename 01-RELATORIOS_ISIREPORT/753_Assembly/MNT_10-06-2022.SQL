
select *
from(select
    dados.projeto
    , dados.nome_modulo
    , dados.cod_dm
    , sum(dados.peso_total) as peso_total

    , sum(dados.peso_va) as peso_va
    , case when  sum(dados.peso_total) = 0 then 0 else (sum(dados.peso_va) / sum(dados.peso_total)) end as perc_va

    , sum(dados.peso_rs) as peso_rs
    , case when  sum(dados.peso_total) = 0 then 0 else (sum(dados.peso_rs) / sum(dados.peso_total)) end as perc_rs

    , sum(dados.peso_end) as peso_end
    , case when  sum(dados.peso_total) = 0 then 0 else (sum(dados.peso_end) / sum(dados.peso_total)) end as perc_end

from
    (
    select
        'P71' as projeto
        , mdl.nome_modulo
        , dmt.cod_dm
        , dfb.cod_df
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
        left join gat_avancodf_mnt av on av.pdfbdf = dfb.bold_id
    
   where dfb.tipo_estrutura = 'JURONG' and av.jnt_qtd is not null) dados -- ( csc ) Acrecentado : and av.jnt_qtd is not null --
    where dados.nome_modulo not like '%EQP-BASES%' 
group by 1, 2, 3)a
where  
    a.cod_dm <>'CAISSON'
and a.cod_dm not like '%BDE%'
and a.cod_dm <>'FORECASTLE'
and a.cod_dm <>'M00-LDPF/TR'
and a.cod_dm <>'MAIN DECK'
and a.cod_dm <> 'TROLLEY'
and a.cod_dm <> 'M09'
and a.cod_dm <> 'PPS'
and a.cod_dm <> 'M08'
and a.cod_dm <> 'M10'
and a.cod_dm <> 'M13'
and a.cod_dm not like  'SS%'
