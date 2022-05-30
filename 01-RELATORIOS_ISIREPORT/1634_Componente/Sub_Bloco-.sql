select
a.Sub_Bloco,
count(a.cod_componente) as Qtd_Pend
from
    (select
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
        end as Corte, 

        mpr.cod_mp as Material,
        cmp.Status_Comp as Status_Componentes

            from  cmpcomponente cmp
            left join pctplano_corte pct on pct.bold_id = cmp.ppctpcorte
            left join dfbdesenhofabricacao dfb on dfb.bold_id = cmp.pdfbdf
            left join crtcorte crt on crt.ppctplanocorte = pct.bold_id
            left join mprmateriaprima mpr on mpr.bold_id = crt.pmprmateriaprima
            left join dmtdesenhomontagem dmt on dmt.bold_id = dfb.pdmtdm
            left join mdlmodulo mdl on mdl.bold_id = dmt.pmdlmodulo
            
    order by 1,2,3,6 ) a

where a.corte='Pendente' and a.Modulo is not null
group by 
a.Sub_Bloco