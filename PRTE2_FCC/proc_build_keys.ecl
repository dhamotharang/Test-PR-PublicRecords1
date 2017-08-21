IMPORT PRTE, PRTE2_FCC, PRTE2_Common, roxiekeybuild, ut, AutoKeyB2, promotesupers, VersionControl, _control;

EXPORT proc_build_keys (string filedate) := FUNCTION

//Build Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_FCC.Keys.FCC_BDID,Constants.KEY_PREFIX + 'bdid',Constants.KEY_PREFIX + filedate +'::bdid',bdid_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_FCC.Keys.FCC_DID,Constants.KEY_PREFIX + 'did',Constants.KEY_PREFIX + filedate +'::did',did_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_FCC.Keys.FCC_seq,Constants.KEY_PREFIX + 'seq',Constants.KEY_PREFIX + filedate +'::seq',seq_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_FCC.Keys.FCC_Linkids.key,Constants.KEY_PREFIX + 'linkids',Constants.KEY_PREFIX + filedate +'::linkids',linkid_key);

Build_Keys	:= parallel(bdid_key, did_key, seq_key, linkid_key);

//Move Key
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::bdid', Constants.KEY_PREFIX + filedate +'::bdid',mv_bdid_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate +'::did',mv_did_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::seq', Constants.KEY_PREFIX + filedate +'::seq',mv_seq_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::linkids', Constants.KEY_PREFIX + filedate +'::linkids',mv_linkid_key);

Move_Keys	:= parallel(mv_bdid_key, mv_did_key, mv_seq_key, mv_linkid_key);

//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::bdid','Q', mv_bdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::seq','Q', mv_seq_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::linkids','Q', mv_linkid_QA);

To_QA	:= parallel(mv_bdid_QA, mv_did_QA, mv_seq_QA, mv_linkid_QA);

//Build Autokeys
	b := Files.AK_search_file;

	AutoKeyB2.MAC_Build (b,
					name.name_first,name.name_middle,name.name_last,
					zero,
					zero,
					phone.phone10,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,
					DID,
					company,
					zero,
					phone.phone10,
					addr.prim_name,addr.prim_range,addr.st,addr.v_city_name,addr.zip5,addr.sec_range,
					bdid,
					Constants.ak_keyname,
					Constants.ak_logical(filedate),
					outaction, false,
					Constants.ak_skipSet,true,Constants.ak_typeStr,
					true,,,zero);

	AutoKeyB2.MAC_AcceptSK_to_QA(Constants.ak_keyname, mymove,, Constants.ak_skipSet)

	build_autokeys := sequential(outaction,mymove);
	
		//---------- making DOPS optional and only in PROD build -------------------------------
	is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD'); 
	updatedops					:=	PRTE.UpdateVersion('FCCKeys', filedate, _control.MyInfo.EmailAddressNormal,'B','N','N');
	PerformUpdateOrNot	:= IF(is_running_in_prod,updatedops,NoUpdate);

// -- Actions
buildKeys	:=	sequential(Build_Keys
												,Move_Keys
												,To_QA
												,build_autokeys
												,PerformUpdateOrNot
												);
									
RETURN	buildKeys;
END;
