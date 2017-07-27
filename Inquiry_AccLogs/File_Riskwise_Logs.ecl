import ut;

export File_Riskwise_Logs := module

export input := dataset(ut.foreign_logs + '~thor10_11::in::riskwise_acclogs', inquiry_acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);
export processed := dataset(ut.foreign_logs + '~thor10_11::in::riskwise_acclogs_processed', inquiry_acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);

export clean(string select_source = 'RISKWISE') := dataset(ut.foreign_logs + '~persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;