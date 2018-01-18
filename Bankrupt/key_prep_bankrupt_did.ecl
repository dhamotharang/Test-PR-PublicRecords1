import doxie, data_services;

f := bankrupt.file_bk_search_bldg((unsigned)debtor_did != 0);

export key_prep_bankrupt_did := index(f,{unsigned6 s_did := (unsigned)debtor_did}, {f}, data_services.data_location.prefix('bankruptcy') + 'thor_Data400::key::bkrupt_did_' + thorlib.wuid());