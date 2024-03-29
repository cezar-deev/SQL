
--SQL DA ABA DE RESUMO--


--------------------------------------------------------------------
-- RESUMO DIMENSIONAL-FAB
SELECT
mdl.NOME_MODULO AS MODULO,
DFB.ROMANEIO AS SMP,
--DMT.COD_DM AS DM,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi <>'AP'

GROUP BY mdl.NOME_MODULO,dfb.TIPO_ESTRUTURA,ROMANEIO--,DMT.COD_DM


--------------------------------------------------------------------
-- RESUMO DIMENSIONAL-MON
SELECT
mdl.NOME_MODULO,
DFB.ROMANEIO AS SMP,
--DMT.COD_DM AS DM,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi_MNT <>'AP'

GROUP BY mdl.NOME_MODULO,dfb.TIPO_ESTRUTURA,ROMANEIO--,DMT.COD_DM


-------------------------------------------------------------------
-- RESUMO PINTURA-FAB
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG' AND dfb.STATUSPI <>'AP'

GROUP BY mdl.NOME_MODULO


------------------------------------------------------------------
-- RESUMO PINTURA-MNT
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG' AND dfb.STATUSPI_MNT <>'AP'

GROUP BY mdl.NOME_MODULO