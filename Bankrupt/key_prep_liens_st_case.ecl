import data_services;
kf := file_liens_daily(casenumber <> '', state <> '');

export key_prep_liens_st_case := index(kf,{l_casenumber := casenumber, l_st := state}, {rmsid}, data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::liens_st_case' + thorlib.WUID());