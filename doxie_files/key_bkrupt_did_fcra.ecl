import bankrupt, doxie, ut;

f := Bankrupt.file_bk_search_bldg ((unsigned)debtor_did != 0);

export key_bkrupt_did_fcra := index (f,{unsigned6 s_did := (unsigned)debtor_did}, {f},
                                     '~thor_Data400::key::bkrupt_did_fcra_' + doxie.Version_SuperKey);
