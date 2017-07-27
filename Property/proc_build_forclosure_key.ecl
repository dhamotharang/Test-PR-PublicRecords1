import ut;

pre := ut.SF_MaintBuilding('~thor_data400::base::property_forclosures_bdid');

ut.mac_sk_buildprocess_v2(property.Key_Forclosures_BDID,'~thor_data400::key::property_forclosure_bdid',do1);
ut.mac_sk_buildprocess_v2(property.Key_Foreclosure_DID,'~thor_data400::key::foreclosures_did',do2);
ut.mac_sk_buildprocess_v2(property.Key_Foreclosures_FID,'~thor_data400::key::foreclosure_fid',do3);

ut.mac_sk_move_V2('~thor_Data400::key::property_forclosure_bdid','Q',do4,2);
ut.mac_sk_move_v2('~thor_data400::key::foreclosures_did','Q',do5,2);
ut.mac_sk_move_v2('~thor_data400::key::foreclosure_fid','Q',do6,2);

post := ut.SF_MaintBuilt('~thor_Data400::base::property_forclosures_bdid');

export proc_build_forclosure_key := sequential(pre,do1,do2,do3,do4,do5,do6,post);
