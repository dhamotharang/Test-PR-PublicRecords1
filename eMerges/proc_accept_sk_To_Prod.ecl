import ut;

ut.mac_sk_move('~thor_data400::key::hunters_doxie_did','P',do1)
ut.mac_sk_move('~thor_data400::key::voters_doxie_did','P',do2)
ut.mac_sk_move('~thor_data400::key::ccw_doxie_did','P',do3)


export proc_accept_sk_To_Prod := parallel(do1,do2,do3);
