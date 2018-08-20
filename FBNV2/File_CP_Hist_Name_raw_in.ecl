IMPORT data_services;

export File_CP_Hist_Name_raw_in := dataset(data_services.foreign_prod +'thor_data400::base::fbn::cp_hist_name',FBNV2.Layout_FBN_CP_HIST.Layout_In_Name,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']), quote(''), maxlength(10000000)));
