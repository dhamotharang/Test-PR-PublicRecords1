IMPORT ut;

EXPORT File_Bridger_Logs_Common := dataset(ut.foreign_logs + 'thor100_21::base::bidger_acclogs_common', Inquiry_AccLogs.Layout.Common, thor, opt);

