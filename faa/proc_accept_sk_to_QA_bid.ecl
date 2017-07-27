import ut,RoxieKeyBuild;

ut.mac_sk_move('~thor_data400::key::fcra::aircraft_reg_did_bid','Q',do3)
ut.mac_sk_move('~thor_data400::key::aircraft_id_bid','Q',do4)
ut.mac_sk_move_v2('~thor_data400::key::aircraft_reg_bid','Q',do8);
ut.mac_sk_move_V2('~thor_data400::key::aircraft_reg_nnum_bid','Q',do9);

export proc_accept_sk_to_QA_bid := parallel(do3,do4,do8,do9);