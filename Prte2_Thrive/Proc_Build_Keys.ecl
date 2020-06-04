IMPORT PRTE2_Common, PRTE2_Thrive, PRTE, PRTE2, BIPV2, DOPs, RoxieKeyBuild, _control, ut, doxie, Orbit3, strata;

EXPORT proc_build_keys(string filedate) := FUNCTION

//Build Keys
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Thrive_did_key,
                                           constants.key_prefix + '@version@::did',
                                           constants.key_prefix + filedate + '::did', 
                                           build_key_Thrive_did);
                                           
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(keys.Thrive_fcra_did_key,
                                           constants.fcra_key_prefix + '@version@::did',
                                           constants.fcra_key_prefix + filedate + '::did',
                                           build_key_Thrive_fcra_did);                                           

//Move to Built
RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.key_prefix + '@version@::did',
                                      constants.key_prefix + filedate + '::did',
                                      move_built_key_Thrive_did);

RoxieKeyBuild.MAC_SK_Move_To_Built_V2(constants.fcra_key_prefix + '@version@::did',
                                      constants.fcra_key_prefix + filedate + '::did',
                                      move_built_key_fcra_Thrive_did);
                                      
//Move to QA
RoxieKeyBuild.MAC_SK_Move_v2(constants.key_prefix + '@version@::did',
                            'Q',
                             move_qa_key_Thrive_did);
                             
RoxieKeyBuild.MAC_SK_Move_v2(constants.fcra_key_prefix + '@version@::did',
                            'Q',
                             move_qa_key_fcra_Thrive_did);                             


  is_running_in_prod  := PRTE2_Common.Constants.is_running_in_prod;
  NoUpdate            := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops          := PRTE.UpdateVersion('ThriveKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  fcra_updatedops     := PRTE.UpdateVersion('FCRA_ThriveKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
  PerformUpdateOrNot  := IF(is_running_in_prod, parallel(updatedops,fcra_updatedops), NoUpdate);
  orbit_update        := Orbit3.proc_Orbit3_CreateBuild('PRTE - ThriveKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  orbit_update_FCRA   := Orbit3.proc_Orbit3_CreateBuild('PRTE - FCRA_ThriveKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation      := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_prod, 'ThriveKeys', 'N'));
  fcra_Key_Validation := OUTPUT(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ '10.173.14.204', /*Prod IP*/ prte2.constants.ipaddr_roxie_nonfcra, 'FCRA_ThriveKeys', 'F'));
  cnt_thrive_fcra     := OUTPUT(strata.macf_pops(PRTE2_Thrive.keys.Thrive_fcra_did_key,,,,,,FALSE,
                               ['phone_work,phone_home,phone_cell,monthsemployed,own_home,is_military,drvlic_state,monthsatbank,ip,yrsthere,' +
                               'besttime,credit,loanamt,loantype,ratetype,mortrate,ltv,propertytype,datecollected,title,fips_st,fips_county,' +
                               'clean_phone_work,clean_phone_home,clean_phone_cell']), named('cnt_thrive_fcra'));

 RETURN SEQUENTIAL(
                    //Build Keys
                      parallel(
                      build_key_Thrive_did,
                      build_key_Thrive_fcra_did),

                    //Move to Built
                      parallel(
                      move_built_key_Thrive_did,
                      move_built_key_fcra_Thrive_did),

                    //Move to QA
                      parallel(
                      move_qa_key_Thrive_did,
                      move_qa_key_fcra_Thrive_did),
                      
                    //Count
                      cnt_thrive_fcra,
                      
                      Parallel(
                      key_validation, 
                      fcra_key_validation),
                      PerformUpdateOrnot,
                      
                      Parallel(
                      orbit_update, 
                      orbit_update_fcra));
END;