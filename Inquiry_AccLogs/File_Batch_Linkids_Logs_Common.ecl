IMPORT ut, Data_Services;
EXPORT File_Batch_Linkids_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::batch_linkids_acclogs_common', inquiry_acclogs.Layout_batch_logs.addedCleaned, thor, opt);
