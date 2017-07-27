import ut;

#workunit('name','Business Risk Build Keys');



ut.MAC_SK_BuildProcess_v2(Business_Risk.key_bdid_table,'~thor_data400::key::bdid_table',do1)
ut.MAC_SK_BuildProcess_v2(Business_Risk.key_fein_table,'~thor_data400::key::fein_table',do2)
ut.MAC_SK_BuildProcess_v2(Business_Risk.key_groupid_cnt,'~thor_data400::key::groupid_cnt',do3)
ut.MAC_SK_BuildProcess_v2(business_risk.Key_SSN_Address,'~thor_data400::key::header_ssn_address',do4);
ut.MAC_SK_BuildProcess_v2(business_risk.Key_BH_Fein,'~thor_Data400::key::business_InstantID_FEIN2Addr',do5);
ut.mac_sk_buildprocess_v2(business_risk.Key_BH_BDID_Phone, '~thor_data400::key::BH_BDID_To_Phone',do6);
ut.mac_sk_buildprocess_v2(business_risk.Key_Bus_Cont_DID_2_BDID, '~thor_data400::key::bh_contacts_did_2_bdid',do7);


export proc_build_brisk_keys := sequential(do1, do2, do3,do4,do5, do6, do7);