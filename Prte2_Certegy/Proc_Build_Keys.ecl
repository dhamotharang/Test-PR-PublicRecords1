IMPORT PRTE2_Common, PRTE2_Certegy, BIPV2, DOPs, RoxieKeyBuild, PRTE2, PRTE, _control, ut, doxie, Orbit3;

EXPORT proc_build_keys(string filedate) := FUNCTION

//Build Keys
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.key_certegy_did,
                                           constants.key_prefix + '@version@::did',
                                           constants.key_prefix + filedate + '::did', 
                                           build_certegy_did_key);
//Move to Built
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + '@version@::did',
                                      constants.key_prefix + filedate + '::did',
                                      move_built_certegy_did_key);

//Move to QA
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::did', 'Q',
                             move_qa_certegy_did_key);


  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('CertegyKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE-Certegy', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_roxie_nonfcra, 'CertegyKeys', 'N'));

 RETURN     SEQUENTIAL(
                       //Build Keys
                                build_certegy_did_key,

                       //Move to Built
                                move_built_certegy_did_key,

                       //Move to QA
                                move_qa_certegy_did_key,
                       
                       //Update DOPs         
                                Key_Validation,                                
                                PerformUpdateOrNot,
                                orbit_update);

END;