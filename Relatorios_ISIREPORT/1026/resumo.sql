SELECT
    tbl.nome_desenho,
    tbl.nome_modulo,
    tbl.cod_dm,
    CASE
      WHEN SUM(tbl.peso_df) IS NULL THEN
          MAX(tbl.peso_dm)
      ELSE CASE
             WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                 MAX(tbl.peso_dm)
             ELSE SUM(tbl.peso_df)
           END
    END AS peso_total,

    --------------------------------------------------------------------------------------
    --percentual_jato--
    --------------------------------------------------------------------------------------
    coalesce(SUM(tbl.jato_realizado), 0) AS peso_jato,
    CASE
      WHEN SUM(tbl.fundo_realizado) IS NULL THEN
          0
      ELSE SUM(tbl.jato_realizado) / CASE
                                        WHEN SUM(tbl.peso_df) IS NULL THEN
                                            CASE
                                              WHEN MAX(tbl.peso_dm) = 0 THEN
                                                  1
                                              ELSE 0
                                            END
                                        ELSE CASE
                                               WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                                                   MAX(tbl.peso_dm)
                                               ELSE SUM(tbl.peso_df)
                                             END
                                      END
    END AS perc_jato,

    --------------------------------------------------------------------------------------
    --percentual_fundo
    --------------------------------------------------------------------------------------
    coalesce(SUM(tbl.fundo_realizado), 0) AS peso_fundo,
    CASE
      WHEN SUM(tbl.fundo_realizado) IS NULL THEN
          0
      ELSE SUM(tbl.fundo_realizado) / CASE
                                        WHEN SUM(tbl.peso_df) IS NULL THEN
                                            CASE
                                              WHEN MAX(tbl.peso_dm) = 0 THEN
                                                  1
                                              ELSE 0
                                            END
                                        ELSE CASE
                                               WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                                                   MAX(tbl.peso_dm)
                                               ELSE SUM(tbl.peso_df)
                                             END
                                      END
    END AS perc_fundo,

    --------------------------------------------------------------------------------------
    --percentual_indetermed1
    --------------------------------------------------------------------------------------
    coalesce(SUM(tbl.interm_realizado1), 0) AS peso_intermed1,
    CASE
      WHEN SUM(tbl.interm_realizado1) IS NULL THEN
          0
      ELSE SUM(tbl.interm_realizado1) / CASE
                                         WHEN SUM(tbl.peso_df) IS NULL THEN
                                             CASE
                                               WHEN MAX(tbl.peso_dm) = 0 THEN
                                                   1
                                               ELSE 0
                                             END
                                         ELSE CASE
                                                WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                                                    MAX(tbl.peso_dm)
                                                ELSE SUM(tbl.peso_df)
                                              END
                                       END
    END AS perc_intermed1,

    --------------------------------------------------------------------------------------
     --percentual_indetermed2
    --------------------------------------------------------------------------------------
    coalesce(SUM(tbl.interm_realizado2), 0) AS peso_intermed2,
    CASE
      WHEN SUM(tbl.interm_realizado2) IS NULL THEN
          0
      ELSE SUM(tbl.interm_realizado2) / CASE
                                         WHEN SUM(tbl.peso_df) IS NULL THEN
                                             CASE
                                               WHEN MAX(tbl.peso_dm) = 0 THEN
                                                   1
                                               ELSE 0
                                             END
                                         ELSE CASE
                                                WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                                                    MAX(tbl.peso_dm)
                                                ELSE SUM(tbl.peso_df)
                                              END
                                       END
    END AS perc_intermed2,
    
    --------------------------------------------------------------------------------------
    --percentual_acab
    --------------------------------------------------------------------------------------
    coalesce(SUM(tbl.acab_realizado), 0) AS peso_acabamento,
    CASE
      WHEN SUM(tbl.acab_realizado) IS NULL THEN
          0
          --somar acab relaizado / Peso do df ou dm
      ELSE SUM(tbl.acab_realizado) / CASE 
                                       WHEN SUM(tbl.peso_df) IS NULL THEN 
                                           CASE
                                             WHEN MAX(tbl.peso_dm) = 0 THEN
                                                 1
                                             ELSE 0
                                           END
                                       ELSE CASE
                                              WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                                                  MAX(tbl.peso_dm)
                                              ELSE SUM(tbl.peso_df)
                                            END
                                     END
    END AS perc_acab,
    CASE
      WHEN LIST(tbl.general_progress) LIKE '%NOK%' THEN
          'NOK'
      ELSE CASE
             WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                 'NOK'
             ELSE 'OK'
           END
    END AS general_progress

