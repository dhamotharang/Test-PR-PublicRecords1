import ut;


ut.mac_sk_buildprocess_v2(business_header.Key_Business_Header_Address,'~thor_data400::key::business_header.address',dokey1);
ut.mac_sk_buildprocess_v2(business_header.key_employment_did,'~thor_Data400::key::employment_did',dokey2);


ut.mac_sk_move_v2('~thor_data400::key::business_header.address','Q',movekey1,2);
ut.mac_sk_move_V2('~thor_data400::key::employment_did','Q',movekey2,2);


export Make_Business_Keys := sequential(dokey1,dokey2,movekey1,movekey2);
