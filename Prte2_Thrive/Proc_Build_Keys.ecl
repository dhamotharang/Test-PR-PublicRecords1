IMPORT PRTE2_Common, PRTE2_Thrive, PRTE, PRTE2, BIPV2, DOPs, RoxieKeyBuild, _control, ut, doxie, Orbit3;

EXPORT proc_build_keys(string filedate) := FUNCTION

//Build Keys
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Thrive_did_key,
                                           constants.key_prefix + '@version@::did',
                                           constants.key_prefix + filedate + '::did', 
                                           build_key_Thrive_did);

//Move to Built
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + '@version@::did',
                                      constants.key_prefix + filedate + '::did',
                                      move_built_key_Thrive_did);


//Move to QA
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::did',
                            'Q',
                             move_qa_key_cortera_Thrive_did);


  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('Thrive', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE-Thrive', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'ThriveKeys', 'N'));


 RETURN     SEQUENTIAL(
                       //Build Keys
                       parallel(
                                build_key_Thrive_did);

                       //Move to Built
                       Parallel(
                                move_built_key_Thrive_did);

                       //Move to QA
                       Parallel(
                                move_qa_key_cortera_Thrive_did),
                       
                       //Update DOPs         
                                PerformUpdateOrNot,
                                orbit_update,
                                Key_Validation);

END;