import ut;

EXPORT File_IDM_Logs_Common := dataset(ut.foreign_logs + 'thor100_21::base::idm_bls_acclogs_common', Inquiry_AccLogs.Layout.Common, thor, opt);