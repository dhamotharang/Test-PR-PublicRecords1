

 export File_CP_Hist_Filing_raw_in :=dataset('~thor_data400::base::fbn::cp_Hist_Filing',Layout_FBN_CP_HIST.Layout_In_Filing,CSV(SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']), quote(''), maxlength(10000000)));
