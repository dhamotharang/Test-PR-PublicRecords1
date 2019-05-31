import ut, Data_Services, inql_v2;

export File_BatchR3_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='BATCHR3'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions);
//dataset(Data_Services.foreign_logs + 'thor100_21::base::batchr3_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);