import ut;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::corp_base');
pre2 := ut.sf_maintbuilding('~thor_data400::base::corp_cont_base');
pre3 := ut.SF_MaintBuilding('~thor_data400::base::corp_event_base');
pre4 := ut.SF_MaintBuilding('~thor_data400::base::corp_supp_base');

ut.MAC_SK_BuildProcess_v2(corp.key_corp_base_bdid,'~thor_data400::key::corp_base_bdid',do1);
ut.MAC_SK_BuildProcess_v2(corp.key_Corp_base_bdid_pl,'~thor_data400::key::corp_base_bdid_pl',do1a);
ut.MAC_SK_BuildProcess_v2(corp.key_Corp_event_bdid,'~thor_Data400::key::corp_event_bdid',do2);
ut.MAC_SK_BuildProcess_v2(corp.key_Corp_cont_bdid,'~thor_Data400::key::corp_cont_bdid',do3);
ut.MAC_SK_BuildProcess_v2(corp.key_Corp_supp_bdid,'~thor_Data400::key::corp_supp_bdid',do4);


ut.mac_sk_buildprocess_v2(corp.key_corp_base_corpkey,'~thor_data400::key::corp_base_corpkey',do5);
ut.mac_sk_buildprocess_v2(corp.key_corp_cont_corpkey,'~thor_data400::key::corp_cont_corpkey',do6);
ut.mac_sk_buildprocess_v2(corp.key_corp_event_corpkey,'~thor_data400::key::corp_event_corpkey',do7);
ut.mac_sk_buildprocess_v2(corp.key_corp_supp_corpkey,'~thor_data400::key::corp_supp_corpkey',do8);

ut.MAC_SK_BuildProcess_v2(corp.key_corp_base_name_addr,'~thor_Data400::key::corp_base_name_addr',do9);
ut.MAC_SK_BuildProcess_v2(corp.key_corp_cont_name_addr,'~thor_Data400::key::corp_cont_name_addr',do10);

ut.MAC_SK_BuildProcess_v2(corp.key_corp_base_st_charter,'~thor_data400::key::corp_base_st_charter',do11);

ut.mac_sk_buildprocess_v2(corp.Key_BH_FEIN,'~thor_data400::key::bh_fein_for_corp',do12);

fin1 := ut.SF_MaintBuilt('~thor_data400::base::corp_base');
fin2 := ut.sf_maintbuilt('~thor_data400::base::corp_cont_base');
fin3 := ut.SF_MaintBuilt('~thor_data400::base::corp_event_base');
fin4 := ut.SF_MaintBuilt('~thor_data400::base::corp_supp_base');



export make_corp_keys := sequential(pre1,pre2,pre3,pre4,
		 do1,do1a,do2,do3,do4,do5,do6,do7,do8,do9,do10,do11,do12,
		 fin1,fin2,fin3,fin4);
		 