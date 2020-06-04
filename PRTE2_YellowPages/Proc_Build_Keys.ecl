IMPORT versioncontrol, doxie, YellowPages, Data_Services, BIPV2, PRTE, _control, Orbit3, RoxieKeyBuild, PRTE2_Common, dops, prte2, ut, AutoKeyB2;

EXPORT Proc_Build_Keys(string filedate) := FUNCTION

/* MAC_SK_BuildProcess_v2_local definitions */
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_YellowPages_Bdid,
	Constants.Key_Bdid_Gen_Name,
    constants.key_prefix + filedate + Constants.BDID_SUFFIX,
	YellowPages_Bdid_Key);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_YellowPages_Linkids,
	Constants.Key_Linkids_Gen_Name,
	Constants.KEY_PREFIX+filedate+Constants.Linkids_SUFFIX, 
	YellowPages_Linkids_Key);

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_YellowPages_Phone,
	Constants.Key_Phone_Gen_Name,
	Constants.KEY_PREFIX+filedate+Constants.Phone_SUFFIX, 
	YellowPages_Phone_Key);
	
/* MAC_SK_Move_To_Built_V2 definitions */

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Bdid_Gen_Name,
    constants.key_prefix + filedate + Constants.BDID_SUFFIX,
	mv_YellowPages_Bdid_Key);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Linkids_Gen_Name, 
	Constants.KEY_PREFIX+filedate+Constants.Linkids_SUFFIX,
	mv_YellowPages_Linkids_Key);

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_Phone_Gen_Name, 
	Constants.KEY_PREFIX+filedate+Constants.Phone_SUFFIX,
	mv_YellowPages_Phone_Key);
	
/* MAC_SK_Move_v2 definitions */ 	

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Bdid_Gen_Name, 
	'Q', 
	mv_YellowPages_Bdid_Key_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Linkids_Gen_Name, 
	'Q', 
	mv_YellowPages_Linkids_Key_qa);

	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_Phone_Gen_Name, 
	'Q', 
	mv_YellowPages_Phone_Key_qa);

/* Key Validation */ 
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate 
														,prte2.constants.ipaddr_prod  //prod ip
														,prte2.constants.ipaddr_roxie_nonfcra //'10.173.101.101' //nonfcra Roxie ip
														,'YellowPagesKeys' 
														,'N'),
										 named('YellowPagesKeysValidation'));
										
	//---------- making DOPS optional and only in PROD build -------------------------------
	emailTo							:= '';
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('YellowPagesKeys', filedate, notifyEmail,
		l_inloc := 'B', // B = Boca, A = Alpharetta
		l_inenvment := 'N', // N = Non-FCRA, F = FCRA
		l_includeboolean := 'N'); // N
	updateorbit					:= Orbit3.proc_Orbit3_CreateBuild('PRTE - YellowPages', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);

	
	RETURN sequential(
		PARALLEL(YellowPages_Bdid_Key, YellowPages_Linkids_Key, YellowPages_Phone_Key)
		,PARALLEL(mv_YellowPages_Bdid_Key, mv_YellowPages_Linkids_Key, mv_YellowPages_Phone_Key)
		,PARALLEL(mv_YellowPages_Bdid_Key_qa, mv_YellowPages_Linkids_Key_qa, mv_YellowPages_Phone_Key_qa)
		,key_validation
		,updatedops
		,updateorbit
	);
	
END;