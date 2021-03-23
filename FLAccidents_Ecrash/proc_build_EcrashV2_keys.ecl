IMPORT RoxieKeyBuild, dx_eCrash;
   
EXPORT proc_build_EcrashV2_keys(STRING filedate) := FUNCTION

// ########################################################################### 
//                    ECRASH0 KEY
// ##########################################################################   
   L_FILE_KEY_ECRASH0 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' + dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH0_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH0, mod_PrepEcrashFLAccidentPRKeys.flc0_allrecs, dx_eCrash.Names.i_ECRASH0, L_FILE_KEY_ECRASH0, bk_ecrash0);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH0, dx_eCrash.Names.i_ECRASH0, move1_ecrash0);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH0, 'Q', move2_ecrash0, filedate);

// ########################################################################### 
//                    ECRASH1 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH1 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH1, mod_PrepEcrashFLAccidentPRKeys.flc1_ptotal, dx_eCrash.Names.i_ECRASH1, L_FILE_KEY_ECRASH1, bk_ecrash1);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH1, dx_eCrash.Names.i_ECRASH1, move1_ecrash1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH1, 'Q', move2_ecrash1, filedate);

// ########################################################################### 
//                    ECRASH2V KEY
// ##########################################################################
   L_FILE_KEY_ECRASH2V := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH2V_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH2V, mod_PrepEcrashFLAccidentPRKeys.flc2v_allrecs, dx_eCrash.Names.i_ECRASH2V, L_FILE_KEY_ECRASH2V, bk_ecrash2);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH2V, dx_eCrash.Names.i_ECRASH2V, move1_ecrash2);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH2V, 'Q', move2_ecrash2, filedate);
  
// ########################################################################### 
//                    ECRASH3V KEY
// ##########################################################################
   L_FILE_KEY_ECRASH3V := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH3V_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH3V, mod_PrepEcrashFLAccidentPRKeys.pflc3v, dx_eCrash.Names.i_ECRASH3V, L_FILE_KEY_ECRASH3V, bk_ecrash3);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH3V, dx_eCrash.Names.i_ECRASH3V, move1_ecrash3);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH3V, 'Q', move2_ecrash3, filedate);

// ########################################################################### 
//                    ECRASH4 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH4 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH4_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH4, mod_PrepEcrashFLAccidentPRKeys.flc4_allrecs, dx_eCrash.Names.i_ECRASH4, L_FILE_KEY_ECRASH4, bk_ecrash4);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH4, dx_eCrash.Names.i_ECRASH4, move1_ecrash4);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH4, 'Q', move2_ecrash4, filedate);

// ########################################################################### 
//                    ECRASH5 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH5 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH5_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH5, mod_PrepEcrashFLAccidentPRKeys.flc5_ptotal, dx_eCrash.Names.i_ECRASH5, L_FILE_KEY_ECRASH5, bk_ecrash5);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH5, dx_eCrash.Names.i_ECRASH5, move1_ecrash5);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH5, 'Q', move2_ecrash5, filedate);

// ########################################################################### 
//                    ECRASH6 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH6 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH6_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH6, mod_PrepEcrashFLAccidentPRKeys.flc6_ptotal, dx_eCrash.Names.i_ECRASH6, L_FILE_KEY_ECRASH6, bk_ecrash6);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH6, dx_eCrash.Names.i_ECRASH6, move1_ecrash6);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH6, 'Q', move2_ecrash6, filedate);
  
// ########################################################################### 
//                    ECRASH7 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH7 := dx_eCrash.Names.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx_eCrash.Names.ECRASH_PRODUCT + '::' + filedate + '::' + dx_eCrash.Names.ECRASH7_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ECRASH7, mod_PrepEcrashFLAccidentPRKeys.flc7_ptotal, dx_eCrash.Names.i_ECRASH7, L_FILE_KEY_ECRASH7, bk_ecrash7);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH7, dx_eCrash.Names.i_ECRASH7, move1_ecrash7);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ECRASH7, 'Q', move2_ecrash7, filedate);
  
