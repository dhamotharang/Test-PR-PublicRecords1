import Risk_Indicators,data_services;

export File_Telcordia_tpm := DATASET(data_services.Data_location.Prefix('TDS')+'thor_data400::base::tpmdata',Risk_Indicators.Layout_Telcordia_tpm,flat);
