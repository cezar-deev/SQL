select
    aa.PLATFORM,
    aa.MANUFACTURER,
    aa.MODULE,
    aa.SUB_BLOCK,
    aa.PIECE,
    aa.JOINT_CODE,
    aa.WELDING_MAP,
    aa.EXECUTION,
    aa.IFC_DRAWING,
    aa.IFC_REVIEW,
    aa.COMPONENT_1,
    aa.COMPONENT_2,
    aa.MATERIAL_TYPE_1,
    aa.NESTING_PLAN_1,
    aa.PRODUCT_NO_1,
    aa.MATERIAL_HEAT_NO_1,
    aa.CERTIFICATE_NO_1,
    aa.RIR_1,
    aa.RIR_DATE_1,
    aa.COATING_REPORT_1,
    aa.RIP_1_DATE,
    aa.MATERIAL_TYPE_2,
    aa.NESTING_PLAN_2,
    aa.PRODUCT_NO_2,
    aa.MATERIAL_HEAT_NO_2,
    aa.CERTIFICATE_NO_2,
    aa.RIR_2,
    aa.RIR_2_DATE,
    aa.COATING_REPORT_2,
    aa.RIP_2_DATE,
    aa.INSPECTION_CATEGORY,
    aa.JOINT_TYPE,
    aa.LENGHT,
    aa.THICKNESS_1,
    aa.THICKNESS_2,
    aa.FT,
    aa.RI_VA, 
    aa.DATE_FT,
    aa.FT_STATUS,
    aa.WE,
    --aa.RI_RS, 
    aa.DATE_WE,
    aa.WE_STATUS,
    aa.WELDER_NUMBER,
    aa.IEIS,
    aa.CONSUMABLE,
    aa.VT,
    aa.RI_VS, 
    aa.DATE_VT,
    aa.VT_STATUS,
    aa.PL,
    --aa.RI_LP,
    aa.DATE_PL,
    aa.PL_STATUS,
    aa.LENGTH_PL,
    aa.PL_PERCENT,
    aa.MT,
    aa.RI_PM, 
    aa.DATE_MT, 
    aa.MT_STATUS, 
    aa.LENGTH_MT,
    aa.MT_PERCENT, 
    aa.RT,
    --aa.RI_RX, 
    aa.DATE_RT,
    aa.RT_STATUS,
    aa.LENGTH_RT,
    aa.RT_PERCENT,
    aa.UT,
    aa.RI_US, 
    aa.DATE_UT,
    aa.UT_STATUS, 
    aa.LENGTH_UT, 
    aa.UT_PERCENT,
    aa.DI, 
    aa.DI_STATUS,
    list(all aa.TOUCH_UP) as TOUCH_UP,
    list(all aa.PI) as pi,
    aa.pi_status, 
    aa.STATUS_JUNTA
    from (
        select
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VA'
        group by JNT1.BOLD_ID) as RI_VA,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from SLDSOLDA ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_SOLDA FROM 1 FOR 2) = 'RS'
        group by JNT1.BOLD_ID) as RI_RS,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VS'
        group by JNT1.BOLD_ID) as RI_VS,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP'
        group by JNT1.BOLD_ID) as RI_LP,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 1
              and TRE.TIPO_ENS = 4
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM'
        group by JNT1.BOLD_ID) as RI_PM,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 1
              and TRE.TIPO_ENS = 6
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX'
        group by JNT1.BOLD_ID) as RI_RX,
        ------------------------------------------------
        (select max(ENS.relatorioindividual)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 1
              and TRE.TIPO_ENS = 5
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US'
        group by JNT1.BOLD_ID) as RI_US,


       (SELECT SUBSTRING(NOME_CONTRATO FROM 8 FOR 4) AS CONTRATO FROM VW_CONTRATO) as PLATFORM,
       (SELECT SUBSTRING(NOME_CONTRATO FROM 8 FOR 4) AS CONTRATO FROM VW_CONTRATO) ||'-'|| DFB.TIPO_ESTRUTURA as MANUFACTURER,
       case when MDL.NOME_MODULO is null then MDL1.NOME_MODULO else MDL.NOME_MODULO end as MODULE,
       case when DMT.COD_DM is null then DMT1.COD_DM else DMT.COD_DM end as SUB_BLOCK,
       case when DFB.COD_DF is null then MPR.COD_MP when MPR.COD_MP is null then DFB.COD_DF else '' end as PIECE,
       JNT.COD_JUNTA as JOINT_CODE,
       JNT.DESENHOPETROBRAS as WELDING_MAP,
       case when JNT.EXECUCAO = 0 then 'OFC'
            when JNT.EXECUCAO = 1 then 'MNT'
            when JNT.EXECUCAO = 2 then 'PMN'
            when JNT.EXECUCAO = 3 then 'EDF'
       end AS EXECUTION,
       DFB.DESENHOBR as IFC_DRAWING,
       DFB.FOLHA as IFC_REVIEW,
       case when CMP1.COD_COMPONENTE is null then DFB1.COD_DF else CMP1.COD_COMPONENTE end as COMPONENT_1,
       case when CMP2.COD_COMPONENTE is null then DFB2.COD_DF else CMP2.COD_COMPONENTE end as COMPONENT_2,
       -------------------------------
       MAT1.CODIGO_MB as MATERIAL_TYPE_1,
       PCT1.COD_PC as NESTING_PLAN_1,
       mpr3.COD_MP as PRODUCT_NO_1,
       chp3.CORRIDA as MATERIAL_HEAT_NO_1,
       MPR3.CERTIFICADO as CERTIFICATE_NO_1,
       CHP3.OBSERVACAO as RIR_1,
       cast(cast(MPR3.DATARECEBIMENTO as date) as varchar(10)) as RIR_DATE_1,
       CHP3.RELENSAIO as COATING_REPORT_1,
       cast(cast(case when CHP3.IDDATA like '%1899%' then null else CHP3.IDDATA end as date) as varchar(10)) as RIP_1_DATE,
       MAT2.CODIGO_MB as MATERIAL_TYPE_2,
       PCT2.COD_PC as NESTING_PLAN_2,
       MPR4.COD_MP as PRODUCT_NO_2,
       CHP4.CORRIDA as MATERIAL_HEAT_NO_2,
       MPR4.CERTIFICADO as CERTIFICATE_NO_2,
       CHP4.OBSERVACAO as RIR_2,
       cast(cast(MPR4.DATARECEBIMENTO as date) as varchar(10)) as RIR_2_DATE,
       CHP4.RELENSAIO as COATING_REPORT_2,
       cast(cast(case when CHP4.IDDATA like '%1899%' then null else CHP4.IDDATA end as date) as varchar(10)) as RIP_2_DATE,
       JNT.NIVEL_INSPECAO as INSPECTION_CATEGORY,
       case when JNT.TIPO_JUNTA = 0 then 'FPBW'
            when JNT.TIPO_JUNTA = 1 then 'FPAN'
            when JNT.TIPO_JUNTA = 2 then 'FWAN'
            when JNT.TIPO_JUNTA = 4 then 'PPAN'
            when JNT.TIPO_JUNTA = 5 then 'PPBW'
            else ''
       end as JOINT_TYPE,
       JNT.EXTENSAO as LENGHT,
       JNT.ESPESSURA1 as THICKNESS_1,
       JNT.ESPESSURA2 as THICKNESS_2,
       (select max(ENS.COD_ENSAIO)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VA'
        group by JNT1.BOLD_ID) as FT,
       cast(cast((select max(ENS.DATA)
                  from ENSENSAIO ENS
                  join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                  join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                  where JNT1.BOLD_ID = JNT.BOLD_ID
                        and TRE.CLASSIFICACAO = 0
                        and TRE.TIPO_ENS = 0
                        and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VA'
                  group by JNT1.BOLD_ID) as date) as varchar(10)) as DATE_FT,
       JNT.STATUSVA as FT_STATUS,
       (select max(ENS.COD_SOLDA)
        from SLDSOLDA ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_SOLDA FROM 1 FOR 2) = 'RS'
        group by JNT1.BOLD_ID) as WE,
       cast(cast((select max(ENS.OBSLDAZDATA)
                  from SLDSOLDA ENS
                  join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                  join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                  where JNT1.BOLD_ID = JNT.BOLD_ID
                        and TRE.CLASSIFICACAO = 0
                        and TRE.TIPO_ENS = 0
                        and SUBSTRING(ENS.COD_SOLDA FROM 1 FOR 2) = 'RS'
                  group by JNT1.BOLD_ID) as date) as varchar(10)) as DATE_WE,
       JNT.STATUSRS as WE_STATUS,
       (select max(TRE.SOLDADORES)
        from TRETRECHO TRE
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
        group by JNT1.BOLD_ID) as WELDER_NUMBER, ------------------------------------------
       TB.IEIS,
       TB.CONSUMIVEL as CONSUMABLE,
       (select max(ENS.COD_ENSAIO)
        from ENSENSAIO ENS
        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
        where JNT1.BOLD_ID = JNT.BOLD_ID
              and TRE.CLASSIFICACAO = 0
              and TRE.TIPO_ENS = 0
              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VS'
        group by JNT1.BOLD_ID) as VT,
       cast(cast((select max(ENS.DATA)
                  from ENSENSAIO ENS
                  join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                  join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                  where JNT1.BOLD_ID = JNT.BOLD_ID
                        and TRE.CLASSIFICACAO = 0
                        and TRE.TIPO_ENS = 0
                        and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'VS'
                  group by JNT1.BOLD_ID) as date) as varchar(10)) as DATE_VT,
       JNT.STATUSVS as VT_STATUS,

       case
         when JNT.STATUSLP = 'AP' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and TRE.CLASSIFICACAO = 1
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP'
              group by JNT1.BOLD_ID)
         when JNT.STATUSLP = 'AL' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
              join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 4
              join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
              join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSLP = 'AP'
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
              where TRE.CLASSIFICACAO = 1
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP')
         else ''
       end as PL,
       case
         when JNT.STATUSLP = 'AP' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                        where JNT1.BOLD_ID = JNT.BOLD_ID
                              and TRE.CLASSIFICACAO = 1
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP'
                        group by JNT1.BOLD_ID) as date) as varchar(10))
         when JNT.STATUSLP = 'AL' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
                        join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 4
                        join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
                        join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSLP = 'AP'
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
                        where TRE.CLASSIFICACAO = 1
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP') as date) as varchar(10))
         else ''
       end as DATE_PL,
       JNT.STATUSLP as PL_STATUS,
       cast(
       case
         when JNT.STATUSLP = 'AP' then
             (select max(
                     case
                       when (ENT.TRECHO_INICIO > ENT.TRECHO_FIM) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO) + ENT.TRECHO_FIM)
                       else ENT.TRECHO_FIM - ENT.TRECHO_INICIO
                     end)
              from ENSENSAIO ENS
              join ENTENS_LP ENT on ENS.BOLD_ID = ENT.BOLD_ID
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'LP'
              group by JNT1.BOLD_ID)
         else 0
       end as float) as LENGTH_PL,

       CLS.ENSAIOLP as PL_PERCENT,

       case
         when JNT.STATUSPM = 'AP' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and TRE.CLASSIFICACAO = 1
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM'
              group by JNT1.BOLD_ID)
         when JNT.STATUSPM = 'AL' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
              join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 4
              join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
              join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSPM = 'AP'
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
              where TRE.CLASSIFICACAO = 1
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM')
         else ''
       end as MT,
       case
         when JNT.STATUSPM = 'AP' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                        where JNT1.BOLD_ID = JNT.BOLD_ID
                              and TRE.CLASSIFICACAO = 1
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM'
                        group by JNT1.BOLD_ID) as date) as varchar(10))
         when JNT.STATUSPM = 'AL' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
                        join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 4
                        join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
                        join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSPM = 'AP'
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
                        where TRE.CLASSIFICACAO = 1
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM') as date) as varchar(10))
         else ''
       end as DATE_MT,
       JNT.STATUSPM as MT_STATUS,

       cast(
       case
         when JNT.STATUSPM = 'AP' then
             (select max(
                     case
                       when (ENT.TRECHO_INICIO > ENT.TRECHO_FIM) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO) + ENT.TRECHO_FIM)
                       else ENT.TRECHO_FIM - ENT.TRECHO_INICIO
                     end)
              from ENSENSAIO ENS
              join ENTENS_PM ENT on ENS.BOLD_ID = ENT.BOLD_ID
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'PM'
              group by JNT1.BOLD_ID)
         else 0
       end as float) as LENGTH_MT,

       CLS.ENSAIOPM as MT_PERCENT,

       case
         when JNT.STATUSRX = 'AP' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX'
              group by JNT1.BOLD_ID)
         when JNT.STATUSRX = 'AL' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
              join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 6
              join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
              join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSRX = 'AP'
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
              where (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX')
         else ''
       end as RT,
       case
         when JNT.STATUSRX = 'AP' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                        where JNT1.BOLD_ID = JNT.BOLD_ID
                              and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                              and ENS.LAUDO = 1))
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX'
                        group by JNT1.BOLD_ID) as date) as varchar(10))
         when JNT.STATUSRX = 'AL' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
                        join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 6
                        join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
                        join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSRX = 'AP'
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
                        where (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                              and ENS.LAUDO = 1))
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX') as date) as varchar(10))
         else ''
       end as DATE_RT,
       JNT.STATUSRX as RT_STATUS,

       cast(
       case
         when JNT.STATUSRX = 'AP' then
             (select max(
                     case
                       when (ENT.TRECHO_INICIO > ENT.TRECHO_FIM) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO) + ENT.TRECHO_FIM)
                       else ENT.TRECHO_FIM - ENT.TRECHO_INICIO
                     end +
                     case
                       when (ENT.TRECHO_INICIO2 > ENT.TRECHO_FIM2) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO2) + ENT.TRECHO_FIM2)
                       else ENT.TRECHO_FIM2 - ENT.TRECHO_INICIO2
                     end)
              from ENSENSAIO ENS
              join ENTENS_RX ENT on ENS.BOLD_ID = ENT.BOLD_ID
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'RX'
              group by JNT1.BOLD_ID)
         else 0
       end as float) as LENGTH_RT,
       CLS.ENSAIOER as RT_PERCENT,
       case
         when JNT.STATUSUS = 'AP' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US'
              group by JNT1.BOLD_ID)
         when JNT.STATUSUS = 'AL' then
             (select max(ENS.COD_ENSAIO)
              from ENSENSAIO ENS
              join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
              join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 5
              join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
              join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSUS = 'AP'
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
              where (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US')
         else ''
       end as UT,

       case
         when JNT.STATUSUS = 'AP' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
                        join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
                        where JNT1.BOLD_ID = JNT.BOLD_ID
                              and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                              and ENS.LAUDO = 1))
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US'
                        group by JNT1.BOLD_ID) as date) as varchar(10))
         when JNT.STATUSUS = 'AL' then
             cast(cast((select max(ENS.DATA)
                        from ENSENSAIO ENS
                        join ASSJNTLTJ ASS on ASS.FJNTJUNTA = JNT.BOLD_ID
                        join LTJLOTE_JUNTA LTJ on LTJ.BOLD_ID = ASS.FLTJLOTE_JUNTA and LTJ.TIPO_ENSAIO = 5
                        join ASSJNTLTJ ASS2 on ASS2.FLTJLOTE_JUNTA = LTJ.BOLD_ID
                        join JNTJUNTA JNT2 on ASS2.FJNTJUNTA = JNT2.BOLD_ID and JNT2.STATUSUS = 'AP'
                        join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO and TRE.PJNTJUNTA = JNT2.BOLD_ID
                        where (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                              and ENS.LAUDO = 1))
                              and TRE.ANTESTT = 0
                              and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US') as date) as varchar(10))
         else ''
       end as DATE_UT,
       JNT.STATUSUS as UT_STATUS,

       cast(
       case
         when JNT.STATUSUS = 'AP' then
             (select max(
                     case
                       when (ENT.TRECHO_INICIO > ENT.TRECHO_FIM) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO) + ENT.TRECHO_FIM)
                       else ENT.TRECHO_FIM - ENT.TRECHO_INICIO
                     end +
                     case
                       when (ENT.TRECHO_INICIO2 > ENT.TRECHO_FIM2) then
                           ((JNT.EXTENSAO - ENT.TRECHO_INICIO2) + ENT.TRECHO_FIM2)
                       else ENT.TRECHO_FIM2 - ENT.TRECHO_INICIO2
                     end)
              from ENSENSAIO ENS
              join ENTENS_US ENT on ENS.BOLD_ID = ENT.BOLD_ID
              join TRETRECHO TRE on TRE.BOLD_ID = ENS.PTRETRECHO
              join JNTJUNTA JNT1 on JNT1.BOLD_ID = TRE.PJNTJUNTA
              where JNT1.BOLD_ID = JNT.BOLD_ID
                    and (TRE.CLASSIFICACAO = 1 or (TRE.CLASSIFICACAO = 4
                    and ENS.LAUDO = 1))
                    and TRE.ANTESTT = 0
                    and SUBSTRING(ENS.COD_ENSAIO FROM 1 FOR 2) = 'US'
              group by JNT1.BOLD_ID)
         else 0
       end as float) as LENGTH_UT,

       CLS.ENSAIOUS as UT_PERCENT,

       substring(ATDDI.ENSAIO from 1 for 9) as DI,
       DFB.STATUSDI as DI_STATUS,
       ATDPI.REL_INDIVIDUAL as TOUCH_UP,
       substring(ATDPI.ENSAIO from 1 for 9) as pi,
       DFB.STATUSPI as PI_STATUS,
       JNT.STATUS_JUNTA

