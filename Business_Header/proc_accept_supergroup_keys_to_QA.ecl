import ut;

ut.MAC_SK_Move('~thor_Data400::key::bh_supergroup_bdid','Q',do1);
ut.mac_sk_move('~thor_Data400::key::bh_supergroup_groupid','Q',do2);

export proc_accept_supergroup_keys_to_QA := sequential(do1,do2);