import ut;

ut.MAC_SK_Move('~thor_data400::key::corporate_affiliations.bdid','Q',do1);
ut.mac_sk_move('~thor_Data400::key::corporate_affiliations.state.lfname','Q',do2);
ut.mac_sk_Move('~thor_data400::key::corporate_affiliations.did','Q',do3);
ut.mac_sk_move('~thor_data400::key::corporate_affiliations.filepos','Q',do4);



export proc_accept_corp_affiliation_keys_to_QA := sequential(do1,do2,do3,do4);