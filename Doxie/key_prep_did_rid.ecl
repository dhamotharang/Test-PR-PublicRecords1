import data_services;

export key_prep_did_rid := index(file_base_did_rid,
                                 {rid,did,stable,__filepos},
                                 data_services.data_location.prefix() + 'thor_data400::key::rid_did'+ thorlib.wuid());