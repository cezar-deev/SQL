select
    case
        when jnt.execucao = 0 then 'P68 - ' || dfb.tipo_estrutura
        else 'P68 - JURONG'
    end as projeto
    , mdl.nome_modulo as modulo
    , dmt.cod_dm as dm
    , decode(jnt.tipo_junta
                , 0, 'BUTT'
                , 1, 'T / FP'
                , 2, 'T / FW'
                , 4, 'T / PP'
                , 5, 'T / PP') as tipo_junta
    , trim(case
            when jnt.nivel_inspecao = 'I' and jnt.espessura1 >= 8 and (jnt.tipo_junta = 0) then
                    'A / T >= 8mm'
            when jnt.nivel_inspecao = 'I' and jnt.espessura1 < 8 and (jnt.tipo_junta = 0) then
                    'A / T < 8mm'
            when jnt.nivel_inspecao = 'II' and jnt.espessura1 >= 8 and (jnt.tipo_junta = 0) then
                    'B / T >= 8mm'
            when jnt.nivel_inspecao = 'II' and jnt.espessura1 < 8 and (jnt.tipo_junta = 0) then
                    'B / T < 8mm'
            else decode(jnt.nivel_inspecao, 'I', 'A', 'II', 'B', 'III', 'C', 'IV', 'D')
        end) as nivel_inspecao

    , jnt.espessura1 as espessura

    , count(jnt.cod_junta) as qtd_jnt
    , sum(decode(jnt.statusva, 'AP', 1, 0)) as va_executado
    , sum(decode(jnt.statusrs, 'AP', 1, 0)) as rs_executado
    , sum(decode(jnt.statusvs, 'AP', 1, 0)) as vs_executado

    --, sum(decode(jnt.statuspm, 'NA', 0, 1)) as pm_requerido
    , sum(decode(jnt.statuspm, 'NA', 0, (cls.ensaiopm / 100))) as pm_requerido
    , sum(decode(jnt.statuslp, 'NA', 0, (cls.ensaiolp / 100))) as lp_requerido
    --, sum(decode(jnt.statusrx, 'NA', 0, 1)) as rx_requerido
    , sum(decode(jnt.statusrx, 'NA', 0, (cls.ensaioer / 100))) as rx_requerido
    --, sum(decode(jnt.statusus, 'NA', 0, 1)) as us_requerido
    , sum(decode(jnt.statusus, 'NA', 0, (cls.ensaious / 100))) as us_requerido

    , sum(decode(jnt.statuspm, 'AP', 1, 0)) as pm_executado
    , sum(decode(jnt.statuslp, 'AP', 1, 0)) as lp_executado
    , sum(decode(jnt.statusrx, 'AP', 1, 0)) as rx_executado
    , sum(decode(jnt.statusus, 'AP', 1, 0)) as us_executado

    , sum(jnt.extensao) as ext_jnt

    , sum(decode(jnt.statuspm, 'NA', 0, (cls.ensaiopm * jnt.extensao / 100))) as comp_pm_requerido
    , sum(decode(jnt.statuslp, 'NA', 0, (cls.ensaiolp * jnt.extensao / 100))) as comp_lp_requerido
    , sum(decode(jnt.statusrx, 'NA', 0, (cls.ensaioer * jnt.extensao / 100))) as comp_rx_requerido
    , sum(decode(jnt.statusus, 'NA', 0, (cls.ensaious * jnt.extensao / 100))) as comp_us_requerido

    , coalesce(sum(pm.ext), 0) as comp_pm_executado
    , coalesce(sum(lp.ext), 0) as comp_lp_executado
    , coalesce(sum(rx.ext), 0) as comp_rx_executado
    , coalesce(sum(us.ext), 0) as comp_us_executado

    , coalesce(sum(CASE
        WHEN (jnt.statusus = 'AP') OR (jnt.statusus = 'RP') OR (jnt.statusrx = 'AP') OR (jnt.statusrx = 'RP') THEN
            (SELECT
                 SUM(dft.extensaodefeito)
             FROM ensensaio ens
             JOIN dftdefeito dft ON dft.pensensaio = ens.bold_id
             JOIN tretrecho tre ON tre.bold_id = ens.ptretrecho
             JOIN jntjunta jnt1 ON jnt1.bold_id = tre.pjntjunta
             WHERE jnt1.bold_id = jnt.bold_id
             GROUP BY jnt1.bold_id)
        ELSE 0
      END), 0) AS comp_defeito

from(
    select
        jdf.pdfbdf
        , jdf.bold_id
    from
        jutjunta_df jdf
    union all
    select
        jdm.pdfbdf1
        , jdm.bold_id
    from
        jutjunta_dm jdm) jut
    inner join jntjunta jnt on jut.bold_id = jnt.bold_id
    inner join clsclasse cls on jnt.pclsclasse = cls.bold_id
    inner join dfbdesenhofabricacao dfb on jut.pdfbdf = dfb.bold_id
    inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
    inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id

    left join (select
                    tre.pjntjunta
                    , sum((ent.trecho_fim - ent.trecho_inicio)) as ext
                from
                    tretrecho tre
                    inner join ensensaio ens on tre.classificacao = 1 and tre.bold_id = ens.ptretrecho
                    inner join entens_pm ent on ens.bold_id = ent.bold_id
                group by
                    1) pm on pm.pjntjunta = jnt.bold_id
    left join (select
                    tre.pjntjunta
                    , sum((ent.trecho_fim - ent.trecho_inicio)) as ext
                from
                    tretrecho tre
                    inner join ensensaio ens on tre.classificacao = 1 and tre.bold_id = ens.ptretrecho
                    inner join entens_lp ent on ens.bold_id = ent.bold_id
                group by
                    1) lp on lp.pjntjunta = jnt.bold_id
    left join (select
                    tre.pjntjunta
                    , sum((ent.trecho_fim - ent.trecho_inicio)) as ext
                from
                    tretrecho tre
                    inner join ensensaio ens on tre.classificacao = 1 and tre.bold_id = ens.ptretrecho
                    inner join entens_rx ent on ens.bold_id = ent.bold_id
                group by
                    1) rx on rx.pjntjunta = jnt.bold_id
    left join (select
                    tre.pjntjunta
                    , sum((ent.trecho_fim - ent.trecho_inicio)) as ext
                from
                    tretrecho tre
                    inner join ensensaio ens on tre.classificacao = 1 and tre.bold_id = ens.ptretrecho
                    inner join entens_us ent on ens.bold_id = ent.bold_id
                group by
                    1) us on us.pjntjunta = jnt.bold_id
where
    jnt.cod_junta not like '%#%' and jnt.execucao = 0 and dfb.tipo_estrutura = @tipo_estrutura
group by
    1, 2, 3, 4, 5, 6