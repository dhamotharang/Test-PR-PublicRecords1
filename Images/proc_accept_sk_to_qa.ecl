import ut;

ut.MAC_SK_Move('~images::key::Matrix_Images_did','Q',do1);
ut.mac_sk_move('~images::key::Matrix_Images','Q',do2);


export proc_accept_sk_to_qa := sequential(do1,do2);