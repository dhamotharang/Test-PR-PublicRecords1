import ut,Data_Services;

export File_Batch_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::batch_acclogs',Inquiry_AccLogs.Layout_Batch_Logs, csv(maxlength(10000), separator('|'),quote('"')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::batch_acclogs_processed',Inquiry_AccLogs.Layout_Batch_Logs, csv(maxlength(10000), separator('|'),quote('"')), opt);

export clean(string select_source = 'BATCH') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;