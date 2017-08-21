import ut, Data_Services;

export File_SBA_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::sba_acclogs', inquiry_acclogs.Layout_SBA_logs.input_raw, csv(quote(''), separator(['~~']), terminator(['\n'])), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::SBA_acclogs_processed', inquiry_acclogs.Layout_SBA_logs.input_raw, csv(quote(''), separator(['~~']), terminator(['\n'])), opt);

end;