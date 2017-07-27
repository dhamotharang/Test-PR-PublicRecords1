import ut;

ut.mac_sk_move('~thor_data400::key::prolicense_did','P',do1)
ut.mac_sk_move('~thor_data400::key::proflic_licensenum','P',do2)
ut.mac_sk_move_v2('~thor_Data400::key::proflic_bdid','P',do3,2);

export accept_sk_to_Prod := parallel(do1,do2,do3);