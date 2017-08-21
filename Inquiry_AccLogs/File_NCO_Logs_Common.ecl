import ut, Data_Services;

export File_NCO_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::nco_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);