import ut;
export File_BankoBatch_Logs := module

export input := dataset(ut.foreign_logs + '~thor10_11::in::banko_batch_acclogs', inquiry_acclogs.Layout_BankoBatch_Logs, csv(separator('|'),quote('')), opt);
export processed := dataset(ut.foreign_logs + '~thor10_11::in::banko_batch_acclogs_processed', inquiry_acclogs.Layout_BankoBatch_Logs, csv(separator('|'),quote('')), opt);
																				
export clean(string select_source = 'BANKOBATCH') := dataset(ut.foreign_logs + '~persist::inquiry_tracking::appends::bankobatch', Inquiry_AccLogs.layout_in_common, thor);

end;
