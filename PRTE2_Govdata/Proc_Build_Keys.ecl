IMPORT versioncontrol, doxie, BBB2, Data_Services, BIPV2, PRTE, _control, Orbit3, RoxieKeyBuild, PRTE2_Common, dops, prte2, ut;

EXPORT Proc_Build_Keys(string filedate) := FUNCTION

	/* MAC_SK_BuildProcess_v2_local definitions */
	OUTPUT('TEST');
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Salestax_CA_Bdid_Key,
	Constants.Key_Salestax_CA_Bdid_Gen_Name,
	Constants.SALES_TAX_PREFIX+filedate+Constants.CA_State_DBID_Suffix, 
	Salestax_CA_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Salestax_CA_Linkids_Key,
	Constants.Key_Salestax_CA_Linkids_Gen_Name,
	Constants.SALES_TAX_PREFIX+filedate+Constants.CA_State_Linkids_Suffix, 
	Salestax_CA_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_FDIC_Bdid_Key,
	Constants.Key_FDIC_Bdid_Gen_Name,
	Constants.FDIC_PREFIX+filedate+Constants.BDID_SUFFIX, 
	FDIC_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_FDIC_Linkids_Key,
	Constants.Key_FDIC_Linkids_Gen_Name,
	Constants.FDIC_PREFIX+filedate+Constants.LINKIDS_SUFFIX, 
	FDIC_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Salestax_IA_Bdid_Key,
	Constants.Key_Salestax_IA_Bdid_Gen_Name,
	Constants.SALES_TAX_PREFIX+filedate+Constants.IA_State_DBID_Suffix, 
	Salestax_IA_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Salestax_IA_Linkids_Key,
	Constants.Key_Salestax_IA_Linkids_Gen_Name,
	Constants.SALES_TAX_PREFIX+filedate+Constants.IA_State_Linkids_Suffix,
	Salestax_IA_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Irsnonprofit_Bdid_Key,
	Constants.Key_Irsnonprofit_Bdid_Gen_Name,
	Constants.Irsnonprofit_PREFIX+filedate+Constants.BDID_SUFFIX, 
	Irsnonprofit_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_Irsnonprofit_Linkids_Key,
	Constants.Key_Irsnonprofit_Linkids_Gen_Name,
	Constants.Irsnonprofit_PREFIX+filedate+Constants.LINKIDS_SUFFIX, 
	Irsnonprofit_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_ms_workers_comp_Bdid_Key,
	Constants.Key_ms_workers_comp_Bdid_Gen_Name,
	Constants.ms_workers_comp_PREFIX+filedate+Constants.BDID_SUFFIX, 
	ms_workers_comp_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_ms_workers_comp_Linkids_Key,
	Constants.Key_ms_workers_comp_Linkids_Gen_Name,
	Constants.ms_workers_comp_PREFIX+filedate+Constants.LINKIDS_SUFFIX, 
	ms_workers_comp_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_or_workers_comp_Bdid_Key,
	Constants.Key_or_workers_comp_Bdid_Gen_Name,
	Constants.or_workers_comp_PREFIX+filedate+Constants.BDID_SUFFIX, 
	or_workers_comp_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_or_workers_comp_Linkids_Key,
	Constants.Key_or_workers_comp_Linkids_Gen_Name,
	Constants.or_workers_comp_PREFIX+filedate+Constants.LINKIDS_SUFFIX, 
	or_workers_comp_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_sec_broker_dealer_Linkids_Key,
	Constants.Key_sec_broker_dealer_Linkids_Gen_Name,
	Constants.sec_broker_dealer_PREFIX+filedate+Constants.LINKIDS_SUFFIX, 
	sec_broker_dealer_Linkids_Name_Key);
	
	/* MAC_SK_Move_To_Built_V2 definitions */

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Salestax_CA_Bdid_Gen_Name, 
	Constants.SALES_TAX_PREFIX+filedate+Constants.CA_State_DBID_Suffix,
	mv_Salestax_CA_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Salestax_CA_Linkids_Gen_Name, 
	Constants.SALES_TAX_PREFIX+filedate+Constants.CA_State_Linkids_Suffix,
	mv_Salestax_CA_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_FDIC_Bdid_Gen_Name, 
	Constants.FDIC_PREFIX+filedate+Constants.BDID_SUFFIX,
	mv_FDIC_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_FDIC_Linkids_Gen_Name, 
	Constants.FDIC_PREFIX+filedate+Constants.LINKIDS_SUFFIX,
	mv_FDIC_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Salestax_IA_Bdid_Gen_Name, 
	Constants.SALES_TAX_PREFIX+filedate+Constants.IA_State_DBID_Suffix,
	mv_Salestax_IA_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Salestax_IA_Linkids_Gen_Name, 
	Constants.SALES_TAX_PREFIX+filedate+Constants.IA_State_Linkids_Suffix,
	mv_Salestax_IA_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Irsnonprofit_Bdid_Gen_Name, 
	Constants.Irsnonprofit_PREFIX+filedate+Constants.BDID_SUFFIX,
	mv_Irsnonprofit_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Irsnonprofit_Linkids_Gen_Name, 
	Constants.Irsnonprofit_PREFIX+filedate+Constants.LINKIDS_SUFFIX,
	mv_Irsnonprofit_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_ms_workers_comp_Bdid_Gen_Name, 
	Constants.ms_workers_comp_PREFIX+filedate+Constants.BDID_SUFFIX,
	mv_ms_workers_comp_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_ms_workers_comp_Linkids_Gen_Name, 
	Constants.ms_workers_comp_PREFIX+filedate+Constants.LINKIDS_SUFFIX,
	mv_ms_workers_comp_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_or_workers_comp_Bdid_Gen_Name, 
	Constants.or_workers_comp_PREFIX+filedate+Constants.BDID_SUFFIX,
	mv_or_workers_comp_Bdid_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_or_workers_comp_Linkids_Gen_Name, 
	Constants.or_workers_comp_PREFIX+filedate+Constants.LINKIDS_SUFFIX,
	mv_or_workers_comp_Linkids_Name_Key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_sec_broker_dealer_Linkids_Gen_Name, 
	Constants.sec_broker_dealer_PREFIX+filedate+Constants.LINKIDS_SUFFIX,
	mv_sec_broker_dealer_Linkids_Name_Key);
	
	/* MAC_SK_Move_v2 definitions */ 	

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Salestax_CA_Bdid_Gen_Name, 
	'Q', 
	mv_Salestax_CA_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Salestax_CA_Linkids_Gen_Name, 
	'Q', 
	mv_Salestax_CA_Linkids_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_FDIC_Bdid_Gen_Name, 
	'Q', 
	mv_FDIC_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_FDIC_Linkids_Gen_Name, 
	'Q', 
	mv_FDIC_Linkids_Name_Key_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Salestax_IA_Bdid_Gen_Name, 
	'Q', 
	mv_Salestax_IA_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Salestax_IA_Linkids_Gen_Name, 
	'Q', 
	mv_Salestax_IA_Linkids_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Irsnonprofit_Bdid_Gen_Name, 
	'Q', 
	mv_Irsnonprofit_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Irsnonprofit_Linkids_Gen_Name, 
	'Q', 
	mv_Irsnonprofit_Linkids_Name_Key_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_ms_workers_comp_Bdid_Gen_Name, 
	'Q', 
	mv_ms_workers_comp_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_ms_workers_comp_Linkids_Gen_Name, 
	'Q', 
	mv_ms_workers_comp_Linkids_Name_Key_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_or_workers_comp_Bdid_Gen_Name, 
	'Q', 
	mv_or_workers_comp_Bdid_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_or_workers_comp_Linkids_Gen_Name, 
	'Q', 
	mv_or_workers_comp_Linkids_Name_Key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_sec_broker_dealer_Linkids_Gen_Name, 
	'Q', 
	mv_sec_broker_dealer_Linkids_Name_Key_qa);

