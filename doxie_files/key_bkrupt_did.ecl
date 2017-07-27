import bankrupt,doxie;

f := Bankrupt.file_bk_search_bldg((unsigned)debtor_did != 0);

export key_bkrupt_did := index(f,{unsigned6 s_did := (unsigned)debtor_did}, {f}, '~thor_Data400::key::bkrupt_did_' + doxie.Version_SuperKey);