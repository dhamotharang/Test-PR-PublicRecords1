import ut,Data_Services;

export File_Accurint_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::accurint_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);

