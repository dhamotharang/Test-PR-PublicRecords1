IMPORT doxie, tools, versioncontrol, dx_FraudDefenseNetwork, RoxieKeybuild;

EXPORT Build_Keys(STRING pversion = ''
                  ,DATASET(Layouts.Base.Main)         pBaseMainBuilt			=	Files(pversion).Base.Main.Built  
                  ) := MODULE

	SHARED TheKeys := Keys(pversion, pBaseMainBuilt);
	
// ########################################################################### 
//                    ID KEY
// ##########################################################################   
   L_FILE_KEY_ID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_ID, TheKeys.BaseMain_ID, dx_FraudDefenseNetwork.Names.i_ID, L_FILE_KEY_ID, build_id);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX, L_FILE_KEY_ID, move1_id);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.ID_SUFFIX, 'Q', move2_id);

// ########################################################################### 
//                    DID KEY
// ##########################################################################   
   L_FILE_KEY_DID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_DID, TheKeys.BaseMain_DID, dx_FraudDefenseNetwork.Names.i_DID, L_FILE_KEY_DID, build_did);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX, L_FILE_KEY_DID, move1_did);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.DID_SUFFIX, 'Q', move2_did);  
	 
// ########################################################################### 
//                    EMAIL KEY
// ##########################################################################   
   L_FILE_KEY_EMAIL := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_EMAIL, TheKeys.BaseMain_Email, dx_FraudDefenseNetwork.Names.i_EMAIL, L_FILE_KEY_EMAIL, build_email);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX, L_FILE_KEY_EMAIL, move1_email);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.EMAIL_SUFFIX, 'Q', move2_email); 

// ########################################################################### 
//                    IP KEY
// ##########################################################################   
   L_FILE_KEY_IP := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_IP, TheKeys.BaseMain_IP, dx_FraudDefenseNetwork.Names.i_IP, L_FILE_KEY_IP, build_ip);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX, L_FILE_KEY_IP, move1_ip);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.IP_SUFFIX, 'Q', move2_ip);

// ########################################################################### 
//                    PROFESSIONALID KEY
// ##########################################################################   
   L_FILE_KEY_PROFESSIONALID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_PROFESSIONALID, TheKeys.BaseMain_ProfessionalID, dx_FraudDefenseNetwork.Names.i_PROFESSIONALID, L_FILE_KEY_PROFESSIONALID, build_professionalid);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX, L_FILE_KEY_PROFESSIONALID, move1_professionalid);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.PROFESSIONALID_SUFFIX, 'Q', move2_professionalid);

// ########################################################################### 
//                    DEVICEID KEY
// ##########################################################################   
   L_FILE_KEY_DEVICEID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_DEVICEID, TheKeys.BaseMain_DeviceID, dx_FraudDefenseNetwork.Names.i_DEVICEID, L_FILE_KEY_DEVICEID, build_deviceid);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX, L_FILE_KEY_DEVICEID, move1_deviceid);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.DEVICEID_SUFFIX, 'Q', move2_deviceid);

// ########################################################################### 
//                    TIN KEY
// ##########################################################################   
   L_FILE_KEY_TIN := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_TIN, TheKeys.BaseMain_TIN, dx_FraudDefenseNetwork.Names.i_TIN, L_FILE_KEY_TIN, build_tin);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX, L_FILE_KEY_TIN, move1_tin);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.TIN_SUFFIX, 'Q', move2_tin);
	 
// ########################################################################### 
//                    NPI KEY
// ##########################################################################   
   L_FILE_KEY_NPI := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_NPI, TheKeys.BaseMain_NPI, dx_FraudDefenseNetwork.Names.i_NPI, L_FILE_KEY_NPI, build_npi);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX, L_FILE_KEY_NPI, move1_npi);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.NPI_SUFFIX, 'Q', move2_npi);
	 
// ########################################################################### 
//                    APP PROVIDERID KEY
// ##########################################################################   
   L_FILE_KEY_APP_PROVIDERID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_APPPROVIDERID, TheKeys.BaseMain_AppProviderID, dx_FraudDefenseNetwork.Names.i_APP_PROVIDERID, L_FILE_KEY_APP_PROVIDERID, build_AppProviderID);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX, L_FILE_KEY_APP_PROVIDERID, move1_AppProviderID);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.APPPROVIDERID_SUFFIX, 'Q', move2_AppProviderID);
	 
// ########################################################################### 
//                    LNPID KEY
// ##########################################################################   
   L_FILE_KEY_LNPID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_LNPID, TheKeys.BaseMain_LNPID, dx_FraudDefenseNetwork.Names.i_LNPID, L_FILE_KEY_LNPID, build_lnpid);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX, L_FILE_KEY_LNPID, move1_lnpid);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.LNPID_SUFFIX, 'Q', move2_lnpid);
 
