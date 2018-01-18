import data_services;
kf := file_liens_daily(rmsid <> '');

export key_prep_liens_rmsid := index(kf,{l_rmsid := rmsid}, {kf}, data_services.data_location.prefix('bankruptcy') + 'thor_data400::key::liens_rmsid' + thorlib.WUID());
