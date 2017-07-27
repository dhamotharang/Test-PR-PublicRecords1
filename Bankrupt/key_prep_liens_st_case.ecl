kf := file_liens_daily(casenumber <> '', state <> '');

export key_prep_liens_st_case := index(kf,{l_casenumber := casenumber, l_st := state}, {rmsid}, '~thor_data400::key::liens_st_case' + thorlib.WUID());