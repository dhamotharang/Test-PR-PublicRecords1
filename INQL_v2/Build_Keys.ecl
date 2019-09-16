import _control, versioncontrol, std, Data_Services, ut, INQL_v2, RoxieKeyBuild;

export Build_Keys(string pVersion = '', boolean fcra = false, boolean pDaily	= false) := module	

	keyCommonSFN := '~thor_data400::key::inquiry::';
	keyCommonLFN := keyCommonSFN + pVersion;
	
	keyCommonTableSFN := '~thor_data400::key::inquiry_table';
	keyCommonTableLFN := keyCommonTableSFN + '::' + pVersion;
	
	
//--------------------------BUILD KEYS--------------------------------//
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_Address_Update         ,keyCommonSFN + 'address_update'        ,keyCommonLFN+'::address_Update'       ,bk_addru);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_transaction_id_update  ,keyCommonSFN + 'transaction_id_update' ,keyCommonLFN+'::transaction_id_update',bk_trans);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_DID_Update             ,keyCommonSFN + 'did_update'            ,keyCommonLFN+'::did_Update'           ,bk_didu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_Phone_Update           ,keyCommonSFN + 'phone_update'          ,keyCommonLFN+'::phone_Update'         ,bk_phoneu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_SSN_Update             ,keyCommonSFN + 'ssn_update'            ,keyCommonLFN+'::ssn_Update'           ,bk_ssnu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_Email_Update           ,keyCommonSFN + 'email_update'          ,keyCommonLFN+'::email_update'         ,bk_emailu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_name_Update            ,keyCommonSFN + 'name_update'           ,keyCommonLFN+'::name_Update'          ,bk_nameu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_IPaddr_Update          ,keyCommonSFN + 'IPaddr_update'         ,keyCommonLFN+'::IPaddr_update'        ,bk_IPaddru);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_LinkIds_Update.key     ,keyCommonSFN + 'LinkIds_update'        ,keyCommonLFN+'::LinkIds_update'       ,bk_LinkIdsu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_FEIN_Update            ,keyCommonSFN + 'fein_update'           ,keyCommonLFN+'::fein_Update'          ,bk_feinu);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_Table_DID                    ,keyCommonTableSFN + '_did'                         ,keyCommonTableLFN+'::did'                        ,bk_did_old);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_industry_use_vertical()      ,keyCommonTableSFN + '::industry_use_vertical'      ,keyCommonTableLFN+'::industry_use_vertical'      ,bk_industry_veritcal);
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.key_lookup_function_desc                 ,keyCommonTableSFN + '::lookup_function_desc'       ,keyCommonTableLFN+'::lookup_function_desc'       ,bk_function_desc);	
	RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(INQL_v2.Key_Inquiry_industry_use_vertical_login(),keyCommonTableSFN + '::industry_use_vertical_login',keyCommonTableLFN+'::industry_use_vertical_login',bk_industry_vertical_login);

//--------------------------MOVE KEYS to BUILT--------------------------------//
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'transaction_id_update',keyCommonLFN+'::transaction_id_update',mv_transu  ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'address_update'       ,keyCommonLFN+'::address_Update'       ,mv_addru   ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'did_update'           ,keyCommonLFN+'::did_Update'           ,mv_didu    ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'phone_update'         ,keyCommonLFN+'::phone_Update'         ,mv_phoneu  ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'ssn_update'           ,keyCommonLFN+'::ssn_Update'           ,mv_ssnu    ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'email_update'         ,keyCommonLFN+'::email_Update'         ,mv_emailu  ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'name_update'          ,keyCommonLFN+'::name_Update'          ,mv_nameu   ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'IPaddr_update'        ,keyCommonLFN+'::IPaddr_Update'        ,mv_IPaddru ,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'LinkIds_update'       ,keyCommonLFN+'::LinkIds_update'       ,mv_LinkIdsu,3);
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2(keyCommonSFN + 'fein_update'          ,keyCommonLFN+'::fein_Update'          ,mv_feinu   ,3);
	RoxieKeyBuild.Mac_SK_Move_To_Built(keyCommonTableLFN + '::did'                       ,keyCommonTableSFN + '_did'                          ,mv_didold                 ,3);
	RoxieKeyBuild.Mac_SK_Move_To_Built(keyCommonTableLFN +'::industry_use_vertical'      ,keyCommonTableSFN + '::industry_use_vertical'       ,mv_industry_vertical      ,3);
	RoxieKeyBuild.Mac_SK_Move_To_Built(keyCommonTableLFN +'::lookup_function_desc'       ,keyCommonTableSFN + '::lookup_function_desc'        ,mv_function_desc          ,3);	
	RoxieKeyBuild.Mac_SK_Move_To_Built(keyCommonTableLFN +'::industry_use_vertical_login',keyCommonTableSFN + '::industry_use_vertical_login'	,mv_industry_vertical_login,3);

