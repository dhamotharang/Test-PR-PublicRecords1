import ut,Data_Services;

export File_Accurint_Logs := module

export preprocess := dataset(Data_Services.foreign_logs + 'thor100_21::in::accurint_acclogs_preprocess', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::accurint_acclogs', Inquiry_AccLogs.Layout_Accurint_Logs, csv(maxlength(250000), quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::accurint_acclogs_processed', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);

export clean(string select_source = 'ACCURINT') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;