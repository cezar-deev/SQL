

// COM DATA ESPECIFICA //

select crs.nome,crs.cod_coletor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 0 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 0 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 0 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 0 else 0 end)TJUS,
sld.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        crs.nome, 
                        cod,        
                        data_Desc

union 

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
sum(case when sld.cod_solda like '%RS%' then 0 else 0 end)TJRS,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)TJVA,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)TJVS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)TJPM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)TJUS,
ens.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(ens.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc


//----------------------------------------------------------------------


select crs.nome,crs.cod_coletor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
'0' AS PF,
'0' AS VA,
sum(case when sld.cod_solda like '%RS%' then 1 else 0 end)RS,
'0' AS VS,
'0' AS PM,
'0' AS US,
sld.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(sld.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        crs.nome, 
                        cod,        
                        data_Desc

union 

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when jnt.cod_junta <> '' then 1 else 0 end) as TJ,
'0' AS PF,
sum(case when ens.cod_ensaio like '%VA%' then 1 else 0 end)VA,
'0' AS RS,
sum(case when ens.cod_ensaio like '%VS%' then 1 else 0 end)VS,
sum(case when ens.cod_ensaio like '%PM%' then 1 else 0 end)PM,
sum(case when ens.cod_ensaio like '%US%' then 1 else 0 end)US,
ens.data_descarregamento as data_Desc
        from ensensaio ens 
        inner join tretrecho tre on ens.ptretrecho = tre.bold_id
        inner join jntjunta jnt on jnt.bold_id = tre.pjntjunta
        inner join inpinspetor inp on inp.bold_id = ens.pinpinspetor         
        inner join sldsolda sld on sld.ptretrecho = tre.bold_id
        inner join crscoletorproducao crs on crs.bold_id = sld.pcrscolet
                where 
                cast(ens.data_descarregamento as date) = CURRENT_DATE  and (jnt.cod_junta not like '#%')
                        group by
                        nome, 
                        cod,        
                        data_Desc


union

select inp.nome as nome,inp.cod_inspetor as cod,
sum(case when atd.cod_ensaio <> '' then 1 else 0 end) as TJ,
sum(case when atd.cod_ensaio like '%DI%' then 1 else 0 end)PF,
'0' AS VA,
'0' AS RS,
'0' AS VS,
'0' AS PM,
'0' AS US,
atd.data_descarregamento as data_Desc

        from atdatividade atd 
        inner join inpinspetor as inp on atd.pinpinspetor = inp.bold_id
                where 
                cast(atd.data_descarregamento as date) = CURRENT_DATE
                        group by
                        nome, 
                        cod,        
                        data_Desc


//-----------------------------------------------------------


select
    mdl.nome_modulo as Sub_Bloco,
    dmt.cod_dm as Modulo,
    dfb.cod_df as DF,
    dfb.romaneio as SMP,
    dfb.tipo_estrutura as Fabricante, 
    cmp.cod_componente,
    cmp.componente as Componente,
        case
        when cmp.tipo_componente = 0 then 'PERFIL'
        when cmp.tipo_componente = 1 then 'TUBO'
        when cmp.tipo_componente = 2 then 'CONE'
        when cmp.tipo_componente = 3 then 'CHAPA TRAP'
        when cmp.tipo_componente = 4 then 'CHAPA'
        when cmp.tipo_componente = 5 then 'ANEL'
        when cmp.tipo_componente = 6 then 'BARRA'
        when cmp.tipo_componente = 7 then 'CAP'
        when cmp.tipo_componente = 8 then 'FLANGE'
        when cmp.tipo_componente = 9 then 'CURVA'
        else ''
    end as Tipo,

    dfb.desenhobr as Desenho,
    cmp.Peso,
    pct.cod_pc as Plano_de_Corte,

    case 
        when mpr.cod_mp is null then 'Pendente' else 'Aprov' 
    end as Status_Corte, 

    case 
        when cmp.datacorte='1899.12.30' then ' ' else 
                cast(substring (cmp.datacorte from 9 for 2 )as varchar(2)) 
        ||'/'|| cast(substring (cmp.datacorte from 6 for 2 )as varchar(2))
        ||'/'|| cast(substring (cmp.datacorte from 1 for 4 )as varchar(4))


    end as Data_Corte,

    mpr.cod_mp as Material,
    cmp.Status_Comp as Status_Componentes

        from  cmpcomponente cmp
        left join pctplano_corte pct on pct.bold_id = cmp.ppctpcorte
        left join dfbdesenhofabricacao dfb on dfb.bold_id = cmp.pdfbdf
        left join crtcorte crt on crt.ppctplanocorte = pct.bold_id
        left join mprmateriaprima mpr on mpr.bold_id = crt.pmprmateriaprima
        left join dmtdesenhomontagem dmt on dmt.bold_id = dfb.pdmtdm
        left join mdlmodulo mdl on mdl.bold_id = dmt.pmdlmodulo

where dmt.cod_dm is not null         
order by 1,2,3,6


SELECT 
        pct.cod_pc as Plano_Corte,
        pct.datacorte,
        crt.codensaio

FROM 
        pctplano_corte pct left join crtcorte crt on (pct.bold_id = crt.PPCTPLANOCORTE)
where 
        pct.cod_pc='M0008A01'or
        pct.cod_pc='M0025A03'or
        pct.cod_pc='M0025E01'or
        pct.cod_pc='M12B10A03'or
        pct.cod_pc='M12B10A04'or
        pct.cod_pc='M12B10A07'or
        pct.cod_pc='M12C09A04'or
        pct.cod_pc='M12C09A05'or
        pct.cod_pc='M1406A02'or
        pct.cod_pc='M1410A02'


------------------------------------------------------

SELECT 
        AREA,
        SINETE, 
        NOME,
        DTENTRADA,
        DTAFASTAMENTO,
        DTSAIDA
FROM 
     SOLSOLDADOR

WHERE AREA='JURONG' AND SINETE LIKE 'EJA%'

ORDER BY AREA,SINETE


------------------------------------------------------------

SELECT  W.SINETE,
        W.PROCESSO_SOLDAGEM,
        W.COUNT(JUNTA) AS QTD_AS
FROM VW_SOLDA

GROUP BY W.SINETE,W.PROCESSO_SOLDAGEM
ORDER BY W.SINETE

SELECT eja

-----------------------------------------
18/05/2021
-----------------------------------------
-- PENDENCIA DE PINTURA NA MONTAGEM - SQL 1

select
dfb.romaneio as SMP,
dmt.cod_dm as DM,
dfb.cod_df as DF,
dfb.statusDI_MNT as DI_MNT,
dfb.statusPI_MNT as PINT_MNT,
STATUS_DF_MNT

from dfbdesenhofabricacao dfb
join dmtdesenhomontagem dmt on dmt.bold_id = dfb.pdmtdm
join cnpcodicaopintura cnp on cnp.bold_id = dfb.pcnpcodpin
where
 dfb.STATUSPI_MNT  <> 'AP' AND dfb.STATUSPI_MNT  <> 'NA' AND dfb.TIPO_ESTRUTURA = 'JURONG'

ORDER BY 1,2,3

--------------------------------------------
-- PENDENCIA DE PINTURA NA MONTAGEM - SQL 2

SELECT
mdl.NOME_MODULO,
dfb.cod_df,
dfb.STATUSPI,
dfb.statuspi_mnt,
atd.TIPO_ATD 

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID 
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO
INNER JOIN ATDATIVIDADE atd ON atd.PDFBDF = dfb.BOLD_ID 

WHERE dfb.TIPO_ESTRUTURA = 'JURONG' AND dfb.STATUSPI_MNT = ' 'AND atd.TIPO_ATD = 'MNT'

-----------------------------------------
19/05/2021
-----------------------------------------
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


--------------------------------
-- MATERIA PRIMA

select
    mdl.nome_modulo as Modulo,
    dmt.cod_dm as DM,
    dfb.cod_df as DF,
    cmp.cod_componente,
    pct.cod_pc as Plano_de_Corte,
    mpr.cod_mp as Materia_Prima,
    mpr.certificado

        from  cmpcomponente cmp
        left join pctplano_corte pct on pct.bold_id = cmp.ppctpcorte
        left join dfbdesenhofabricacao dfb on dfb.bold_id = cmp.pdfbdf
        left join crtcorte crt on crt.ppctplanocorte = pct.bold_id
        left join mprmateriaprima mpr on mpr.bold_id = crt.pmprmateriaprima
        left join dmtdesenhomontagem dmt on dmt.bold_id = dfb.pdmtdm
        left join mdlmodulo mdl on mdl.bold_id = dmt.pmdlmodulo
        
where  dfb.cod_df is not null   
order by 1,2,3,6


-----------------------------------------
20/05/2021
-----------------------------------------

--SITUAÇÃO DE JUNTAS DF
SELECT 
CASE 
  WHEN 
     PECA_1 IS NULL 
     THEN SUB_MONTAGEM 
      ELSE PECA_1 END AS DF,
COUNT(COD_JUNTA) AS TOTAL,

CASE
  WHEN 
     STATUS_JUNTA LIKE 'Finaliz%'
     THEN 'Finalized'
      ELSE 'Junta Pendente' END AS Status

FROM VW_JUNTAINSPECIONADA
WHERE COD_JUNTA NOT LIKE '#%'

GROUP BY DF,Status

-----------------------------------------
23/05/2021
-----------------------------------------

-- RESUMO DIMENSIONAL-FAB
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi <>'AP'

GROUP BY mdl.NOME_MODULO,dfb.TIPO_ESTRUTURA

----------------------------------------------------------

--RESUMO DIMENSIONAL-MON 
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi_MNT <>'AP'

GROUP BY mdl.NOME_MODULO

----------------------------------------------------------

-- RESUMO PINTURA-FAB
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG' AND dfb.STATUSPI <>'AP'

GROUP BY mdl.NOME_MODULO


----------------------------------------------------------

-- RESUMO PINTURA-MNT
SELECT
mdl.NOME_MODULO,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG' AND dfb.STATUSPI_MNT <>'AP'

GROUP BY mdl.NOME_MODULO

----------------------------------------------------------


--RESUMO DE PENDENCIAS( EXCETO SMP )
SELECT
SUB_BLOCO,
painel,
COUNT(COD_JUNTA) AS QTD_PENDENTE

FROM VW_JUNTAINSPECIONADA

WHERE COD_JUNTA NOT LIKE '#%' AND COD_JUNTA NOT LIKE '%SMP%' AND STATUS_JUNTA NOT LIKE 'Finaliz%'

GROUP BY painel,SUB_BLOCO

----------------------------------------
24/06/2022
----------------------------------------
--DF- COM PENDENCIA
SELECT 
CASE 
  WHEN 
     PECA_1 IS NULL 
     THEN SUB_MONTAGEM 
      ELSE PECA_1 END AS DF,
COUNT(COD_JUNTA) AS QTD_JUNTA,
'Com Pendencia'

FROM VW_JUNTAINSPECIONADA
WHERE COD_JUNTA NOT LIKE '#%' AND STATUS_JUNTA NOT LIKE 'Finaliz%'

GROUP BY DF
ORDER BY 1


-------------------------------
--DF- TODAL DE JUNTAS
SELECT 
CASE 
  WHEN 
     PECA_1 IS NULL 
     THEN SUB_MONTAGEM 
      ELSE PECA_1 END AS DF,
COUNT(COD_JUNTA) AS QTD_JUNTAS

FROM VW_JUNTAINSPECIONADA
WHERE COD_JUNTA NOT LIKE '#%' 

GROUP BY DF
ORDER BY 1

--------------------------------------------
26/05/2022
--------------------------------------------
-- DI-FAB
SELECT
mdl.NOME_MODULO AS MODULO,
DFB.ROMANEIO AS SMP,
DMT.COD_DM AS DM,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi <>'AP'

GROUP BY mdl.NOME_MODULO,dfb.TIPO_ESTRUTURA,ROMANEIO,DMT.COD_DM

------------------------------------------------
--DI-MONT
SELECT
mdl.NOME_MODULO,
DFB.ROMANEIO AS SMP,
COUNT(dfb.cod_df) AS QTD

FROM DFBDESENHOFABRICACAO dfb 
INNER JOIN DMTDESENHOMONTAGEM dmt ON dfb.PDMTDM  = dmt.BOLD_ID
INNER JOIN MDLMODULO mdl ON mdl.BOLD_ID  = dmt.PMDLMODULO

WHERE dfb.TIPO_ESTRUTURA = 'JURONG'  AND dfb.statusdi_MNT <>'AP'

GROUP BY mdl.NOME_MODULO,dfb.TIPO_ESTRUTURA,ROMANEIO