import ut, Data_Services;

export File_Custom_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::custom_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);