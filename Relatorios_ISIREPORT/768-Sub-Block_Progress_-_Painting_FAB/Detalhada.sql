
SELECT
    'P71 - ' || dfb.tipo_estrutura AS nome_desenho,
    mdl.nome_modulo,
    dmt.cod_dm,
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

    decode((cnp.i1d + cnp.i2d), 0, 'NA', (cnp.i1d + cnp.i2d)) AS demaos_interm,
    decode((CASE
      WHEN api.i1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                 0 --dfb.peso_total 
             ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) * dfb.peso_total / (cnp.i1d + cnp.i2d)
           END
    END), 0, 'NA', (CASE
      WHEN api.i1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                 0 --dfb.peso_total 
             ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) * dfb.peso_total / (cnp.i1d + cnp.i2d)
           END
    END)) AS interm_realizado,
    decode((CASE
      WHEN api.i1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                0 --1
             ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) / (cnp.i1d + cnp.i2d)
           END
    END), 0, 'NA', (CASE
      WHEN api.i1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.i1d = 0 AND cnp.i2d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                0 --1
             ELSE (api.i1d * cnp.i1d + api.i2d * cnp.i2d) / (cnp.i1d + cnp.i2d)
           END
    END)) AS interm_porc_realizada,

    decode((cnp.a1d + cnp.a2d + cnp.a3d), 0, 'NA', (cnp.a1d + cnp.a2d + cnp.a3d)) AS demaos_acab,
    decode((CASE
      WHEN api.a1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                 0 --dfb.peso_total 
             ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) * dfb.peso_total / (cnp.a1d + cnp.a2d + cnp.a2d)
           END
    END), 0, 'NA', (CASE
      WHEN api.a1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                 0 --dfb.peso_total 
             ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) * dfb.peso_total / (cnp.a1d + cnp.a2d + cnp.a2d)
           END
    END)) AS acab_realizado,
    decode((CASE
      WHEN api.a1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                0 --1
             ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) / (cnp.a1d + cnp.a2d + cnp.a2d)
           END
    END), 0, 'NA', (CASE
      WHEN api.a1d IS NULL THEN
          0
      ELSE CASE
             WHEN cnp.a1d = 0 AND cnp.a2d = 0 AND cnp.a3d = 0 THEN
                -- considerando item nao avancado caso nao tenha condicao para tal
                0 --1
             ELSE (api.a1d * cnp.a1d + api.a2d * cnp.a2d + api.a3d * cnp.a3d) / (cnp.a1d + cnp.a2d + cnp.a2d)
           END
    END)) AS acab_porc_realizada,
    CASE
      WHEN api.f1d IS NULL THEN
          'NOK'
      ELSE CASE
             -- criterio conservador, considerando ok somente quando tudo estiver realizado
             WHEN cnp.f1d = api.f1d AND cnp.f2d = api.f2d AND cnp.i1d = api.i1d AND cnp.i2d = api.i2d AND cnp.a1d = api.a1d AND cnp.a2d = api.a2d AND cnp.a3d = api.a3d THEN
             --WHEN api.f1d = 1 AND api.f2d = 1 AND api.i1d = 1 AND api.i2d = 1 AND api.a1d = 1 AND api.a2d = 1 AND api.a3d = 1 THEN
                 'OK'
             ELSE 'NOK'
           END
    END as general_progress
FROM dfbdesenhofabricacao dfb
INNER JOIN dmtdesenhomontagem dmt ON dfb.pdmtdm = dmt.bold_id
INNER JOIN mdlmodulo mdl ON dmt.pmdlmodulo = mdl.bold_id
INNER JOIN prgprojeto prg ON (1 = 1)
LEFT JOIN atdatividade atd ON atd.pdfbdf = dfb.bold_id AND atd.tipo = 8 and atd.tipo_atd = 'FBR'
LEFT JOIN cnpcodicaopintura cnp ON cnp.bold_id = dfb.pcnpcodpin
LEFT JOIN attpi api ON api.bold_id = atd.bold_id