// ########################################################################### 
//                    ACCNBR KEY
// ##########################################################################
   L_FILE_KEY_ACCNBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ACCNBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ACCNBR, mod_PrepEcrashPRKeys().dep_accnbr_base, dx_eCrash.Names.i_ACCNBR, L_FILE_KEY_ACCNBR, bk_accnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ACCNBR, dx_eCrash.Names.i_ACCNBR, move1_accnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ACCNBR, 'Q', move2_accnbr, filedate);

// ########################################################################### 
//                    ACCNBRV1 KEY
// ##########################################################################
   L_FILE_KEY_ACCNBRV1 := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ACCNBRV1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_ACCNBRV1, mod_PrepEcrashPRKeys().dep_accnbrv1_base, dx_eCrash.Names.i_ACCNBRV1, L_FILE_KEY_ACCNBRV1, bk_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ACCNBRV1, dx_eCrash.Names.i_ACCNBRV1, move1_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ACCNBRV1, 'Q', move2_accnbrv1, filedate);

// ########################################################################### 
//                       BDID KEY
// ##########################################################################
   L_FILE_KEY_BDID := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.BDID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BDID, mod_PrepEcrashPRKeys().ded_bdid_base, dx_eCrash.Names.i_BDID, L_FILE_KEY_BDID, bk_bdid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BDID, dx_eCrash.Names.i_BDID, move1_bdid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_BDID, 'Q', move2_bdid, filedate);
  
// ########################################################################### 
//                        DID KEY
// ##########################################################################
   L_FILE_KEY_DID := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.DID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_DID, mod_PrepEcrashPRKeys().DIDBase, dx_eCrash.Names.i_DID, L_FILE_KEY_DID, bk_did);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DID, dx_eCrash.Names.i_DID, move1_did);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_DID, 'Q', move2_did, filedate);
  
// ########################################################################### 
//                       DL NBR KEY
// ##########################################################################
   L_FILE_KEY_DLNBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.DL_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_DLNBR, mod_PrepEcrashPRKeys().dep_dlnbr_base, dx_eCrash.Names.i_DL_NBR, L_FILE_KEY_DLNBR, bk_dlnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DLNBR, dx_eCrash.Names.i_DL_NBR, move1_dlnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_DL_NBR, 'Q', move2_dlnbr, filedate);

// ########################################################################### 
//                       TAG NBR KEY
// ##########################################################################
   L_FILE_KEY_TAGNBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.TAG_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_TAGNBR, mod_PrepEcrashPRKeys().dep_tagnbr_base, dx_eCrash.Names.i_TAG_NBR, L_FILE_KEY_TAGNBR, bk_tagnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_TAGNBR, dx_eCrash.Names.i_TAG_NBR, move1_tagnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_TAG_NBR, 'Q', move2_tagnbr, filedate);
    
// ########################################################################### 
//                       VIN KEY
// ##########################################################################   
   L_FILE_KEY_VIN := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.VIN_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_VIN, mod_PrepEcrashPRKeys().VinBase, dx_eCrash.Names.i_VIN, L_FILE_KEY_VIN, bk_vin);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VIN, dx_eCrash.Names.i_VIN, move1_vin);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_VIN, 'Q', move2_vin, filedate);

// ########################################################################### 
//                       VIN7 KEY
// ########################################################################## 
   L_FILE_KEY_VIN7 := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.VIN7_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_VIN7, mod_PrepEcrashPRKeys().ecrash_vin_base_7, dx_eCrash.Names.i_VIN7, L_FILE_KEY_VIN7, bk_vin7);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VIN7, dx_eCrash.Names.i_VIN7, move1_vin7);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_VIN7, 'Q', move2_vin7, filedate);

