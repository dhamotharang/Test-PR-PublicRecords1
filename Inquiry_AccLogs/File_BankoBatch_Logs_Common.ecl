import ut;

export File_BankoBatch_Logs_Common := dataset(ut.foreign_logs + 'thor10_11::base::banko_batch_acclogs_common', Inquiry_AccLogs.Layout.Common, thor, opt);
																									 