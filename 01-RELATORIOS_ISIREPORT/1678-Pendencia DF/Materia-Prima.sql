

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