// ########################################################################### 
//                   BY AGENCYID KEY
// ########################################################################## 
   L_FILE_KEY_BY_AGENCYID := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_AGENCY_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYAGENCYID, mod_PrepEcrashAnalyticKeys().by_AgencyID, dx_eCrash.Names.i_ANALYTICS_BY_AGENCY_ID, L_FILE_KEY_BY_AGENCYID, bk_agencyid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_AGENCYID, dx_eCrash.Names.i_ANALYTICS_BY_AGENCY_ID, move1_agencyid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_AGENCY_ID, 'Q', move2_agencyid, filedate);
    
// ########################################################################### 
//                      BY COLLISION TYPE KEY
// ########################################################################## 
   L_FILE_KEY_BY_CT := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_COLLISION_TYPE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYCOLLISIONTYPE, mod_PrepEcrashAnalyticKeys().dsByCollisionType, dx_eCrash.Names.i_ANALYTICS_BY_COLLISION_TYPE, L_FILE_KEY_BY_CT, bk_ct);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_CT, dx_eCrash.Names.i_ANALYTICS_BY_COLLISION_TYPE, move1_ct);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_COLLISION_TYPE, 'Q', move2_ct, filedate);

// ########################################################################### 
//                   BY DOW KEY
// ########################################################################## 
   L_FILE_KEY_BY_DOW := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_DOW_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYDOW, mod_PrepEcrashAnalyticKeys().by_DOW, dx_eCrash.Names.i_ANALYTICS_BY_DOW, L_FILE_KEY_BY_DOW, bk_dow);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_DOW, dx_eCrash.Names.i_ANALYTICS_BY_DOW, move1_dow);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_DOW, 'Q', move2_dow, filedate);
   
// ########################################################################### 
//                   BY HOD KEY
// ########################################################################## 
   L_FILE_KEY_BY_HOD := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_HOD_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYHOD, mod_PrepEcrashAnalyticKeys().by_HOD, dx_eCrash.Names.i_ANALYTICS_BY_HOD, L_FILE_KEY_BY_HOD, bk_hod);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_HOD, dx_eCrash.Names.i_ANALYTICS_BY_HOD, move1_hod);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_HOD, 'Q', move2_hod, filedate);
       
// ########################################################################### 
//                   BY INTER KEY
// ########################################################################## 
   L_FILE_KEY_BY_INTER := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_INTER_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYINTER, mod_PrepEcrashAnalyticKeys().dsByInter, dx_eCrash.Names.i_ANALYTICS_BY_INTER, L_FILE_KEY_BY_INTER, bk_inter);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_INTER, dx_eCrash.Names.i_ANALYTICS_BY_INTER, move1_inter);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_INTER, 'Q', move2_inter, filedate);
   
// ########################################################################### 
//                   BY MOY KEY
// ########################################################################## 
   L_FILE_KEY_BY_MOY := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ANALYTICS_BY_MOY_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_BYMOY, mod_PrepEcrashAnalyticKeys().by_MOY, dx_eCrash.Names.i_ANALYTICS_BY_MOY, L_FILE_KEY_BY_MOY, bk_moy);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_MOY, dx_eCrash.Names.i_ANALYTICS_BY_MOY, move1_moy);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ANALYTICS_BY_MOY, 'Q', move2_moy, filedate);
   
// ########################################################################### 
//                    DOL KEY
// ########################################################################## 
   L_FILE_KEY_DOL := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.DOL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_DOL, mod_PrepEcrashKeys().dep_base, dx_eCrash.Names.i_DOL, L_FILE_KEY_DOL, bk_dol);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DOL, dx_eCrash.Names.i_DOL, move1_dol);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_DOL, 'Q', move2_dol, filedate);

