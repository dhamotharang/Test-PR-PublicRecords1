IMPORT ut, Data_Services, Inql_v2;

EXPORT File_Bridger_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='BRIDGER'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions);

//dataset(Data_Services.foreign_logs + 'thor100_21::base::bridger_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);

