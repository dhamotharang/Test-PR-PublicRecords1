import doxie, Data_Services;

df := property.file_nod_building_bdid;

export Key_NOD_FID := index(df,{string70 fid := foreclosure_id},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::nod::' + doxie.Version_SuperKey + '::fid');