// ########################################################################### 
//           UNRESTRICTED ACCNBRV1 KEY
// ########################################################################## 
   L_FILE_KEY_UNRESTRICTED_ACCNBRV1 := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.UNRESTRICTED_ACCNBRV1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_UNRESTRICTEDACCNBRV1, mod_PrepEcrashKeys().Unrestricted_dep_accnbr_base, dx_eCrash.Names.i_UNRESTRICTED_ACCNBRV1, L_FILE_KEY_UNRESTRICTED_ACCNBRV1, bk_unrestricted_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_UNRESTRICTED_ACCNBRV1, dx_eCrash.Names.i_UNRESTRICTED_ACCNBRV1, move1_unrestricted_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_UNRESTRICTED_ACCNBRV1, 'Q', move2_unrestricted_accnbrv1, filedate);
   
// ########################################################################### 
//                   DELTADATE KEY
// ##########################################################################     
   L_FILE_KEY_DELTADATE := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.DELTA_DATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_DELTADATE, mod_PrepEcrashKeys().DateFile, dx_eCrash.Names.i_DELTA_DATE, L_FILE_KEY_DELTADATE, bk_deltadate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DELTADATE, dx_eCrash.Names.i_DELTA_DATE, move1_deltadate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_DELTA_DATE, 'Q', move2_deltadate, filedate);
    
// ########################################################################### 
//                   AGENCY KEY
// ########################################################################## 
   L_FILE_KEY_AGENCY := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.AGENCY_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_AGENCY, mod_PrepEcrashKeys().AgencyBase, dx_eCrash.Names.i_AGENCY, L_FILE_KEY_AGENCY, bk_agency);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_AGENCY, dx_eCrash.Names.i_AGENCY, move1_agency);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_AGENCY, 'Q', move2_agency, filedate);
   
// ########################################################################### 
//                   PHOTO ID KEY
// ########################################################################## 
   L_FILE_KEY_PHOTO_ID := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.PHOTO_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_PHOTOID, mod_PrepEcrashKeys().ds_PhotoSuperCmbnd, dx_eCrash.Names.i_PHOTO_ID, L_FILE_KEY_PHOTO_ID, bk_photoid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_PHOTO_ID, dx_eCrash.Names.i_PHOTO_ID, move1_photoid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_PHOTO_ID, 'Q', move2_photoid, filedate);
   
// ########################################################################### 
//                   REPORT ID KEY
// ########################################################################## 
   L_FILE_KEY_REPORT_ID := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.REPORT_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_REPORTID, mod_PrepEcrashKeys().dep_Report_base, dx_eCrash.Names.i_REPORT_ID, L_FILE_KEY_REPORT_ID, bk_reportid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_REPORT_ID, dx_eCrash.Names.i_REPORT_ID, move1_reportid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_REPORT_ID, 'Q', move2_reportid, filedate);
   
// ########################################################################### 
//                   SUPPLEMENTAL KEY
// ########################################################################## 
   L_FILE_KEY_SUPPLEMENTAL := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.SUPPLEMENTAL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_SUPPLEMENTAL, mod_PrepEcrashKeys().ded_base, dx_eCrash.Names.i_SUPPLEMENTAL, L_FILE_KEY_SUPPLEMENTAL, bk_supplemental);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_SUPPLEMENTAL, dx_eCrash.Names.i_SUPPLEMENTAL, move1_supplemental);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_SUPPLEMENTAL, 'Q', move2_supplemental, filedate);
   
// ########################################################################### 
//                   DLN NBR DL STATE KEY
// ########################################################################## 
   L_FILE_KEY_DLNNBR_DLSTATE := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.DLN_NBR_DL_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_DLNNBRDLSTATE, mod_PrepEcrashSearchKeys().uSlimDlnNbrDLState, dx_eCrash.Names.i_DLN_NBR_DL_STATE, L_FILE_KEY_DLNNBR_DLSTATE, bk_dlnnbrdlstate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DLNNBR_DLSTATE, dx_eCrash.Names.i_DLN_NBR_DL_STATE, move1_dlnnbrdlstate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_DLN_NBR_DL_STATE, 'Q', move2_dlnnbrdlstate, filedate);
    
