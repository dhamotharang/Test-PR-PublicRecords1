import ut;

ut.mac_sk_move('~thor_data400::key::dea_did','P',do1)
ut.mac_sk_move_v2('~thor_data400::key::dea_bdid','P',do2,2);

export proc_accept_sk_to_Prod := sequential(do1,do2);