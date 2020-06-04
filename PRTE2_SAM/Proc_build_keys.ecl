IMPORT DOPs, BIPV2, RoxieKeyBuild, AutoKeyB2, PRTE2, PRTE, _control, autokeyb, Business_Header_SS, business_header, ut, corp2, doxie, address, corp2_services, Orbit3, PRTE2_Common;

EXPORT proc_build_keys(string filedate) := FUNCTION

  //Build Key
  RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.linkids.key,
                                             constants.key_prefix + '@version@::linkids',
                                             constants.key_prefix + filedate + '::linkids', 
                                             build_key_SAM_lnk_key);
  //Move to Built                                           
  RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + 'linkids',
                                        constants.key_prefix + filedate + '::linkids',
                                        move_built_key_SAM_lnk_key);    

  //Move to QA                                      
  RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::linkids',
                               'Q',
                               move_qa_key_SAM_lnk_key);    
                               
  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('SAMKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE-SAM', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'SAMKeys', 'N')); 

  RETURN     SEQUENTIAL(
                        //Build Keys
                        build_key_SAM_lnk_key,

                        //Move to Built
                        move_built_key_SAM_lnk_key,

                        //Move to QA
                        move_qa_key_SAM_lnk_key,
                       
                        //Update DOPs         
                        PerformUpdateOrNot,
                        orbit_update,
                        Key_Validation);

END;