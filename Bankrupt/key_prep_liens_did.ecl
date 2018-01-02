import data_services;
kf := file_liens_daily((unsigned6)did <> 0);

export key_prep_liens_did := index(kf,{unsigned6 l_did := (unsigned6)did}, {rmsid}, data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::liens_did' + thorlib.WUID());
