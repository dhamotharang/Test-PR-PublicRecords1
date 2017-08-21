import ut, data_services, RoxieKeyBuild, Risk_Indicators;

///////// Total time for 100M recs - 8Mins

#workunit('name','Inquiry Table Update Keys')
#OPTION('AllowedClusters','thor400_92,thor400_84');

rundate := ut.GetDate;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Address_Update,'~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_DID_Update,'~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_Phone_Update,'~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Inquiry_AccLogs.Key_Inquiry_SSN_Update,'~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',bk_ssn);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Risk_Indicators.Key_Inquiry_Table_DID,'~thor_data400::key::inquiry_table_did','~thor_data400::key::inquiry_table::'+rundate+'::did',bk_did_old);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::address_update','~thor_data400::key::inquiry::'+rundate+'::address_Update',mv_addr,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::did_update','~thor_data400::key::inquiry::'+rundate+'::did_Update',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::phone_update','~thor_data400::key::inquiry::'+rundate+'::phone_Update',mv_phone,3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::inquiry_table::@version@::ssn_update','~thor_data400::key::inquiry::'+rundate+'::ssn_Update',mv_ssn,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::inquiry_table::'+rundate+'::did','~thor_data400::key::inquiry_table_did',mv_didold,3); 

RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::address_update','Q',mv2qa_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::did_update','Q',mv2qa_did);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::phone_update','Q',mv2qa_phone);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table::@version@::ssn_update','Q',mv2qa_ssn);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::inquiry_table_did','Q',mv2qa_didold); 

export procBuildUpdateKeys := 
		sequential(
				 parallel(bk_addr, bk_did, bk_phone, bk_ssn, bk_did_old);
				 parallel(mv_addr, mv_did, mv_phone, mv_ssn, mv_didold);
				 parallel(mv2qa_addr, mv2qa_did, mv2qa_phone, mv2qa_ssn, mv2qa_didold));