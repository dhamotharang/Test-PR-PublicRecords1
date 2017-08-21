import ut, Data_Services;

EXPORT File_IDM_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::idm_bls_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);