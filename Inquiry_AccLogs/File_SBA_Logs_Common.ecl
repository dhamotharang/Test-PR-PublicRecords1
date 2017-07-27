IMPORT ut;

EXPORT File_SBA_Logs_Common := dataset(ut.foreign_logs + 'thor100_21::base::sba_acclogs_common', Inquiry_AccLogs.Layout_SBA_logs.common, thor, opt);