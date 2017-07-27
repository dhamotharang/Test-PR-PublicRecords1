import ut;

ut.MAC_SK_Move_v2('~thor_Data400::key::corp_base_bdid','Q',do1);
ut.MAC_SK_Move_v2('~thor_data400::key::corp_base_bdid_pl','Q',do1a);
ut.mac_sk_move_v2('~thor_data400::key::corp_event_bdid','Q',do2);
ut.mac_sk_Move_v2('~thor_data400::key::corp_cont_bdid','Q',do3);
ut.mac_sk_move_v2('~thor_data400::key::corp_supp_bdid','Q',do4);
ut.mac_sk_move_v2('~thor_data400::key::corp_base_corpkey','Q',do5);
ut.mac_sk_move_v2('~thor_data400::key::corp_cont_corpkey','Q',do6);
ut.mac_sk_move_v2('~thor_data400::key::corp_event_corpkey','Q',do7);
ut.mac_sk_move_v2('~thor_data400::key::corp_supp_corpkey','Q',do8);
ut.mac_sk_move_v2('~thor_Data400::key::corp_base_name_addr','Q',do9);
ut.mac_sk_move_v2('~thor_data400::key::corp_base_st_charter','Q',do10);
ut.mac_sk_move_v2('~thor_data400::key::corp_cont_name_addr','Q',do11);
ut.mac_sk_move_v2('~thor_Data400::key::bh_fein_for_corp','Q',do12);


export proc_accept_corp_keys_to_QA := sequential(do1,do1a,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12);
