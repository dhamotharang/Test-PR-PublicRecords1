kf := file_liens_daily(rmsid <> '');

export key_prep_liens_rmsid := index(kf,{l_rmsid := rmsid}, {kf}, '~thor_data400::key::liens_rmsid' + thorlib.WUID());
