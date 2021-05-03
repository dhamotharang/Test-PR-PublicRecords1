IMPORT PRTE, PRTE2, PRTE2_Business_Risk, PRTE2_Common, roxiekeybuild, ut, VersionControl, _control, Orbit3, dops;

EXPORT proc_build_keys (string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION

//Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Business_Risk.Keys.address_siccode, 
                                           Constants.KEY_PREFIX + 'address_siccode', Constants.KEY_PREFIX + filedate +'::address_siccode', addr_sic_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Business_Risk.Keys.Business_Risk_bdid, 
                                           Constants.KEY_PREFIX + 'business_risk_bdid', Constants.KEY_PREFIX + filedate +'::business_risk_bdid', bus_bdid_key);                                           

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Business_Risk.Keys.hri_address_siccode, 
                                           Constants.KEY_PREFIX + 'hri::address_siccode', Constants.KEY_PREFIX + filedate +'::hri::address_siccode', hri_addr_sic_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Business_Risk.Keys.hri_address, 
                                           Constants.KEY_PREFIX + 'hri::address', Constants.KEY_PREFIX + filedate +'::hri::address', hri_addr_key);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(PRTE2_Business_Risk.Keys.hri_sic, 
                                           Constants.KEY_PREFIX + 'hri::sic.z5', Constants.KEY_PREFIX + filedate +'::hri::sic.z5', hri_sic_key);

build_roxie_keys := parallel(
                              addr_sic_key, 
                              bus_bdid_key, 
                              hri_addr_sic_key, 
                              hri_addr_key, 
                              hri_sic_key
                            );


//Move Keys
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::address_siccode', 
                                      Constants.KEY_PREFIX + filedate +'::address_siccode', mv_addr_sic_key);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::business_risk_bdid', 
                                      Constants.KEY_PREFIX + filedate +'::business_risk_bdid', mv_bus_bdid_key);
                                      
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::hri::address_siccode', 
                                      Constants.KEY_PREFIX + filedate +'::hri::address_siccode', mv_hri_addr_sic_key);                                      
                                      
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::hri::address', 
                                      Constants.KEY_PREFIX + filedate +'::hri::address', mv_hri_addr_key);  

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::hri::sic.z5', 
                                      Constants.KEY_PREFIX + filedate +'::hri::sic.z5', mv_hri_sic_key); 
                                      
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::business_risk_geolink', 
                                      Constants.KEY_PREFIX + filedate +'::business_risk_geolink', mv_risk_geo_key); 
                                      
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Constants.KEY_PREFIX + '@version@::siccode_description', 
                                      Constants.KEY_PREFIX + filedate +'::siccode_description', mv_sic_desc_key);                                        

move_keys := parallel(
                       mv_addr_sic_key, 
                       mv_bus_bdid_key, 
                       mv_hri_addr_sic_key, 
                       mv_hri_addr_key, 
                       mv_hri_sic_key, 
                       mv_risk_geo_key, 
                       mv_sic_desc_key
                     );


//Move to QA
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::address_siccode','Q', mv_addr_sic_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::business_risk_bdid','Q', mv_bus_bdid_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::hri::address_siccode','Q', mv_hri_addr_sic_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::hri::address','Q', mv_hri_addr_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::hri::sic.z5','Q', mv_hri_sic_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::business_risk_geolink','Q', mv_risk_geo_QA);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.KEY_PREFIX + '@version@::siccode_description','Q', mv_sic_desc_QA);

move_to_qa	:= parallel(
                         mv_addr_sic_QA, 
                         mv_bus_bdid_QA, 
                         mv_hri_addr_sic_QA, 
                         mv_hri_addr_QA, 
                         mv_hri_sic_QA, 
                         mv_risk_geo_QA, 
                         mv_sic_desc_QA
                       );


//Make a copy of Prod key for prte::key::neighborhood::crime::geolink key
copy_key  := PRTE2_Business_Risk.Copy_Files(filedate);

//---------- making DOPS optional and only in PROD build -------------------------------

  NoUpdate           := OUTPUT('Skipping DOPS update because we are not in PROD');
  updatedops         := PRTE.UpdateVersion('AddressHRIKeys', filedate, _control.MyInfo.EmailAddressNormal, l_inloc:='B', l_inenvment:='N', l_includeboolean := 'N');
  is_running_in_prod := PRTE2_Common.Constants.is_running_in_prod;
  PerformUpdateOrNot := IF(is_running_in_prod, updatedops, NoUpdate);
  orbit_update       := Orbit3.proc_Orbit3_CreateBuild('PRTE - AddressHRIKeys', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);
  Key_Validation     := output(dops.ValidatePRCTFileLayout(filedate, /*Dataland IP*/ prte2.constants.ipaddr_dataland, /*Prod IP*/ prte2.constants.ipaddr_prod, 'AddressHRIKeys', 'N'));

//Actions
buildKey  :=  sequential(
                          build_roxie_keys,
                          copy_key,
                          move_keys,
                          move_to_qa,
                          PerformUpdateOrNot,
                          ORBIT_Update,
                          Key_Validation
                        );

RETURN  buildKey;
END;