// ########################################################################### 
//                      VIN NBR KEY
// ########################################################################## 
   L_FILE_KEY_VINNBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.VINNBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_VINNBR, mod_PrepEcrashSearchKeys().uSlimVinNbr, dx_eCrash.Names.i_VINNBR, L_FILE_KEY_VINNBR, bk_vinnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VINNBR, dx_eCrash.Names.i_VINNBR, move1_vinnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_VINNBR, 'Q', move2_vinnbr, filedate);
    
// ########################################################################### 
//                  LICENSE PLATE NBR KEY
// ########################################################################## 
   L_FILE_KEY_LICENSE_PLATENBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.LICENSE_PLATE_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_LICENSEPLATENBR, mod_PrepEcrashSearchKeys().uSlimLicensePlateNbr, dx_eCrash.Names.i_LICENSE_PLATE_NBR, L_FILE_KEY_LICENSE_PLATENBR, bk_licenseplatenbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_LICENSE_PLATENBR, dx_eCrash.Names.i_LICENSE_PLATE_NBR, move1_licenseplatenbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_LICENSE_PLATE_NBR, 'Q', move2_licenseplatenbr, filedate);

// ########################################################################### 
//                  OFFICER BADGE NBR KEY
// ########################################################################## 
   L_FILE_KEY_OFFICER_BADGENBR := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.OFFICER_BADGE_NBR_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_OFFICERBADGENBR, mod_PrepEcrashSearchKeys().uSlimOfficerBadgeNbr, dx_eCrash.Names.i_OFFICER_BADGE_NBR_STATE, L_FILE_KEY_OFFICER_BADGENBR, bk_officerbadgenbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_OFFICER_BADGENBR, dx_eCrash.Names.i_OFFICER_BADGE_NBR_STATE, move1_officerbadgenbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_OFFICER_BADGE_NBR_STATE, 'Q', move2_officerbadgenbr, filedate);

// ########################################################################### 
//                  LAST NAME KEY
// ########################################################################## 
   L_FILE_KEY_LASTNAME := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.LAST_NAME_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_LASTNAME, mod_PrepEcrashSearchKeys().uSlimLastName, dx_eCrash.Names.i_LAST_NAME_STATE, L_FILE_KEY_LASTNAME, bk_lastname);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_LASTNAME, dx_eCrash.Names.i_LAST_NAME_STATE, move1_lastname);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_LAST_NAME_STATE, 'Q', move2_lastname, filedate);

// ########################################################################### 
//              PREF NAME STATE KEY
// ########################################################################## 
   L_FILE_KEY_PREFNAME := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.PREFNAME_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_PREFNAMESTATE, mod_PrepEcrashSearchKeys().uSlimPrefNameState, dx_eCrash.Names.i_PREFNAME_STATE, L_FILE_KEY_PREFNAME, bk_prefname_state);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_PREFNAME, dx_eCrash.Names.i_PREFNAME_STATE, move1_prefname_state);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_PREFNAME_STATE, 'Q', move2_prefname_state, filedate);

// ########################################################################### 
//              ST AND LOCATION KEY
// ########################################################################## 
   L_FILE_KEY_ST_AND_LOCATION := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.ST_AND_LOCATION_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_STANDLOCATION, mod_PrepEcrashSearchKeys().uAccidentLocation, dx_eCrash.Names.i_ST_AND_LOCATION, L_FILE_KEY_ST_AND_LOCATION, bk_standlocation);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ST_AND_LOCATION, dx_eCrash.Names.i_ST_AND_LOCATION, move1_standlocation);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_ST_AND_LOCATION, 'Q', move2_standlocation, filedate);

