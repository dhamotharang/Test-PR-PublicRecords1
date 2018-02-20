import data_services;

export File_FCRA_BankoBatch_Logs_Common := dataset(Data_Services.foreign_fcra_logs + 'thor10_231::base::banko_batch_acclogs_common', inquiry_acclogs.Layout.Common, thor);