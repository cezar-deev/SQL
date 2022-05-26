

--PENDENCIA GERAL - CSC PINT/DIM

SELECT
dfb.TIPO_ESTRUTURA as LOCAL,
mdl.NOME_MODULO as modulo,
dmt.Cod_DM,
dfb.romaneio as SMP,
dfb.cod_df,
dfb.PESO_TOTAL,
case
        when dfb.PCNPCODPIN = 273083 then 'PI-001'
        when dfb.PCNPCODPIN = 291140 then 'PI-002'
        when dfb.PCNPCODPIN = 291141 then 'PI-003'
        when dfb.PCNPCODPIN = 291142 then 'PI-004'      
        else ''
end as CONDPI_FAB,
case
        when dfb.PCNPCODPIN2 = 273083 then 'PI-001'
        when dfb.PCNPCODPIN2 = 291140 then 'PI-002'
        when dfb.PCNPCODPIN2 = 291141 then 'PI-003'
        when dfb.PCNPCODPIN2 = 291142 then 'PI-004'      
        else ''
end as CONDPI_MON,
dfb.statusdi as DIMENSIONAL_FAB,
dfb.STATUSPI as Pintura_FAB,
dfb.statusdi_MNT as DIMENSIONAL_MNT,
dfb.STATUSPI_MNT as Pintura_MON


FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO
WHERE dfb.TIPO_ESTRUTURA = 'JURONG' 
ORDER BY 1,2,4