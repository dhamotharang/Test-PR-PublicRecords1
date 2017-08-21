import ut, Data_Services;

export File_Banko_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::banko_acclogs', Inquiry_AccLogs.Layout_Banko_Logs, csv(maxlength(10000), separator('~~'), quote('')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::banko_acclogs_processed', Inquiry_AccLogs.Layout_Banko_Logs, csv(maxlength(10000), separator('~~'), quote('')), opt);

export clean(string select_source = 'BANKO') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;