Import ut, utilfile, data_services;
Export In_UtilDid(String filedate) := Dataset(data_services.foreign_prod+'thor_data400::in::utility::'+filedate+'::daily_did', Scrubs_UtilDid.Layout_UtilDid, thor);
