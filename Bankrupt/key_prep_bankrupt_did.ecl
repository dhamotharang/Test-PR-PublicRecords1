import doxie;

f := bankrupt.file_bk_search_bldg((unsigned)debtor_did != 0);

export key_prep_bankrupt_did := index(f,{unsigned6 s_did := (unsigned)debtor_did}, {f}, '~thor_Data400::key::bkrupt_did_' + thorlib.wuid());