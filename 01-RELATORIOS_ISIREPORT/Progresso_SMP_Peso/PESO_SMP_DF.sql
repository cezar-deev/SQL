
--PESOS_SMP_DF--

select 
dfb.romaneio as SMP,
case 
      when dfb.romaneio like '%-0%'  
      then 
            substring(dfb.romaneio from 1 for 3) || substring(dfb.romaneio from 6 for 4) 
      else 
           substring(dfb.romaneio from 1 for 3) || substring(dfb.romaneio from 5 for 4)  END SMP,

replace (cast(sum(dfb.peso_total )as decimal (8,2)) , '.' , ',') as Peso_Total

from mdlmodulo mdl left join dmtdesenhomontagem dmt on mdl.bold_id = dmt.pmdlmodulo
left join dfbdesenhofabricacao dfb on dfb.pdmtdm = dmt.bold_id

where dfb.tipo_estrutura = 'JURONG' and dfb.romaneio like '%SMP%'

group by dfb.romaneio


