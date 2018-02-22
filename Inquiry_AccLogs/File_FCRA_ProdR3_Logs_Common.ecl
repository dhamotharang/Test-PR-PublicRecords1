import data_services;

export File_FCRA_ProdR3_Logs_Common := dataset(Data_Services.foreign_fcra_logs + 'thor10_231::base::prodr3_acclogs_common', inquiry_acclogs.Layout.Common, thor, opt);