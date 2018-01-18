import doxie, data_services;

df := govdata.file_fl_fbn_base(bdid != 0);

export Key_FL_FBN_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::fl_fbn_bdid_' + doxie.Version_SuperKey);
