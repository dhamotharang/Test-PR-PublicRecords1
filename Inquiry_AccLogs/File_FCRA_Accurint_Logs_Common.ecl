IMPORT ut, inql_v2, Data_Services;
EXPORT File_FCRA_Accurint_Logs_Common := project(dataset(Data_Services.foreign_prod + 'uspr::inql::fcra::base::daily::qa', 
                                            INQL_v2.Layouts.Common_ThorAdditions, thor)
                                            (source='ACCURINT'), 
                                             inquiry_acclogs.Layout.common);
// dataset(ut.foreign_fcra_logs + 'thor10_231::base::Accurint_acclogs_common', inquiry_acclogs.Layout.common, thor);
 