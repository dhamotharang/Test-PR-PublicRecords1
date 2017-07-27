import bipv2, doxie;

df := project(govdata.File_MS_Workers_Comp_BDID(bdid != 0),
			transform(govdata.Layout_MS_Workers_Comp_base -BIPV2.IDlayouts.l_xlink_ids,self := left));

export key_ms_workers_comp_BDID := index(df,{bdid},{df},'~thor_data400::key::ms_workers_comp_BDID_' + doxie.Version_SuperKey);