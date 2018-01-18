import doxie, data_services;

df := govdata.File_FL_NonProfit_Corp(bdid != 0);

export key_FL_NonProfit_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::fl_nonprofit_bdid_' + doxie.Version_SuperKey);