/* Key Validation */ 
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate 
														,prte2.constants.ipaddr_prod  //prod ip
														,prte2.constants.ipaddr_roxie_nonfcra //'10.173.101.101' //nonfcra Roxie ip
														,'GovdataKeys' 
														,'N'),
										 named('GovdataKeysValidation'));
										
	//---------- making DOPS optional and only in PROD build -------------------------------
	emailTo							:= '';
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('GovdataKeys', filedate, notifyEmail,
		l_inloc := 'B', // B = Boca, A = Alpharetta
		l_inenvment := 'N', // N = Non-FCRA, F = FCRA
		l_includeboolean := 'N'); // N
	updateorbit					:= Orbit3.proc_Orbit3_CreateBuild('PRTE-Govdata', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);

	
	RETURN sequential(
		PARALLEL(Salestax_CA_Bdid_Name_Key, Salestax_CA_Linkids_Name_Key, FDIC_Bdid_Name_Key, FDIC_Linkids_Name_Key, Salestax_IA_Bdid_Name_Key, Salestax_IA_Linkids_Name_Key, Irsnonprofit_Bdid_Name_Key, Irsnonprofit_Linkids_Name_Key, ms_workers_comp_Bdid_Name_Key, ms_workers_comp_Linkids_Name_Key, or_workers_comp_Bdid_Name_Key, or_workers_comp_Linkids_Name_Key, sec_broker_dealer_Linkids_Name_Key)
		,PARALLEL(mv_Salestax_CA_Bdid_Name_Key, mv_Salestax_CA_Linkids_Name_Key, mv_FDIC_Bdid_Name_Key, mv_FDIC_Linkids_Name_Key, mv_Salestax_IA_Bdid_Name_Key, mv_Salestax_IA_Linkids_Name_Key, mv_Irsnonprofit_Bdid_Name_Key, mv_Irsnonprofit_Linkids_Name_Key, mv_ms_workers_comp_Bdid_Name_Key, mv_ms_workers_comp_Linkids_Name_Key, mv_or_workers_comp_Bdid_Name_Key, mv_or_workers_comp_Linkids_Name_Key, mv_sec_broker_dealer_Linkids_Name_Key)
		,PARALLEL(mv_Salestax_CA_Bdid_Name_Key_qa, mv_Salestax_CA_Linkids_Name_Key_qa, mv_FDIC_Bdid_Name_Key_qa, mv_FDIC_Linkids_Name_Key_qa, mv_Salestax_IA_Bdid_Name_Key_qa, mv_Salestax_IA_Linkids_Name_Key_qa, mv_Irsnonprofit_Bdid_Name_Key_qa, mv_Irsnonprofit_Linkids_Name_Key_qa, mv_ms_workers_comp_Bdid_Name_Key_qa, mv_ms_workers_comp_Linkids_Name_Key_qa, mv_or_workers_comp_Bdid_Name_Key_qa, mv_or_workers_comp_Linkids_Name_Key_qa, mv_sec_broker_dealer_Linkids_Name_Key_qa)
		,key_validation
		,updatedops
		,updateorbit
	);
	
END;