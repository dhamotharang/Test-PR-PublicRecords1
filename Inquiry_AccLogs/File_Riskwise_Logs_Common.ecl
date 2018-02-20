import data_services;

export File_Riskwise_Logs_Common :=  dataset(Data_Services.foreign_logs + 'thor10_11::base::riskwise_acclogs_common', Inquiry_AccLogs.Layout.Common, thor);