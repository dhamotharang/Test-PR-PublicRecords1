IMPORT PRTE, PRTE2, PRTE2_Infutor_CID, PRTE2_Common, roxiekeybuild, ut, VersionControl, _control, Orbit3, dops;

EXPORT proc_build_keys (string filedate) := FUNCTION

// Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Infutor_CID.keys.key_did, Constants.KEY_PREFIX + 'did', Constants.KEY_PREFIX + filedate +'::did', did_Key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Infutor_CID.keys.fcra_Key_did, Constants.FCRA_KEY_PREFIX + 'did', Constants.FCRA_KEY_PREFIX + filedate +'::did', did_fcra_Key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Infutor_CID.keys.Key_Phone, Constants.KEY_PREFIX + 'phone', Constants.KEY_PREFIX + filedate +'::phone', phone_Key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Infutor_CID.keys.fcra_Key_Phone, Constants.FCRA_KEY_PREFIX + 'phone', Constants.FCRA_KEY_PREFIX + filedate +'::phone', phone_fcra_Key);

build_roxie_keys := parallel(did_Key, did_fcra_Key, phone_Key, phone_fcra_Key);
// build_roxie_keys := parallel(did_Key);

// Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate +'::did', mv_did_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.FCRA_KEY_PREFIX + '@version@::did', Constants.FCRA_KEY_PREFIX + filedate +'::did',mv_did_fcra_Key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::phone', Constants.KEY_PREFIX + filedate +'::phone', mv_phone_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.FCRA_KEY_PREFIX + '@version@::phone', Constants.FCRA_KEY_PREFIX + filedate +'::phone',mv_phone_fcra_Key);

move_keys	:=	parallel(mv_did_Key, mv_did_fcra_Key, mv_phone_key, mv_phone_fcra_key);

// Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_did_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.FCRA_KEY_PREFIX + '@version@::did','Q', mv_fcra_did_QA);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::phone','Q', mv_phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.FCRA_KEY_PREFIX + '@version@::phone','Q', mv_fcra_phone_QA);

move_to_qa	:=	parallel(mv_did_QA, mv_fcra_did_QA, mv_phone_QA, mv_fcra_phone_QA);


// ---------- making DOPS optional and only in PROD build -------------------------------

  NoUpdate            := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops          := PRTE.UpdateVersion('InfutorcidKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  fcra_updatedops     := PRTE.UpdateVersion('FCRA_InfutorcidKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  is_running_in_prod  := PRTE2_Common.Constants.is_running_in_prod;
  PerformUpdateOrNot  := IF(is_running_in_prod, parallel(updatedops,fcra_updatedops), NoUpdate);
  orbit_update        := Orbit3.proc_Orbit3_CreateBuild('PRTE - InfutorcidKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  orbit_update_FCRA   := Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_InfutorcidKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation      := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'InfutorcidKeys', 'N'));
  fcra_Key_Validation := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_roxie_nonfcra, 'FCRA_InfutorcidKeys', 'F'));

// -- Actions
buildKey  :=  sequential(
                          build_roxie_keys,
                          move_keys,
                          move_to_qa,

																parallel(
																						Key_Validation,
																						fcra_Key_Validation),
																						PerformUpdateOrNot,

																parallel(
																						ORBIT_Update,
																						orbit_update_FCRA)
                        );
												
RETURN  buildKey;
END;


