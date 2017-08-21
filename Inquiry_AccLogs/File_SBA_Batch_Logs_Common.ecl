IMPORT ut, Data_Services;

EXPORT File_SBA_Batch_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::sba_batch_acclogs_common', Inquiry_AccLogs.Layout_Batch_Logs_V2.common, thor, opt);