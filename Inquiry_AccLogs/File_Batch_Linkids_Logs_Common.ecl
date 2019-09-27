IMPORT ut, Data_Services, Inql_V2;
EXPORT File_Batch_Linkids_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa::batch_piis', 
                                               INQL_v2.layouts.rBatch_PIIS_Base, thor), 
                                               inquiry_acclogs.Layout_batch_logs.addedCleaned);

//dataset(Data_Services.foreign_logs + 'thor100_21::base::batch_linkids_acclogs_common', inquiry_acclogs.Layout_batch_logs.addedCleaned, thor, opt);
