import ut;

ut.mac_sk_move('~thor_data400::key::airmen_did','P',do1)
ut.mac_sk_move('~thor_data400::key::aircraft_reg_did','P',do2)
ut.mac_sk_move('~thor_data400::key::faa_airmen_certs','P',do3)
ut.mac_sk_move('~thor_data400::key::faa_engine_info','P',do4)
ut.mac_sk_move('~thor_data400::key::faa_aircraft_info','P',do5)
ut.mac_sk_move_v2('~thor_data400::key::aircraft_reg_bdid','P',do6);
ut.mac_sk_move_v2('~thor_data400::key::aircraft_reg_nnum','P',do7);

ut.mac_sk_move_v2('~thor_data400::key::aircraft_reg_bid','P',do6b);
ut.mac_sk_move_V2('~thor_data400::key::aircraft_reg_nnum_bid','P',do7b);

export proc_accept_sk_to_prod := parallel(do1,do2,do3,do4,do5,do6,do7,
	if(Constants.BUILD_BID_KEY_FLAG,parallel(do6b,do7b)));
