import promotesupers;

promotesupers.MAC_SK_Move_v2('~images::key::Matrix_Images_did','Q',do1,2);
promotesupers.mac_sk_move_v2('~images::key::Matrix_Images','Q',do2,2);


export proc_accept_sk_to_qa := sequential(do1,do2);