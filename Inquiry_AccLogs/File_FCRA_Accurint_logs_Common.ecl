IMPORT data_services;

EXPORT File_FCRA_Accurint_Logs_Common := dataset(Data_Services.foreign_fcra_logs + 'thor10_231::base::Accurint_acclogs_common', inquiry_acclogs.Layout.common, thor); 