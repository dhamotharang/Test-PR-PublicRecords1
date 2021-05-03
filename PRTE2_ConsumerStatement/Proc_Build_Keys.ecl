IMPORT PRTE, PRTE2, PRTE2_ConsumerStatement, PRTE2_Common, roxiekeybuild, ut, VersionControl, _control, Orbit3, dops;

EXPORT proc_build_keys (string filedate) := FUNCTION

// Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_address, Constants.KEY_PREFIX + 'Address', Constants.KEY_PREFIX + filedate +'::Address', Address_Key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_phone, Constants.KEY_PREFIX + 'Phone', Constants.KEY_PREFIX + filedate +'::Phone', Phone_Key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_statementID, Constants.KEY_PREFIX + 'Statement_ID', Constants.KEY_PREFIX + filedate +'::Statement_ID', statementID_Key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_LexID, Constants.FCRA_KEY_PREFIX + 'LexID', Constants.FCRA_KEY_PREFIX + filedate +'::LexID', FCRA_LexID_Key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(keys.key_SSN, Constants.FCRA_KEY_PREFIX + 'SSN', Constants.FCRA_KEY_PREFIX + filedate +'::SSN', FCRA_SSN_Key);

build_roxie_keys := parallel(
                             Address_Key,
                             Phone_Key,
                             StatementID_Key,
                             FCRA_LexID_Key,
                             FCRA_SSN_Key
                            );

// Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::Address', Constants.KEY_PREFIX + filedate +'::Address', mv_Address_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::Phone', Constants.KEY_PREFIX + filedate +'::Phone', mv_Phone_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::Statement_ID', Constants.KEY_PREFIX + filedate +'::Statement_ID', mv_StatementID_Key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.FCRA_KEY_PREFIX + '@version@::LexID', Constants.FCRA_KEY_PREFIX + filedate +'::LexID', mv_FCRA_LexID_Key);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.FCRA_KEY_PREFIX + '@version@::SSN', Constants.FCRA_KEY_PREFIX + filedate +'::SSN', mv_FCRA_SSN_Key);

move_keys	:=	parallel(
                        mv_Address_Key,
                        mv_Phone_Key,
                        mv_StatementID_Key,
                        mv_FCRA_LexID_Key,
                        mv_FCRA_SSN_Key
                       );

// Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::Address','Q', mv_Address_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::Phone','Q', mv_Phone_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::Statement_ID','Q', mv_StatementID_QA);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.FCRA_KEY_PREFIX + '@version@::LexID','Q', mv_FCRA_LexID_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.FCRA_KEY_PREFIX + '@version@::SSN','Q', mv_FCRA_SSN_QA);

move_to_qa	:=	parallel(
                        mv_Address_QA,
                        mv_Phone_QA,
                        mv_StatementID_QA,
                        mv_FCRA_LexID_QA,
                        mv_FCRA_SSN_QA
                       );


// ---------- making DOPS optional and only in PROD build -------------------------------

  NoUpdate            := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops          := PRTE.UpdateVersion('ConsumerStatementKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  fcra_updatedops     := PRTE.UpdateVersion('FCRA_ConsmrStmtKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  is_running_in_prod  := PRTE2_Common.Constants.is_running_in_prod;
  PerformUpdateOrNot  := IF(is_running_in_prod, parallel(updatedops,fcra_updatedops), NoUpdate);
  orbit_update        := Orbit3.proc_Orbit3_CreateBuild('PRTE - ConsumerStatementKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  orbit_update_FCRA   := Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_ConsmrStmtKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation      := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'ConsumerStatementKeys', 'N'));
  fcra_Key_Validation := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_roxie_nonfcra, 'FCRA_ConsmrStmtKeys', 'F'));

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


