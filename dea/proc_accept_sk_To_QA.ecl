import ut;

ut.mac_sk_move('~thor_data400::key::dea_did','Q',do1);
ut.mac_sk_move_v2('~thor_data400::key::dea_bdid','Q',do2,2);


export proc_accept_sk_To_QA := sequential(do1,do2);