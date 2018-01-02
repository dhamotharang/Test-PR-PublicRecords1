import data_services;
kf := file_liens_daily((unsigned6)bdid <> 0);

export key_prep_liens_bdid := index(kf,{unsigned6 l_bdid := (unsigned6)bdid}, {rmsid}, data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::liens_bdid' + thorlib.WUID());
