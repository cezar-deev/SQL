select

(SELECT SUBSTRING(NOME_CONTRATO FROM 8 FOR 4) AS CONTRATO FROM VW_CONTRATO) as projeto
, prj.modulo
, prj.dm, prj.df1
, prj.desenhobr1
, prj.folha1
, prj.df2
, prj.desenhobr2
, prj.folha2
, prj.desenhopetrobras
, prj.execucao
, prj.observacoes
, prj.junta
, prj.nivel_inspecao
, prj.tipo_junta_ingles
, prj.extensao
, prj.espessura1
, prj.espessura2
-- Ensaios
, di.predi_relatorio, di.predi_data
, coalesce(ens.va_3r_relatorio, ens.va_2r_relatorio, ens.va_1r_relatorio, ens.va_solda_relatorio) as va_relatorio
, coalesce(ens.va_3r_data, ens.va_2r_data, ens.va_1r_data, ens.va_solda_data) as va_data
, coalesce(ens.va_3r_status, ens.va_2r_status, ens.va_1r_status, ens.va_solda_status) as va_status
, coalesce(ens.va_3r_ri, ens.va_2r_ri, ens.va_1r_ri, ens.va_solda_ri) as va_ri

, coalesce(sld.rs_3r_relatorio, sld.rs_2r_relatorio, sld.rs_1r_relatorio, sld.rs_solda_relatorio) as rs_relatorio
, coalesce(sld.rs_3r_data, sld.rs_2r_data, sld.rs_1r_data, sld.rs_solda_data) as rs_data
, coalesce(sld.rs_3r_status, sld.rs_2r_status, sld.rs_1r_status, sld.rs_solda_status) as rs_status
--, coalesce(sld.rs_3r_ri, sld.rs_2r_ri, sld.rs_1r_ri, sld.rs_solda_ri) as rs_ri
, coalesce(sld.rs_3r_sinete, sld.rs_2r_sinete, sld.rs_1r_sinete, sld.rs_solda_sinete) as rs_sinete
, coalesce(sld.rs_3r_ieis, sld.rs_2r_ieis, sld.rs_1r_ieis, sld.rs_solda_ieis) as rs_ieis
, coalesce(sld.rs_3r_consumivel, sld.rs_2r_consumivel, sld.rs_1r_consumivel, sld.rs_solda_consumivel) as rs_consumivel

, coalesce(ens.vs_3r_relatorio, ens.vs_2r_relatorio, ens.vs_1r_relatorio, ens.vs_solda_relatorio) as vs_relatorio
, coalesce(ens.vs_3r_data, ens.vs_2r_data, ens.vs_1r_data, ens.vs_solda_data) as vs_data
, coalesce(ens.vs_3r_status, ens.vs_2r_status, ens.vs_1r_status, ens.vs_solda_status) as vs_status
, coalesce(ens.vs_3r_ri, ens.vs_2r_ri, ens.vs_1r_ri, ens.vs_solda_ri) as vs_ri

, coalesce(ens.lp_3r_relatorio, ens.lp_2r_relatorio, ens.lp_1r_relatorio, ens.lp_solda_relatorio) as lp_relatorio
, coalesce(ens.lp_3r_data, ens.lp_2r_data, ens.lp_1r_data, ens.lp_solda_data) as lp_data
, coalesce(ens.lp_3r_status, ens.lp_2r_status, ens.lp_1r_status, ens.lp_solda_status) as lp_status
--, coalesce(ens.lp_3r_ri, ens.lp_2r_ri, ens.lp_1r_ri, ens.lp_solda_ri) as lp_ri
, ext.extinsp_lp
, prj.ensaiolp

, coalesce(ens.pm_3r_relatorio, ens.pm_2r_relatorio, ens.pm_1r_relatorio, ens.pm_solda_relatorio) as pm_relatorio
, coalesce(ens.pm_3r_data, ens.pm_2r_data, ens.pm_1r_data, ens.pm_solda_data) as pm_data
, coalesce(ens.pm_3r_status, ens.pm_2r_status, ens.pm_1r_status, ens.pm_solda_status) as pm_status
, coalesce(ens.pm_3r_ri, ens.pm_2r_ri, ens.pm_1r_ri, ens.pm_solda_ri) as pm_ri
, ext.extinsp_pm
, prj.ensaiopm

