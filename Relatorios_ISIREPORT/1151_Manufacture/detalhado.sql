--1151 detalhado rev2
select 
          dados.tipo_estrutura
        , dados.nome_modulo
        , dados.cod_dm
        , dados.cod_df
        , dados.jnt_qtd
        , dados.peso_total

        , dados.corte_programado
        , dados.peso_corte
        , case when dados.perc_corte < case when dados.jnt_qtd = 0 then dados.perc_corte else dados.perc_va end then
        case when dados.jnt_qtd = 0 then dados.perc_corte else dados.perc_va end else dados.perc_corte end as perc_corte
        --, dados.perc_corte
        , dados.corte_realizado

        , dados.ajuste_programado
        , case when dados.jnt_qtd = 0 then dados.peso_corte else dados.peso_va end as peso_va
		, case when dados.jnt_qtd = 0 then dados.perc_corte else dados.perc_va end as perc_va
		, dados.ajuste_realizado

		, dados.solda_programada
		, case when dados.jnt_qtd = 0 then dados.peso_corte else dados.peso_rs end as peso_rs
		, case when dados.jnt_qtd = 0 then dados.perc_corte else dados.perc_rs end as perc_rs
		, dados.solda_realizada

		, case when dados.jnt_qtd = 0 then dados.peso_corte else dados.peso_ndt end as peso_ndt
		, case when dados.jnt_qtd = 0 then dados.perc_corte else dados.per_ndt end as perc_ndt

		, dados.dimensional


from
(select
        dfb.tipo_estrutura
        , mdl.nome_modulo
        , dmt.cod_dm
        , dfb.cod_df
        , coalesce(av.jnt_qtd, 0) as jnt_qtd
        , dfb.peso_total

        , substring(dfb.no1 from 1 for 3) as corte_programado
        , cmps.cmp_peso_cortado as peso_corte
        , decode(cmps.cmp_peso, 0, 0, (cmps.cmp_peso_cortado / cmps.cmp_peso)) as perc_corte
        , substring(dfb.no1 from 4 for 3) as corte_realizado

        , substring(dfb.no1 from 7 for 3) as ajuste_programado
        , case when av.jnt_qtd > 0 then (av.va_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else 0 end as peso_va
		, case when av.VA_JNT_QTD > 0 then (av.va_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as perc_va
		, substring(dfb.no1 from 10 for 3) as ajuste_realizado

		, substring(dfb.no1 from 13 for 3) as solda_programada
	    , case when av.jnt_qtd > 0 then (av.rs_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else 0 end as peso_rs
		, case when av.rs_JNT_QTD > 0 then (av.rs_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as perc_rs
		, substring(dfb.no1 from 16 for 3) as solda_realizada

		

		, case when av.jnt_qtd > 0 then (av.lib_jnt_qtd * dfb.peso_total / av.jnt_qtd ) else 0 end as peso_ndt
		, case when av.lib_jnt_qtd > 0 then (av.lib_jnt_qtd * dfb.peso_total / av.jnt_qtd ) / dfb.peso_total  else 0 end  as per_ndt
		, case when (dfb.statusdi = 'AP') or (dfb.statusdi = 'NA') then 'OK' else 'NOK' end as dimensional

    from
        dfbdesenhofabricacao dfb
        inner join dmtdesenhomontagem dmt on dfb.pdmtdm = dmt.bold_id
        inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id
        left join gat_avancodf_fab av on dfb.bold_id = av.pdfbdf
        left join gat_avancocmp cmps on dfb.bold_id = cmps.pdfbdf
where dfb.tipo_estrutura = @SITE 
--and dfb.cod_df ='LDSF-F239HA' 
) dados 



--LDSF-F239HA

--PU1-F59HK

// --------------------------------------------------------

14/01/2021


LISTA DE JUNTA REPORVADA

SELECT 
JNT.COD_JUNTA  AS JOINT,
SUBSTRING(TRE.SOLDADORES FROM 6 FOR 8) AS WELDER_ID_SIGNET,
SUBSTRING(TRE.SOLDADORES FROM 1 FOR 4) AS WELD_PROC,
'Ultrasonic Testing' AS INSPECTION,
'IE - Note 1' AS DEFECT_TYPE,
DFT.FILMESREPROVADOS AS QTY_FILM,
DFT.FILMESREPROVADOS AS REPROVED_FILM,
'VERIFICAR LISTA' AS INSPECTED_LENGTH,
'VERIFICAR PIOL' AS DEFECT_LOCAL,
DFT.EXTENSAODEF AS DEFECT_LENGTH,DFT.DATA,
DFT.ESPESSURA AS ESPESSURA_JUNTA,
JNI.TIPO_JUNTA,
DFT.TIPO_DEFEITO,
DFT.PROF AS PROF_DEFEITO,
JNI.ESPESSURA1,
JNI.ESPESSURA2


      FROM TRETRECHO TRE 
      INNER JOIN JNTJUNTA JNT ON TRE.PJNTJUNTA = JNT.BOLD_ID
      INNER JOIN VW_DEFEITOS DFT ON DFT.COD_TRECHO = TRE.COD_TRECHO 
      INNER JOIN VW_JUNTAINSPECIONADA JNI ON JNI.COD_JUNTA = JNT.COD_JUNTA 

           WHERE DFT.DATA>= '2022-01-01' 
                 ORDER BY 2


