import doxie,data_services;

df := vickers.File_Insider_Filing_Base(bdid != 0);

export Key_Insider_Filing_BDID := index(df,{bdid},{df},data_services.data_location.prefix() + 'thor_data400::key::vickers_insider_filing_bdid_' + doxie.Version_SuperKey);