from
JNTJUNTA JNT
left join JUTJUNTA_DF JUTF on JUTF.BOLD_ID = JNT.BOLD_ID
left join JUTJUNTA_MP JUTM on JUTM.BOLD_ID = JNT.BOLD_ID
left join JUTJUNTA_DM JUTD on JUTD.BOLD_ID = JNT.BOLD_ID
left join CLSCLASSE CLS on CLS.BOLD_ID = JNT.PCLSCLASSE
left join CMPCOMPONENTE CMP1 on (CMP1.BOLD_ID = JUTF.PCMPCOMP1 or CMP1.BOLD_ID = JUTM.PCMPCOMP1)
left join CMPCOMPONENTE CMP2 on (CMP2.BOLD_ID = JUTF.PCMPCOMP2 or CMP2.BOLD_ID = JUTM.PCMPCOMP2)
left join MATMATERIAL MAT1 on MAT1.BOLD_ID = CMP1.PMATMBASE
left join MATMATERIAL MAT2 on MAT2.BOLD_ID = CMP2.PMATMBASE
left join PCTPLANO_CORTE PCT1 on PCT1.BOLD_ID = CMP1.PPCTPCORTE
left join PCTPLANO_CORTE PCT2 on PCT2.BOLD_ID = CMP2.PPCTPCORTE
left join MPRMATERIAPRIMA MPR on MPR.BOLD_ID = JUTM.PMPRMATPRI
left join MPRMATERIAPRIMA MPR1 on MPR1.BOLD_ID = PCT1.PMPRMATPRI
left join CHPCHAPAS CHP1 on CHP1.BOLD_ID = MPR1.BOLD_ID
left join MPRMATERIAPRIMA MPR2 on MPR2.BOLD_ID = PCT2.PMPRMATPRI
left join CHPCHAPAS CHP2 on CHP2.BOLD_ID = MPR2.BOLD_ID
left join crtcorte crt1 on (pct1.pcrtcorte = crt1.bold_id)
left join mprmateriaprima mpr3 on (crt1.pmprmateriaprima = mpr3.bold_id)
left join CHPCHAPAS CHP3 on CHP3.BOLD_ID = MPR3.BOLD_ID
left join tpftuboperfil tpf1 on (mpr3.bold_id = tpf1.bold_id)
left join crtcorte crt2 on (pct2.pcrtcorte = crt2.bold_id)
left join mprmateriaprima mpr4 on (crt2.pmprmateriaprima = mpr4.bold_id)
left join CHPCHAPAS CHP4 on CHP4.BOLD_ID = MPR4.BOLD_ID
left join tpftuboperfil tpf2 on (mpr4.bold_id = tpf2.bold_id)
left join DFBDESENHOFABRICACAO DFB on DFB.BOLD_ID = JUTF.PDFBDF
left join DFBDESENHOFABRICACAO DFB1 on DFB1.BOLD_ID = JUTD.PDFBDF1
left join DFBDESENHOFABRICACAO DFB2 on DFB2.BOLD_ID = JUTD.PDFBDF2
left join DMTDESENHOMONTAGEM DMT1 on DMT1.BOLD_ID = DFB.PDMTDM
left join DMTDESENHOMONTAGEM DMT on DMT.BOLD_ID = JUTD.PDMTDM
left join MDLMODULO MDL on MDL.BOLD_ID = DMT.PMDLMODULO
left join MDLMODULO MDL1 on MDL1.BOLD_ID = DMT1.PMDLMODULO
left join(  select distinct 
            JNTE.BOLD_ID,
            list(distinct IES.COD_IEIS) as IEIS,
            list(distinct CSM.COD_CONSUMIVEL) as CONSUMIVEL
            from JNTJUNTA JNTE
            join TRETRECHO TRE on TRE.PJNTJUNTA = JNTE.BOLD_ID
            join SLDSOLDA SLD on SLD.PTRETRECHO = TRE.BOLD_ID
            join SSLSOLDADORSLD SSL on SSL.PSLDSOLDA = SLD.BOLD_ID
            join IESIEIS IES on SSL.PIESIEIS = IES.BOLD_ID
            join CSMCONSUMIVEL CSM on SSL.PCSMCONSUMIVEL = CSM.BOLD_ID
            group by JNTE.BOLD_ID) TB on TB.BOLD_ID = JNT.BOLD_ID
            left join(  select 
                        ATD.PDFBDF,
                        max(ATD.COD_ENSAIO) as ENSAIO
                        from ATDATIVIDADE ATD
                        join ATTDI ADI on ADI.BOLD_ID = ATD.BOLD_ID
                        where ATD.PDFBDF <> -1
                        group by 1) ATDDI on DFB.BOLD_ID = ATDDI.PDFBDF
                        left join(  select 
                                    ATD.PDFBDF,
                                    ATT.RIF1D as REL_INDIVIDUAL,
                                    max(ATD.COD_ENSAIO) as ENSAIO
                                    from ATDATIVIDADE ATD
                                    join ATTPI ATT on ATD.BOLD_ID = ATT.BOLD_ID
                                    where ATD.PDFBDF <> -1
                                    group by 1, 2) ATDPI on DFB.BOLD_ID = ATDPI.PDFBDF

