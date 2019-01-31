import ut, data_services,inql_v2;

export File_FCRA_Batch_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='BATCH'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions);

//dataset(ut.foreign_fcra_logs + 'thor10_231::base::batch_acclogs_common', inquiry_acclogs.Layout.Common, thor, opt);