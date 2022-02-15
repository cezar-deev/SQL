select
a.chapa as Plate,
a.plano_de_corte as Cut_Plan,
a.certificado as certificate,
a.corrida as HT_Number,
round((a.peso_mpr),3) as Weight_material,
round((a.peso_cmp),3) as Weight_used,
round((a.peso_mpr - a.peso_cmp),3) as weight_remains,
case when cast(a.peso_mpr as float) = 0 then 0 else round(cast(a.peso_cmp as float)/ cast(a.peso_mpr as float),3)*100 end as Percent_used
from(
    
    select
mpr.cod_mp as CHAPA,
--cmp.cod_componente as POSICAO,
pct.cod_pc as Plano_de_Corte,
mpr.certificado,
chp.corrida,
sum(cmp.peso) as PESO_cmp,
mpr.pesototal as peso_mpr,
mat.codigo_mb as MATERIAL,
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
end as TIPO_CMP
--CRT.DATACORTE

from  cmpcomponente cmp
left join PCTPLANO_CORTE PCT on pct.bold_id = cmp.ppctpcorte
inner join crtcorte crt on crt.ppctplanocorte = pct.bold_id
left join mprmateriaprima mpr on mpr.bold_id = crt.pmprmateriaprima
left join chpchapas chp on chp.bold_id = mpr.bold_id
left join dfbdesenhofabricacao dfb on dfb.bold_id = cmp.pdfbdf
left join matmaterial mat on mat.bold_id = cmp.pmatmbase
WHERE dfb.tipo_estrutura = 'JURONG'

group by
mpr.cod_mp,
pct.cod_pc,
mpr.certificado,
chp.corrida,
mpr.pesototal,
mat.codigo_mb ,

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
end
order by 3)a

//-------------------------------------------------


/*
Tabelas :

cmpcomponente cmp
PCTPLANO_CORTE pct
crtcorte crt
mprmateriaprim
chpchapas
dfbdesenhofabricacao
matmaterial
vw_pendente_corte
dmtdesenhomontagem (pmdlmodulo)
mdlmodulo mdl (bold_id) 
*/


