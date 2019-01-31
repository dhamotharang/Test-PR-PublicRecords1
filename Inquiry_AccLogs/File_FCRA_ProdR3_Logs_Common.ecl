import ut, data_services,inql_v2;
export File_FCRA_ProdR3_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='BATCHR3'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions);

//dataset(ut.foreign_fcra_logs + 'thor10_231::base::prodr3_acclogs_common', inquiry_acclogs.Layout.Common, thor, opt);