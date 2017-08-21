import ut, Data_Services;

export File_Custom_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::custom_acclogs', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::custom_acclogs_processed', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);

export clean(string select_source = 'CUSTOM') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);


end;