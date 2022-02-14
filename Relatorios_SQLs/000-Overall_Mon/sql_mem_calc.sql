select
    case
        when prj.execucao = 'OFC' then 'P71 - ' || prj.tipo_estrutura
        else 'P71 - JURONG'
    end as projeto
    , prj.modulo
    , prj.dm
    , prj.tipo_junta_ingles
    , prj.nivel_inspecao_ingles
    , prj.espessura1

    -- Campos agrupados
    , count(prj.junta) as qtd_junta
    , sum(decode(prj.statusva, 'AP', 1, 0)) as va_executado
    , sum(decode(prj.statusrs, 'AP', 1, 0)) as rs_executado
    , sum(decode(prj.statusvs, 'AP', 1, 0)) as vs_executado

    , sum(decode(prj.statuspm, 'NA', 0, (prj.ensaiopm / 100))) as pm_requerido
    , sum(decode(prj.statuslp, 'NA', 0, (prj.ensaiolp / 100))) as lp_requerido
    , sum(decode(prj.statusrx, 'NA', 0, (prj.ensaioer / 100))) as rx_requerido
    , sum(decode(prj.statusus, 'NA', 0, (prj.ensaious / 100))) as us_requerido

    , sum(decode(prj.statuspm, 'AP', 1, 0)) as pm_executado
    , sum(decode(prj.statuslp, 'AP', 1, 0)) as lp_executado
    , sum(decode(prj.statusrx, 'AP', 1, 0)) as rx_executado
    , sum(decode(prj.statusus, 'AP', 1, 0)) as us_executado

    , sum(prj.extensao) as ext_jnt

    , sum(decode(prj.statuspm, 'NA', 0, (prj.ensaiopm * prj.extensao / 100))) as comp_pm_requerido
    , sum(decode(prj.statuslp, 'NA', 0, (prj.ensaiolp * prj.extensao / 100))) as comp_lp_requerido
    , sum(decode(prj.statusrx, 'NA', 0, (prj.ensaioer * prj.extensao / 100))) as comp_rx_requerido
    , sum(decode(prj.statusus, 'NA', 0, (prj.ensaious * prj.extensao / 100))) as comp_us_requerido

    , sum(ext.extinsp_pm) as comp_pm_executado
    , sum(ext.extinsp_lp) as comp_lp_executado
    , sum(ext.extinsp_rx) as comp_rx_executado
    , sum(ext.extinsp_us) as comp_us_executado

    , coalesce(sum(CASE
        WHEN (prj.statusus = 'AP') OR (prj.statusus = 'RP') OR (prj.statusrx = 'AP') OR (prj.statusrx = 'RP') THEN
            (SELECT
                 SUM(dft.extensaodefeito)
             FROM ensensaio ens
             JOIN dftdefeito dft ON dft.pensensaio = ens.bold_id
             JOIN tretrecho tre ON tre.bold_id = ens.ptretrecho
             JOIN jntjunta jnt1 ON jnt1.bold_id = tre.pjntjunta
             WHERE jnt1.bold_id = prj.pjntjunta
             GROUP BY jnt1.bold_id)
        ELSE 0
      END), 0) AS comp_defeito

from
    gat_projeto_mnt prj
    left join gat_extinspjnt ext on prj.pjntjunta = ext.pjntjunta
where prj.junta not like '%#%' and
prj.execucao = @execucao --and prj.dm = @MODULO
group by 1, 2, 3, 4, 5, 6