import ut;

ut.mac_sk_move('~thor_Data400::key::merchant_vessel_did','P',do1)
ut.mac_sk_move_v2('~thor_Data400::key::merchant_vessel_bdid','P',do2,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_did2vid','P',do3,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_vid','P',do4,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_hullnum','P',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::merchant_vessel_vname','P',do6,2);



export proc_accept_sk_to_Prod := sequential(do1,do2,do3,do4,do5,do6);
