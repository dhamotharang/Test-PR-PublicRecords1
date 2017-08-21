import ut, Data_Services;
export File_BankoBatch_Logs := module

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::banko_batch_acclogs', inquiry_acclogs.Layout_BankoBatch_Logs, csv(separator('|'),quote('')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::banko_batch_acclogs_processed', inquiry_acclogs.Layout_BankoBatch_Logs, csv(separator('|'),quote('')), opt);
																				
export clean(string select_source = 'BANKOBATCH') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::bankobatch', Inquiry_AccLogs.layout_in_common, thor);

end;
