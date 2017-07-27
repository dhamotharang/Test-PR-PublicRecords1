import bankrupt;

f := distributed(bankrupt.file_bk_search_bldg((unsigned)debtor_did != 0),hash(debtor_did));

slim_f := table(f,{debtor_did,court_code,case_number});

sort_f := sort(slim_f,debtor_did,court_code,case_number);

dedp_f := dedup(sort_f,all);

export key_prep_bkrupt_didslim := index(dedp_f,{unsigned6 s_did := (unsigned)debtor_did}, {court_code, case_number}, '~thor_Data400::key::bankrupt_didslim_' + thorlib.wuid());