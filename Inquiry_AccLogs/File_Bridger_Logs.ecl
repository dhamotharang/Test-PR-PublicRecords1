import ut, Data_Services;

export File_Bridger_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::bridger_acclogs', Inquiry_AccLogs.Layout_bridger_Logs.Input, csv(maxlength(3072), separator('\t'), quote('')), opt);
export preprocess := dataset(Data_Services.foreign_logs + 'thor100_21::in::bridger_acclogs_preprocess', Inquiry_AccLogs.Layout_bridger_Logs.Input, csv(maxlength(3072), separator('\t'), quote('')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::bridger_acclogs_processed', Inquiry_AccLogs.Layout_bridger_Logs.Input, csv(maxlength(3072), separator('\t'), quote('')), opt);

export clean(string select_source = 'BRIDGER') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;
