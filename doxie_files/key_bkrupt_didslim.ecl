import bankrupt,doxie, data_services;

slim_f := table(bankrupt.File_BK_Search,{debtor_did,court_code,case_number});

f := distributed(slim_f((unsigned)debtor_did != 0),hash(debtor_did));

sort_f := sort(f,debtor_did,court_code,case_number);

dedp_f := dedup(sort_f,all);

export key_bkrupt_didslim := index(dedp_f,
                                   {unsigned6 s_did := (unsigned)debtor_did}, 
                                   {court_code, case_number}, 
                                   data_services.data_location.prefix() + 'thor_Data400::key::bankrupt_didslim_' + doxie.Version_SuperKey);