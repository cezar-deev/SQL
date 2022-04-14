-- DF --

select
dfb.romaneio as SMP,
case 
      when dfb.romaneio like '%-0%'  
      then 
            substring(dfb.romaneio from 1 for 3) || substring(dfb.romaneio from 6 for 4) 
      else 
           substring(dfb.romaneio from 1 for 3) || substring(dfb.romaneio from 5 for 4)  END SMP, 
mdl.nome_modulo,
dmt.cod_dm,
dfb.cod_df as df,
dfb.peso_total peso,
dfb.status_df_fab,
dfb.statusdi_mnt

from mdlmodulo mdl left join dmtdesenhomontagem dmt on mdl.bold_id = dmt.pmdlmodulo
left join dfbdesenhofabricacao dfb on dfb.pdmtdm = dmt.bold_id

where dfb.tipo_estrutura = 'JURONG' and dfb.romaneio like '%SMP%'