// ########################################################################### 
//                    MBS INDTYPE EXCLUSION KEY
// ##########################################################################   
   L_FILE_KEY_MBS_INDTYPE_EXCLUSION := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_MBSINDTYPEEXCLUSION, TheKeys.MbsIndTypExclusion, dx_FraudDefenseNetwork.Names.i_MBS_INDTYPE_EXCLUSION, L_FILE_KEY_MBS_INDTYPE_EXCLUSION, build_MbsIndTypExclusion);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX, L_FILE_KEY_MBS_INDTYPE_EXCLUSION, move1_MbsIndTypExclusion);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_INDTYPE_EXCLUSION_SUFFIX, 'Q', move2_MbsIndTypExclusion);
	 
// ########################################################################### 
//                    MBS PRODUCT INCLUDE KEY
// ##########################################################################   
   L_FILE_KEY_MBS_PRODUCT_INCLUDE := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_MBSPRODUCTINCLUDE, TheKeys.MbsProdutInclude, dx_FraudDefenseNetwork.Names.i_MBS_PRODUCT_INCLUDE, L_FILE_KEY_MBS_PRODUCT_INCLUDE, build_MbsProductInclude);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX, L_FILE_KEY_MBS_PRODUCT_INCLUDE, move1_MbsProductInclude);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_PRODUCT_INCLUDE_SUFFIX, 'Q', move2_MbsProductInclude);

// ########################################################################### 
//                    MBS FDN MASTERID KEY
// ##########################################################################   
   L_FILE_KEY_MBS_FDN_MASTERID := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_GCID_2_MBSFDNMASTERID, TheKeys.MbsFDNMasterID, dx_FraudDefenseNetwork.Names.i_MBS_FDN_MASTERID, L_FILE_KEY_MBS_FDN_MASTERID, build_MbsFdnMasterID);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX, L_FILE_KEY_MBS_FDN_MASTERID, move1_MbsFdnMasterID);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_SUFFIX, 'Q', move2_MbsFdnMasterID);

// ########################################################################### 
//                    MBS FDN MASTERID EXCLUSION KEY
// ##########################################################################   
   L_FILE_KEY_MBS_FDN_MASTERID_EXCL := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_MBSFDNMASTERIDEXCLUSION, TheKeys.MbsFDNMasterIDExcl, dx_FraudDefenseNetwork.Names.i_MBS_FDN_MASTERID_EXCL, L_FILE_KEY_MBS_FDN_MASTERID_EXCL, build_MbsFDNMasterIDExcl);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX, L_FILE_KEY_MBS_FDN_MASTERID_EXCL, move1_MbsFDNMasterIDExcl);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.MBS_FDN_MASTERID_EXCL_SUFFIX, 'Q', move2_MbsFDNMasterIDExcl);

// ########################################################################### 
//                    LINKIDs KEY
// ##########################################################################   
   L_FILE_KEY_LINKIDs := dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::' + pversion + '::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_FraudDefenseNetwork.KEY_LINKIDS.Key, TheKeys.BaseMain_LINKIDs, dx_FraudDefenseNetwork.Names.i_LINKIDS_SF, L_FILE_KEY_LINKIDs, build_LinkIds);
   RoxieKeyBuild.Mac_SK_Move_to_Built_v2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX, L_FILE_KEY_LINKIDs, move1_LinkIds);
   RoxieKeyBuild.MAC_SK_Move_V2(dx_FraudDefenseNetwork.Names.KEY_PREFIX + '::@version@::' + dx_FraudDefenseNetwork.Names.LINKIDS_SUFFIX, 'Q', move2_LinkIds);
	 
	 
   build_keys := PARALLEL(build_id, build_did, build_email, build_ip, build_professionalid, build_deviceid, build_tin, 
	                        build_npi, build_AppProviderID, build_lnpid, build_LinkIds,
												  build_MbsIndTypExclusion, build_MbsProductInclude, build_MbsFDNMasterID, build_MbsFDNMasterIDExcl);
                     
   move_built_keys := PARALLEL(move1_id, move1_did, move1_email, move1_ip, move1_professionalid, move1_deviceid, move1_tin, 
	                             move1_npi, move1_AppProviderID, move1_lnpid, move1_LinkIds,
												       move1_MbsIndTypExclusion, move1_MbsProductInclude, move1_MbsFDNMasterID, move1_MbsFDNMasterIDExcl);
                                 
   move_qa_keys := PARALLEL(move2_id, move2_did, move2_email, move2_ip, move2_professionalid, move2_deviceid, move2_tin, 
	                          move2_npi, move2_AppProviderID, move2_lnpid, move2_LinkIds,
												    move2_MbsIndTypExclusion, move2_MbsProductInclude, move2_MbsFDNMasterID, move2_MbsFDNMasterIDExcl);

   build_fdn_keys_all := SEQUENTIAL(        
                                    build_keys,
                                    move_built_keys,
                                    move_qa_keys
                                    );
               
  EXPORT All :=	IF(tools.fun_IsValidVersion(pversion), build_fdn_keys_all,
		                                                   OUTPUT('No Valid version parameter passed, skipping FDN Build_Keys atribute')     );


END;