// ########################################################################### 
//             AGENCY ID SENT DATE KEY
// ########################################################################## 
   L_FILE_KEY_AGENCYID_SENTDATE := dx_eCrash.Names.KEY_PREFIX + '::' + filedate + '::' + dx_eCrash.Names.AGENCY_ID_SENT_DATE_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx_eCrash.KEY_AGENCYIDSENTDATE, mod_PrepEcrashSearchKeys().tbSlimAgencyIdSentdate, dx_eCrash.Names.i_AGENCY_ID_SENT_DATE_STATE, L_FILE_KEY_AGENCYID_SENTDATE, bk_agencyid_sentdate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_AGENCYID_SENTDATE, dx_eCrash.Names.i_AGENCY_ID_SENT_DATE_STATE, move1_agencyid_sentdate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx_eCrash.Names.i_AGENCY_ID_SENT_DATE_STATE, 'Q', move2_agencyid_sentdate, filedate);


   build_keys := PARALLEL(bk_ecrash0, bk_ecrash1, bk_ecrash2, bk_ecrash3, bk_ecrash4, bk_ecrash5, bk_ecrash6, bk_ecrash7,                 //EcrashFLAccidentPRKeys
                          bk_accnbr, bk_accnbrv1, bk_bdid, bk_did, bk_dlnbr, bk_tagnbr, bk_vin, bk_vin7,                //EcrashPRKeys
                          bk_agencyid, bk_ct, bk_dow, bk_hod, bk_inter, bk_moy,                                                           //EcrashAnalyticsKeys                                           
                          bk_dol, bk_unrestricted_accnbrv1, bk_deltadate, bk_agency, bk_photoid, bk_reportid, bk_supplemental,//EcrashKeys
                          bk_dlnnbrdlstate, bk_vinnbr, bk_licenseplatenbr, bk_officerbadgenbr, bk_lastname, bk_prefname_state, bk_standlocation, bk_agencyid_sentdate //EcrashSearchKeys
                         );
                     
   move_built_keys := PARALLEL(move1_ecrash0, move1_ecrash1, move1_ecrash2, move1_ecrash3, move1_ecrash4, move1_ecrash5, move1_ecrash6, move1_ecrash7,
                               move1_accnbr, move1_accnbrv1, move1_bdid, move1_did, move1_dlnbr, move1_tagnbr, move1_vin, move1_vin7,
                               move1_agencyid, move1_ct, move1_dow, move1_hod, move1_inter, move1_moy,
                               move1_dol, move1_unrestricted_accnbrv1, move1_deltadate, move1_agency, move1_photoid, move1_reportid, move1_supplemental,
                               move1_dlnnbrdlstate, move1_vinnbr, move1_licenseplatenbr, move1_officerbadgenbr, move1_lastname, move1_prefname_state, move1_standlocation, move1_agencyid_sentdate
                              );
                                 
   move_qa_keys := PARALLEL(move2_ecrash0, move2_ecrash1, move2_ecrash2, move2_ecrash3, move2_ecrash4, move2_ecrash5, move2_ecrash6, move2_ecrash7,
                            move2_accnbr, move2_accnbrv1, move2_bdid, move2_did, move2_dlnbr, move2_tagnbr, move2_vin, move2_vin7,
                            move2_agencyid, move2_ct, move2_dow, move2_hod, move2_inter, move2_moy,
                            move2_dol, move2_unrestricted_accnbrv1, move2_deltadate, move2_agency, move2_photoid, move2_reportid, move2_supplemental,
                            move2_dlnnbrdlstate, move2_vinnbr, move2_licenseplatenbr, move2_officerbadgenbr, move2_lastname, move2_prefname_state, move2_standlocation, move2_agencyid_sentdate
                           );

   build_ecrash_keys_all := SEQUENTIAL(        
                                       build_keys,
                                       move_built_keys,
                                       move_qa_keys,
                                       proc_build_ecrashV2_autokey(filedate)
                                      );
               
   RETURN build_ecrash_keys_all;
END;
