IMPORT PRTE, PRTE2_DNB_FEIN, PRTE2_Common, roxiekeybuild, ut, AutoKeyB2, promotesupers, VersionControl, _control;

EXPORT proc_build_keys (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
		is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
		doDOPS := is_running_in_prod AND NOT skipDOPS;

//Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_DNB_FEIN.Keys.key_DNB_Fein_BDID, Constants.KEY_PREFIX + 'bdid',Constants.KEY_PREFIX + filedate +'::bdid',bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_DNB_FEIN.Keys.key_dnb_fein_tmsid, Constants.KEY_PREFIX + 'tmsid',Constants.KEY_PREFIX + filedate +'::tmsid',tmsid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_DNB_FEIN.Keys.Key_LinkIds.key, Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkids_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_DNB_FEIN.Keys.Key_LinkIds_exp.key_exp, Constants.EXP_KEY_PREFIX + 'linkids',Constants.EXP_KEY_PREFIX + filedate +'::linkids',exp_linkids_key);

build_roxie_keys	:=	parallel(bdid_key, tmsid_key, linkids_key, exp_linkids_key);

//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate +'::bdid',mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::tmsid', Constants.KEY_PREFIX + filedate +'::tmsid',mv_tmsid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids',mv_linkids_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.EXP_KEY_PREFIX + '@version@::linkids', Constants.EXP_KEY_PREFIX + filedate +'::linkids',mv_exp_linkids_key);

move_keys	:= parallel(mv_bdid_key, mv_tmsid_key, mv_linkids_key, mv_exp_linkids_key);

//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::tmsid','Q', mv_tmsid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkids_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.EXP_KEY_PREFIX + '@version@::linkids','Q', mv_exp_linkids_QA);

move_to_qa	:= parallel(mv_bdid_QA, mv_tmsid_QA, mv_linkids_QA, mv_exp_linkids_QA);

//Build Autokeys
	autokeys(string filedate) := FUNCTION

		AutoKeyB2.MAC_Build (PRTE2_DNB_FEIN.Files.SearchAutokey,
					blank,blank,blank,
					zero,
					zero,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					zero,
					clean_cname,
					fein,
					zero,
					company_addr.prim_name,company_addr.prim_range,company_addr.st,company_addr.v_city_name,company_addr.zip5,company_addr.sec_range,
					intbdid,
					PRTE2_DNB_FEIN.Constants.ak_keyname,
					PRTE2_DNB_FEIN.Constants.ak_logical(filedate),
					outaction,false,
					['C'],true,,
					true,,,zero) 

		AutoKeyB2.MAC_AcceptSK_to_QA(PRTE2_DNB_FEIN.Constants.ak_keyname, mymove,, Constants.ak_skipSet)

		retval := sequential(outaction,mymove);

	RETURN retval;
	END;
	
//---------- making DOPS optional and only in PROD build -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('DNBFEINV2Keys', filedate, notifyEmail,'B','N','N');
	updatedops2					:=	PRTE.UpdateVersion('ExperianFEINKeys', filedate, notifyEmail,'B','N','N');
	PerformUpdateOrNot	:= IF(doDOPS,PARALLEL(updatedops,updatedops2),NoUpdate);

// -- Actions
buildKey	:=	sequential(build_roxie_keys
												,move_keys
												,move_to_qa
												,autokeys(filedate)
												,PerformUpdateOrNot
												);
									
RETURN	buildKey;
END;

