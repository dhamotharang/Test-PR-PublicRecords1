IMPORT ut, Data_Services;

EXPORT File_Bridger_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::bridger_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);

