import doxie, BIPV2;

df := project(govdata.File_OR_Workers_Comp_BDID(bdid != 0),transform(govdata.Layout_OR_Workers_Comp_Base -BIPV2.IDlayouts.l_xlink_ids,self := left));

export key_or_workers_comp_bdid := index(df,{bdid},{df},'~thor_data400::key::or_workers_comp_bdid_' + doxie.Version_SuperKey);
