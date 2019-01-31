IMPORT ut, Data_Services, inql_v2;

EXPORT File_SBA_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::nonfcra::base::daily::qa::sba', 
                                               INQL_v2.layouts.rSBA_Base, thor), 
                                               Inquiry_AccLogs.Layout_SBA_logs.common);
//dataset(Data_Services.foreign_logs + 'thor100_21::base::sba_acclogs_common', Inquiry_AccLogs.Layout_SBA_logs.common, thor, opt);