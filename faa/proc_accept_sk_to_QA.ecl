import ut,RoxieKeyBuild;

ut.mac_sk_move('~thor_data400::key::airmen_did','Q',do1);
ut.mac_sk_move('~thor_data400::key::aircraft_reg_did','Q',do2);
ut.mac_sk_move('~thor_data400::key::fcra::aircraft_reg_did','Q',do3) ; // depricate this after queries changed to point to new key. 
ut.mac_sk_move('~thor_data400::key::aircraft_id','Q',do4);
ut.mac_sk_move('~thor_data400::key::faa_airmen_certs','Q',do5);
ut.mac_sk_move('~thor_data400::key::faa_engine_info','Q',do6);
ut.mac_sk_move('~thor_data400::key::faa_aircraft_info','Q',do7);
ut.mac_sk_move_v2('~thor_data400::key::aircraft_reg_bdid','Q',do8);
ut.mac_sk_move_V2('~thor_data400::key::aircraft_reg_nnum','Q',do9);
ut.mac_sk_move('~thor_data400::key::faa::airmen_rid','Q',do10);
ut.mac_sk_move('~thor_data400::key::faa::airmen_id','Q',do11);

// FCRA 
ut.mac_sk_move('~thor_data400::key::faa::FCRA::aircraftreg_did','Q',do12);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::aircraft_reg_nnum','Q',do13);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::engine_info','Q',do14)
ut.mac_sk_move('~thor_data400::key::faa::FCRA::aircraft_info','Q',do15);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::aircraft_id','Q',do17);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::airmen_rid','Q',do18);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::airmen_did','Q',do16)
ut.mac_sk_move('~thor_data400::key::faa::FCRA::airmen_id','Q',do19);
ut.mac_sk_move('~thor_data400::key::faa::FCRA::airmen_certs','Q',do20);

export proc_accept_sk_to_QA := parallel(do1,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,do13,do14,do15,do16,do17,do18,do19,do20);