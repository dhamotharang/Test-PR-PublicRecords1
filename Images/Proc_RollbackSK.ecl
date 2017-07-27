import ut;

ut.MAC_SK_Move('~images::key::Matrix_Images_did','R',do1);
ut.mac_sk_move('~images::key::Matrix_Images','R',do2);


export Proc_RollbackSK := sequential(do1,do2);