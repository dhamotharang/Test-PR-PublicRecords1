import ut;

ut.MAC_SK_Move('~thor_Data400::key::bh_supergroup_bdid','P',do1);
ut.mac_sk_move('~thor_Data400::key::bh_supergroup_groupid','P',do2);

export proc_accept_supergroup_keys_to_prod := sequential(do1,do2);