FROM (select
    pin.nome_desenho
    , pin.nome_modulo
    , pin.cod_dm
    , pin.peso_dm
    , pin.cod_df
    , pin.peso_df
    , max(pin.demaos_jato) as demaos_jato
    , max(pin.jato_realizado) as jato_realizado
    , max(pin.jato_porc_realizado) as jato_porc_realizado
    , max(pin.demaos_fundo) as demaos_fundo
    , max(pin.fundo_realizado) as fundo_realizado
    , max(pin.fundo_porc_realizada) as fundo_porc_realizado

    , max(pin.demao_interm1) as demao_interm1
    , max(pin.interm_realizado1) as interm_realizado1
    , max(pin.interm_porc_realizada1) as interm_porc_realizado1

    , max(pin.demao_interm2) as demao_interm2
    , max(pin.interm_realizado2) as interm_realizado2
    , max(pin.interm_porc_realizada2) as interm_porc_realizado2

    , max(pin.demaos_acab) as demaos_acab
    , max(pin.acab_realizado) as acab_realizado
    , max(pin.acab_porc_realizada) as acab_porc_realizado
    , pin.general_progress
from (SELECT
    'P71' as nome_desenho,
    mdl.nome_modulo,
    dmt.cod_dm,
    dfb.peso_total as peso_dm,
    dfb.cod_df,
    dfb.peso_total AS peso_df,

    cnp.jato as demaos_jato,
    decode(cnp.jato, 0, 0, api.jato * dfb.peso_total) as jato_realizado,
    decode(cnp.jato, 0, 0, api.jato * cnp.jato) as jato_porc_realizado,

    (cnp.f1d + cnp.f2d) AS demaos_fundo,
    decode((cnp.f1d + cnp.f2d), 0, 0, cast((api.f1d + api.f2d) as float) / cast((cnp.f1d + cnp.f2d) as float) * dfb.peso_total) as fundo_realizado,
    decode((cnp.f1d + cnp.f2d), 0, 0, cast((api.f1d + api.f2d) as float) / cast((cnp.f1d + cnp.f2d) as float)) as fundo_porc_realizada,

    (cnp.i1d) AS demao_interm1,
    decode((cnp.i1d), 0, 0, cast((api.i1d) as float) / cast((cnp.i1d) as float) * dfb.peso_total) as interm_realizado1,
    decode((cnp.i1d), 0, 0, cast((api.i1d) as float) / cast((cnp.i1d) as float)) as interm_porc_realizada1,

    (cnp.i2d) AS demao_interm2,
    decode((cnp.i2d), 0, 0, cast((api.i2d) as float) / cast((cnp.i2d) as float) * dfb.peso_total) as interm_realizado2,
    decode((cnp.i2d), 0, 0, cast((api.i2d) as float) / cast((cnp.i2d) as float)) as interm_porc_realizada2,

    (cnp.a1d + cnp.a2d + cnp.a3d) AS demaos_acab,
    decode((cnp.a1d + cnp.a2d + cnp.a3d), 0, 0, cast((api.a1d + api.a2d + api.a3d) as float) / cast((cnp.a1d + cnp.a2d + cnp.a3d) as float) * dfb.peso_total) as acab_realizado,
    decode((cnp.a1d + cnp.a2d + cnp.a3d), 0, 0, cast((api.a1d + api.a2d + api.a3d) as float) / cast((cnp.a1d + cnp.a2d + cnp.a3d) as float)) as acab_porc_realizada,

    CASE
      WHEN api.f1d IS NULL THEN
          'NOK'
      ELSE CASE
             -- criterio conservador, considerando ok somente quando tudo estiver realizado
             WHEN cnp.jato = api.jato and cnp.f1d = api.f1d AND cnp.f2d = api.f2d AND cnp.i1d = api.i1d AND cnp.i2d = api.i2d AND cnp.a1d = api.a1d AND cnp.a2d = api.a2d AND cnp.a3d = api.a3d THEN
             --WHEN api.f1d = 1 AND api.f2d = 1 AND api.i1d = 1 AND api.i2d = 1 AND api.a1d = 1 AND api.a2d = 1 AND api.a3d = 1 THEN
                 'OK'
             ELSE 'NOK'
           END
    END as general_progress
FROM dfbdesenhofabricacao dfb
INNER JOIN dmtdesenhomontagem dmt ON dfb.pdmtdm = dmt.bold_id
INNER JOIN mdlmodulo mdl ON dmt.pmdlmodulo = mdl.bold_id
INNER JOIN prgprojeto prg ON (1 = 1)
LEFT JOIN atdatividade atd ON atd.pdfbdf = dfb.bold_id AND atd.tipo = 8 and atd.tipo_atd = 'MNT'
LEFT JOIN cnpcodicaopintura cnp ON cnp.bold_id = dfb.pcnpcodpin2
LEFT JOIN attpi api ON api.bold_id = atd.bold_id
WHERE DFB.TIPO_ESTRUTURA = 'JURONG') pin

group by 1, 2, 3, 4, 5, 6, 22) AS tbl
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3