where jnt.cod_junta not like '%#%' and SUBSTRING(jnt.cod_junta FROM 1 FOR 1) <> '%#%') aa
--where jnt.cod_junta not like '%#%' and DFB.TIPO_ESTRUTURA not like '%CIMC') aa

--where aa.NESTING_PLAN_1 = 'M12A8A03'
group by

aa.PLATFORM,
aa.MANUFACTURER, 
aa.MODULE, 
aa.SUB_BLOCK, 
aa.PIECE, 
aa.JOINT_CODE, 
aa.WELDING_MAP, 
aa.EXECUTION, 
aa.IFC_DRAWING, 
aa.IFC_REVIEW,
aa.COMPONENT_1, 
aa.COMPONENT_2, 
aa.MATERIAL_TYPE_1, 
aa.NESTING_PLAN_1, 
aa.PRODUCT_NO_1, 
aa.MATERIAL_HEAT_NO_1, 
aa.CERTIFICATE_NO_1, 
aa.RIR_1, aa.RIR_DATE_1,
aa.COATING_REPORT_1, 
aa.RIP_1_DATE, 
aa.MATERIAL_TYPE_2, 
aa.NESTING_PLAN_2, 
aa.PRODUCT_NO_2, 
aa.MATERIAL_HEAT_NO_2, 
aa.CERTIFICATE_NO_2, 
aa.RIR_2, aa.RIR_2_DATE,
aa.COATING_REPORT_2, 
aa.RIP_2_DATE, 
aa.INSPECTION_CATEGORY, 
aa.JOINT_TYPE, 
aa.LENGHT, 
aa.THICKNESS_1, 
aa.THICKNESS_2, 
aa.FT,aa.RI_VA, 
aa.DATE_FT, 
aa.FT_STATUS, aa.WE,
aa.DATE_WE, 
aa.WE_STATUS, 
aa.WELDER_NUMBER, 
aa.IEIS, 
aa.CONSUMABLE, 
aa.VT, aa.RI_VS, 
aa.DATE_VT, 
aa.VT_STATUS, 
aa.PL, 
aa.DATE_PL, 
aa.PL_STATUS, 
aa.LENGTH_PL, 
aa.PL_PERCENT,
aa.MT, 
aa.RI_PM, 
aa.DATE_MT, 
aa.MT_STATUS, 
aa.LENGTH_MT, 
aa.MT_PERCENT, 
aa.RT, 
aa.DATE_RT, 
aa.RT_STATUS, 
aa.LENGTH_RT, 
aa.RT_PERCENT, 
aa.UT, 
aa.RI_US, 
aa.DATE_UT, 
aa.UT_STATUS,
aa.LENGTH_UT, 
aa.UT_PERCENT, 
aa.DI, 
aa.DI_STATUS, 
aa.pi_status, 
aa.STATUS_JUNTA