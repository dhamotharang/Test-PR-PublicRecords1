import doxie, data_services;

df := govdata.File_IRS_NonProfit_Base(bdid != 0);

export Key_IRS_NonProfit_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::irs_nonprofit_bdid_' + doxie.Version_SuperKey);
