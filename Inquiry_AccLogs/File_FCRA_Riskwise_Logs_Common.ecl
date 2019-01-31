import ut, data_services, inql_v2;

export File_FCRA_Riskwise_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='RISKWISE'), 
                                             inquiry_acclogs.Layout.common);
//dataset(ut.foreign_fcra_logs + 'thor10_231::base::riskwise_acclogs_common', inquiry_acclogs.Layout.common, thor);