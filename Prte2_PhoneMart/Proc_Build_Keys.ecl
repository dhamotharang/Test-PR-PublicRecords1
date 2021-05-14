IMPORT PRTE, PRTE2, PRTE2_PhoneMart, PRTE2_Common, roxiekeybuild, ut, VersionControl, _control, Orbit3, dops;

EXPORT proc_build_keys (string filedate) := FUNCTION

//Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhoneMart.Keys.did_key, Constants.KEY_PREFIX + 'did', Constants.KEY_PREFIX + filedate +'::did', DID_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_PhoneMart.Keys.phone_key, Constants.KEY_PREFIX + 'phone', Constants.KEY_PREFIX + filedate +'::phone', Phone_key);

build_roxie_keys := parallel(DID_key, Phone_key);


//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::did', Constants.KEY_PREFIX + filedate +'::did',mv_DID_key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::phone', Constants.KEY_PREFIX + filedate +'::phone',mv_Phone_key);

move_keys	:=	parallel(mv_DID_key, mv_Phone_key);


//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::did','Q', mv_DID_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::phone','Q', mv_Phone_QA);

move_to_qa	:=	parallel(mv_DID_QA, mv_Phone_QA);


//---------- making DOPS optional and only in PROD build -------------------------------
  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('PhoneMartKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - PhoneMartKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'PhoneMartKeys', 'N'));

// -- Actions
buildKey := sequential(
                        build_roxie_keys,
                        move_keys,
                        move_to_qa,
                        Key_Validation,
                        PerformUpdateOrNot,
                        ORBIT_Update
                      );
RETURN  buildKey;
END;


