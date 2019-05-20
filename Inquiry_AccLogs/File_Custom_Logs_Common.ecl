import ut, Data_Services, inql_v2;

export File_Custom_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='CUSTOM'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions);
//dataset(Data_Services.foreign_logs + 'thor100_21::base::custom_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);