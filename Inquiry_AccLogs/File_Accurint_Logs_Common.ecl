import ut,Data_Services, inql_v2;

// export File_Accurint_Logs_Common := dataset(Data_Services.foreign_logs + 'thor100_21::base::accurint_acclogs_common', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor, opt);

export File_Accurint_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='ACCURINT'), 
                                             Inquiry_AccLogs.Layout.Common_ThorAdditions); 