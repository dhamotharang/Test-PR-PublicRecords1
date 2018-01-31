import doxie,Data_Services;

df := property.file_foreclosure_building_bdid;

export Key_Foreclosures_FID := index(df,{string70 fid := foreclosure_id},{df},Data_Services.Data_location.Prefix()+'thor_data400::key::foreclosure_fid_' + doxie.Version_SuperKey);