, coalesce(ens.rx_3r_relatorio, ens.rx_2r_relatorio, ens.rx_1r_relatorio, ens.rx_solda_relatorio) as rx_relatorio
, coalesce(ens.rx_3r_data, ens.rx_2r_data, ens.rx_1r_data, ens.rx_solda_data) as rx_data
, coalesce(ens.rx_3r_status, ens.rx_2r_status, ens.rx_1r_status, ens.rx_solda_status) as rx_status
--, coalesce(ens.rx_3r_ri, ens.rx_2r_ri, ens.rx_1r_ri, ens.rx_solda_ri) as rx_ri
, ext.extinsp_rx
, prj.ensaioer

, coalesce(ens.us_3r_relatorio, ens.us_2r_relatorio, ens.us_1r_relatorio, ens.us_solda_relatorio) as us_relatorio
, coalesce(ens.us_3r_data, ens.us_2r_data, ens.us_1r_data, ens.us_solda_data) as us_data
, coalesce(ens.us_3r_status, ens.us_2r_status, ens.us_1r_status, ens.us_solda_status) as us_status
, coalesce(ens.us_3r_ri, ens.us_2r_ri, ens.us_1r_ri, ens.us_solda_ri) as us_ri
, ext.extinsp_us
, prj.ensaious

, df.di_mnt_relatorio
, df.di_mnt_status
, prj.di_final

, df.pi_relatorio
, prj.dipi
, df.pi_status
, prj.status_junta
from
    (
select
    jdm.bold_id as pjntjunta    
    , mdl.nome_modulo as modulo 
    , dmt.cod_dm as dm          
    , jnt.cod_junta as junta    
    , dfb1.bold_id as pdfbdf1   
    , dfb1.cod_df as df1 
    , dfb1.campogenericotexto as di_final    
    , dfb2.cod_df as df2        
    , jnt.espessura1            
    , jnt.espessura2             
    , jnt.extensao               
    , decode(jnt.execucao, 0, 'OFC', 1, 'MNT', 2, 'PMN', 3, 'EDF') as execucao   
    , decode(jnt.tipo_junta, 0, 'BUTT', 1, 'T / FP', 2, 'T / FW', 4, 'T / PP', 5, 'T / PP') as tipo_junta_ingles  
    , jnt.nivel_inspecao     
    , jnt.status_junta  
    , cls.ensaiolp  
    , cls.ensaiopm  
    , cls.ensaioer  
    , cls.ensaious  
    , jnt.desenhopetrobras    
    , jnt.observacoes              
    , dfb1.desenhobr as desenhobr1  
    , dfb1.folha as folha1          
    , dfb2.desenhobr as desenhobr2  
    , dfb2.folha as folha2        
    , atd.relatorioindividual dipi    
from
    jutjunta_dm jdm
    inner join jntjunta jnt on jdm.bold_id = jnt.bold_id
    inner join dfbdesenhofabricacao dfb1 on jdm.pdfbdf1 = dfb1.bold_id
    inner join dfbdesenhofabricacao dfb2 on jdm.pdfbdf2 = dfb2.bold_id
    inner join matmaterial mat1 on jnt.pmatmbase1 = mat1.bold_id
    inner join matmaterial mat2 on jnt.pmatmbase2 = mat2.bold_id
    inner join dmtdesenhomontagem dmt on dfb1.pdmtdm = dmt.bold_id
    inner join mdlmodulo mdl on dmt.pmdlmodulo = mdl.bold_id
    inner join clsclasse cls on jnt.pclsclasse = cls.bold_id
    inner join businessclassesroot bus on dfb1.bold_id = bus.bold_id
    left join atdatividade atd on dfb1.bold_id = atd.bold_id
where jnt.desenhopetrobras like 'F%'and jnt.cod_junta not like '%#%' and substring(jnt.cod_junta from 1 for 15) <> '%#%'
    ) prj
    left join gat_ensaiodf df on prj.pdfbdf1 = df.pdfbdf
    left join gat_dijnt di on prj.pjntjunta = di.pjntjunta
    left join gat_ensaiojnt_mnt ens on prj.pjntjunta = ens.pjntjunta
    left join gat_solda sld on prj.pjntjunta = sld.pjntjunta
    left join gat_extinspjnt ext on prj.pjntjunta = ext.pjntjunta