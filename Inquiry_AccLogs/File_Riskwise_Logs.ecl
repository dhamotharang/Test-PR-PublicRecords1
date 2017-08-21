import ut, Data_Services;

export File_Riskwise_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::riskwise_acclogs', inquiry_acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::riskwise_acclogs_processed', inquiry_acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);

export clean(string select_source = 'RISKWISE') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;