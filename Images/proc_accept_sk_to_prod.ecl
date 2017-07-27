import ut;

ut.MAC_SK_Move('~images::key::Matrix_Images_did','P',do1);
ut.mac_sk_move('~images::key::Matrix_Images','P',do2);


export proc_accept_sk_to_prod := sequential(do1,do2);