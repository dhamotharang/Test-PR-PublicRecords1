import ut;

ut.mac_sk_move('~thor_Data400::key::merchant_vessel_did','Q',do1)
ut.mac_sk_move_v2('~thor_Data400::key::merchant_vessel_bdid','Q',do2,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_did2vid','Q',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_vid','Q',do4,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_hullnum','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_vname','Q',do6,2);

export proc_accept_sk_to_QA := sequential(do1,do2,do3,do4,do5,do6);
