import versioncontrol, doxie, BBB2, Data_Services, BIPV2, PRTE, _control, Orbit3, RoxieKeyBuild, PRTE2_Common, dops, prte2, ut, _control;

export Proc_Build_Keys(string filedate) := FUNCTION

/* MAC_SK_BuildProcess_v2_local definitions */

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_BBB_Member_BDID,
	Constants.Key_BBB_Member_BDID_Gen_Name,
	Constants.KEY_PREFIX + filedate + Constants.Memeber_Bdid_suffix, member_bdid_key);
		
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_BBB_Non_Member_BDID,
	Constants.Key_BBB_Non_Member_BDID_Gen_Name,
	Constants.KEY_PREFIX + filedate + Constants.Nonmember_Bdid_suffix, nonmember_bdid_key);	
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_BBB_Member_LinkIds,
	Constants.Key_BBB_Member_LinkIds_Gen_Name,
	Constants.KEY_PREFIX + filedate + Constants.Member_Linkids_Suffix, member_linkid_key);
	
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Keys.Key_BBB_Non_Member_LinkIds,
	Constants.Key_BBB_Non_Member_LinkIds_Gen_Name,
	Constants.KEY_PREFIX + filedate + Constants.Nonmember_Linkids_Suffix, nonmember_linkid_key);
	
/* MAC_SK_Move_To_Built_V2 definitions */

	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_BBB_Member_BDID_Gen_Name, 
	Constants.KEY_PREFIX + filedate + Constants.Memeber_Bdid_suffix,
	mv_member_bdid_key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_BBB_Non_Member_BDID_Gen_Name, 
	Constants.KEY_PREFIX + filedate + Constants.Nonmember_Bdid_suffix,
	mv_nonmember_bdid_key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_BBB_Member_LinkIds_Gen_Name, 
	Constants.KEY_PREFIX + filedate + Constants.Member_Linkids_Suffix,
	mv_member_linkid_key);
	
	RoxieKeyBuild.MAC_SK_Move_To_Built_V2(Constants.Key_BBB_Non_Member_LinkIds_Gen_Name, 
	Constants.KEY_PREFIX + filedate + Constants.Nonmember_Linkids_Suffix,
	mv_nonmember_linkid_key);
	
/* MAC_SK_Move_v2 definitions */ 	
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_BBB_Member_BDID_Gen_Name, 
	'Q', 
	mv_member_bdid_key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_BBB_Non_Member_BDID_Gen_Name, 
	'Q', 
	mv_nonmember_bdid_key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_BBB_Member_LinkIds_Gen_Name, 
	'Q', 
	mv_member_linkid_key_qa);
	
	RoxieKeyBuild.MAC_SK_Move_v2(Constants.Key_BBB_Non_Member_LinkIds_Gen_Name, 
	'Q', 
	mv_nonmember_linkid_key_qa);

/* Key Validation */ 
	
	key_validation :=  output(dops.ValidatePRCTFileLayout(filedate 
														,prte2.constants.ipaddr_prod  //prod ip
														,/*prte2.constants.ipaddr_roxie_nonfcra*/ '10.173.101.101' //nonfcra Roxie ip
														,'BBBKeys' 
														,'N'),
										 named('BBBKeysValidation'));
										
	//---------- making DOPS optional and only in PROD build -------------------------------
	emailTo							:= '';
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:= PRTE.UpdateVersion('BBBKeys', filedate, notifyEmail,
		l_inloc := 'B', // B = Boca, A = Alpharetta
		l_inenvment := 'N', // N = Non-FCRA, F = FCRA
		l_includeboolean := 'N'); // N
	updateorbit					:= Orbit3.proc_Orbit3_CreateBuild('PRTE-BBB', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);

	
	RETURN SEQUENTIAL(
		PARALLEL(member_bdid_key, nonmember_bdid_key, member_linkid_key, nonmember_linkid_key)
		,PARALLEL(mv_member_bdid_key, mv_nonmember_bdid_key, mv_member_linkid_key, mv_nonmember_linkid_key)
		,PARALLEL(mv_member_bdid_key_qa, mv_nonmember_bdid_key_qa, mv_member_linkid_key_qa, mv_nonmember_linkid_key_qa)
		,key_validation
		,updatedops
		,updateorbit
	);
	
END;