//--------------------------MOVE KEYS to QA--------------------------------//
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'address_update'       ,'Q',mv2qa_addru);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'transaction_id_update','Q',mv2qa_transu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'did_update'           ,'Q',mv2qa_didu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'phone_update'         ,'Q',mv2qa_phoneu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'ssn_update'           ,'Q',mv2qa_ssnu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'email_update'         ,'Q',mv2qa_emailu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'name_update'          ,'Q',mv2qa_nameu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'IPAddr_update'        ,'Q',mv2qa_IPaddru);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'LinkIds_update'       ,'Q',mv2qa_LinkIdsu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonSFN + 'fein_update'          ,'Q',mv2qa_feinu);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonTableSFN + '_did'                         ,'Q',mv2qa_didold);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonTableSFN + '::industry_use_vertical'      ,'Q',mv2qa_industry_vertical);
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonTableSFN + '::lookup_function_desc'       ,'Q',mv2qa_function_desc);	
	RoxieKeyBuild.Mac_SK_Move_V2(keyCommonTableSFN + '::industry_use_vertical_login','Q',mv2qa_industry_vertical_login);
	
  INQL_base := INQL_v2.File_Inquiry_BaseSourced.Updates;
    
	EXPORT ALL := 
						sequential(
						 parallel(bk_addru, bk_trans,bk_didu, bk_phoneu, bk_ssnu, bk_emailu, bk_nameu, bk_IPaddru, bk_LinkIdsu, bk_did_old,bk_industry_veritcal,bk_function_desc,bk_feinu,bk_industry_vertical_login)
						,parallel(mv_addru, mv_transu, mv_didu, mv_phoneu, mv_ssnu, mv_emailu, mv_nameu, mv_IPaddru, mv_LinkIdsu, mv_didold,mv_industry_vertical,mv_function_desc,mv_feinu,mv_industry_vertical_login)
						,parallel(mv2qa_addru,mv2qa_transu, mv2qa_didu, mv2qa_phoneu, mv2qa_ssnu, mv2qa_emailu,mv2qa_nameu, mv2qa_IPaddru, mv2qa_LinkIdsu, mv2qa_didold,mv2qa_industry_vertical,mv2qa_function_desc,mv2qa_feinu,mv2qa_industry_vertical_login)
						,RoxieKeybuild.updateversion('InquiryTableUpdateKeys',pVersion,INQL_v2.email_notification_lists.BuildSuccess,,'N')
						,output(choosen(sort(choosen(INQL_base(person_q.appended_adl > 0 and bus_intel.industry not in ['UNASSIGNED','BLANK','']), 1000000), -search_info.datetime), 100), named('Sample_Update_Records'))
						,output(choosen(INQL_base(person_q.email_address <> ''), 5), named('Sample_Update_Email_Records'))
						,INQL_v2.STRATA_Inquiry_Daily_Tracking(pVersion)
						);		
//clean names and address
//append lexids	if new header
//append mbs settings
//output the keys

end;
