SELECT
A.nome_desenho,
A.nome_modulo,
A.cod_dm,
A.peso_total,
A.peso_fundo,
A.perc_fundo,
A.peso_intermed,
A.perc_intermed,
A.peso_acabamento,
A.perc_acab,
A.general_progress


FROM (SELECT
    tbl.nome_desenho,
    tbl.nome_modulo,
    tbl.cod_dm,
     sum(tbl.peso_df) as peso_total,
    --CASE
      --WHEN SUM(tbl.peso_df) IS NULL THEN
        --  MAX(tbl.peso_dm)
      --ELSE CASE
        --     WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
          --       MAX(tbl.peso_dm)
            -- ELSE SUM(tbl.peso_df)
           --END
    --END AS peso_total,
    SUM(tbl.fundo_realizado) AS peso_fundo,
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
    decode(SUM(tbl.interm_realizado), 0, 'NA', SUM(tbl.interm_realizado)) AS peso_intermed,
    decode(CASE
      WHEN SUM(tbl.interm_realizado) IS NULL THEN
          0
      ELSE SUM(tbl.interm_realizado) / CASE
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
    END, 0, 'NA', CASE
      WHEN SUM(tbl.interm_realizado) IS NULL THEN
          0
      ELSE SUM(tbl.interm_realizado) / CASE
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
    END) AS perc_intermed,
    decode(SUM(tbl.acab_realizado), 0, 'NA', SUM(tbl.acab_realizado)) AS peso_acabamento,
    decode(CASE
      WHEN SUM(tbl.acab_realizado) IS NULL THEN
          0
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
    END, 0, 'NA', CASE
      WHEN SUM(tbl.acab_realizado) IS NULL THEN
          0
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
    END) AS perc_acab,
    CASE
      WHEN LIST(tbl.general_progress) LIKE '%NOK%' THEN
          'NOK'
      ELSE CASE
             WHEN MAX(tbl.peso_dm) > SUM(tbl.peso_df) THEN
                 'NOK'
             ELSE 'OK'
           END
    END AS general_progress

FROM (SELECT
          'P71' AS nome_desenho,
          mdl.nome_modulo,
          dmt.cod_dm,
          CMP.cmp_peso AS peso_dm,
          dfb.cod_df,
          dfb.peso_total AS peso_df,
          cnp.f1d + cnp.f2d AS demaos_fundo,
          (
          CASE
            WHEN api.f1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.f1d = 0 AND cnp.f2d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --dfb.peso_total
                   ELSE (api.f1d * cnp.f1d + api.f2d * cnp.f2d) * dfb.peso_total / (cnp.f1d + cnp.f2d)
                 END
          END) AS fundo_realizado,
          (
          CASE
            WHEN api.f1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.f1d = 0 AND cnp.f2d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --1
                   ELSE (api.f1d * cnp.f1d + api.f2d * cnp.f2d) / (cnp.f1d + cnp.f2d)
                 END
          END) AS fundo_porc_realizada,
          cnp.i1d + cnp.i2d AS demaos_interm,
          (
          CASE
            WHEN api.i1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --dfb.peso_total
                   ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) * dfb.peso_total / (cnp.i1d + cnp.i2d)
                 END
          END) AS interm_realizado,
          (
          CASE
            WHEN api.i1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --1
                   ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) / (cnp.i1d + cnp.i2d)
                 END
          END) AS interm_porc_realizada,
          cnp.a1d + cnp.a2d + cnp.a3d AS demaos_acab,
          (
          CASE
            WHEN api.a1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --dfb.peso_total
                   ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) * dfb.peso_total / (cnp.a1d + cnp.a2d + cnp.a2d)
                 END
          END) AS acab_realizado,
          (
          CASE
            WHEN api.a1d IS NULL THEN
                0
            ELSE CASE
                   WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                       -- considerando item nao avancado caso nao tenha condicao para tal
                       0 --1
                   ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) / (cnp.a1d + cnp.a2d + cnp.a2d)
                 END
          END) AS acab_porc_realizada,
          CASE
            WHEN api.f1d IS NULL THEN
                'NOK'
            ELSE CASE
                 -- criterio conservador, considerando ok somente quando tudo estiver realizado
                 --WHEN cnp.f1d = api.f1d AND cnp.f2d = api.f2d AND cnp.i1d = api.i1d AND cnp.i2d = api.i2d AND cnp.a1d = api.a1d AND cnp.a2d = api.a2d AND cnp.a3d = api.a3d THEN
                   WHEN api.f1d = 1 AND api.f2d = 1 AND api.i1d = 1 AND api.i2d = 1 AND api.a1d = 1 AND api.a2d = 1 AND api.a3d = 1 THEN
                       'OK'
                   ELSE 'NOK'
                 END
          END AS general_progress
      FROM dfbdesenhofabricacao dfb
      INNER JOIN dmtdesenhomontagem dmt ON dfb.pdmtdm = dmt.bold_id
      INNER JOIN mdlmodulo mdl ON dmt.pmdlmodulo = mdl.bold_id
      INNER JOIN prgprojeto prg ON (1 = 1)
      LEFT JOIN atdatividade atd ON atd.pdfbdf = dfb.bold_id AND atd.tipo = 8 and atd.tipo_atd = 'FBR'
      LEFT JOIN cnpcodicaopintura cnp ON cnp.bold_id = dfb.pcnpcodpin
      LEFT JOIN attpi api ON api.bold_id = atd.bold_id
      RIGHT join gat_avancocmp CMP on CMP.pdfbdf = DFB.bold_id
      WHERE DFB.tipo_estrutura = 'JURONG') AS tbl
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3)a
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
and a.cod_dm <> 'M13'
and a.cod_dm not like  '%SS%'