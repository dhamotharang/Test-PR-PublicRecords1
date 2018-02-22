IMPORT data_services;

EXPORT File_Bridger_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::bidger_acclogs_common', Inquiry_AccLogs.Layout.Common, thor, opt);

