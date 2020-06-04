IMPORT PRTE2_Common, BIPV2, DOPs, RoxieKeyBuild, PRTE2, PRTE, _control, ut, doxie, Orbit3;

EXPORT proc_build_keys(string filedate) := FUNCTION

//Build Key
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.AddressKey,
                                           constants.key_prefix + '@version@::address',
                                           constants.key_prefix + filedate + '::address', 
                                           build_key_Targus_Addresskey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.DIDKey,
                                           constants.key_prefix + '@version@::did',
                                           constants.key_prefix + filedate + '::did', 
                                           build_key_Targus_DIDKey);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.PhoneKey,
                                           constants.key_prefix + '@version@::p7.p3.st',
                                           constants.key_prefix + filedate + '::p7.p3.st', 
                                           build_key_Targus_Phonekey);
                                           
//Move to BUILT   
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + 'Address',
                                      constants.key_prefix + filedate + '::Address',
                                      move_built_key_Targus_Addresskey);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + 'did',
                                      constants.key_prefix + filedate + '::did',
                                      move_built_key_Targus_DIDkey);
                                        
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + 'p7.p3.st',
                                      constants.key_prefix + filedate + '::p7.p3.st',
                                      move_built_key_Targus_Phonekey);    
                                      
//Move to QA 
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::Address',
                             'Q',
                             move_qa_key_Targus_Addresskey);

RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::did',
                             'Q',
                             move_qa_key_Targus_DIDkey);
                             
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::p7.p3.st',
                             'Q',
                             move_qa_key_Targus_Phonekey);    
                             
                             
  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('TargusKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE-Targus', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'TargusKeys', 'N'));

 RETURN     SEQUENTIAL(
                       //Build Keys
                       parallel(
                                build_key_Targus_Addresskey,
                                build_key_Targus_DIDkey,
                                build_key_Targus_Phonekey);

                       //Move to Built
                       Parallel(
                                move_built_key_Targus_Addresskey,
                                move_built_key_Targus_DIDKey,
                                move_built_key_Targus_Phonekey);

                       //Move to QA
                       Parallel(
                                move_qa_key_Targus_Addresskey,
                                move_qa_key_Targus_DIDKey,
                                move_qa_key_Targus_Phonekey);
                       
                       // Update DOPs         
                                PerformUpdateOrNot,
                                orbit_update,
                                Key_Validation);

END;