import doxie, ut;

df := property.file_foreclosure_building_bdid;

export Key_Foreclosures_FID := index(df,{string70 fid := foreclosure_id},{df},'~thor_Data400::key::foreclosure_fid_' + doxie.Version_SuperKey);
