import ut;

ut.mac_sk_move('~thor_data400::key::prolicense_did','Q',do1)
ut.mac_sk_move('~thor_data400::key::proflic_licensenum','Q',do2)
ut.mac_sk_move_v2('~thor_Data400::key::proflic_bdid','Q',do3,2);


export accept_sk_to_qa := parallel(do1,do2,do3);
