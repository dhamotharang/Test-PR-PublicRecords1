IMPORT RoxieKeyBuild;
IMPORT dx_eCrash AS dx;

EXPORT proc_build_EcrashV2_keys(STRING filedate) := FUNCTION

// ########################################################################### 
//                    ECRASH0 KEY
// ##########################################################################		 
   L_FILE_KEY_ECRASH0 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' + dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH0_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH0, mod_PrepEcrashFLAccidentPRKeys.flc0_allrecs, dx.Files.FILE_KEY_ECRASH0, L_FILE_KEY_ECRASH0, bk_ecrash0);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH0, dx.Files.FILE_KEY_ECRASH0, move1_ecrash0);
	 RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH0, 'Q', move2_ecrash0, filedate);

// ########################################################################### 
//                    ECRASH1 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH1 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH1, mod_PrepEcrashFLAccidentPRKeys.flc1_ptotal, dx.Files.FILE_KEY_ECRASH1, L_FILE_KEY_ECRASH1, bk_ecrash1);
	 RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH1, dx.Files.FILE_KEY_ECRASH1, move1_ecrash1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH1, 'Q', move2_ecrash1, filedate);

// ########################################################################### 
//                    ECRASH2V KEY
// ##########################################################################
   L_FILE_KEY_ECRASH2V := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH2V_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH2V, mod_PrepEcrashFLAccidentPRKeys.flc2v_allrecs, dx.Files.FILE_KEY_ECRASH2V, L_FILE_KEY_ECRASH2V, bk_ecrash2);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH2V, dx.Files.FILE_KEY_ECRASH2V, move1_ecrash2);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH2V, 'Q', move2_ecrash2, filedate);
	 
// ########################################################################### 
//                    ECRASH3V KEY
// ##########################################################################
   L_FILE_KEY_ECRASH3V := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH3V_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH3V, mod_PrepEcrashFLAccidentPRKeys.pflc3v, dx.Files.FILE_KEY_ECRASH3V, L_FILE_KEY_ECRASH3V, bk_ecrash3);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH3V, dx.Files.FILE_KEY_ECRASH3V, move1_ecrash3);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH3V, 'Q', move2_ecrash3, filedate);

// ########################################################################### 
//                    ECRASH4 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH4 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH4_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH4, mod_PrepEcrashFLAccidentPRKeys.flc4_allrecs, dx.Files.FILE_KEY_ECRASH4, L_FILE_KEY_ECRASH4, bk_ecrash4);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH4, dx.Files.FILE_KEY_ECRASH4, move1_ecrash4);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH4, 'Q', move2_ecrash4, filedate);

// ########################################################################### 
//                    ECRASH5 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH5 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH5_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH5, mod_PrepEcrashFLAccidentPRKeys.flc5_ptotal, dx.Files.FILE_KEY_ECRASH5, L_FILE_KEY_ECRASH5, bk_ecrash5);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH5, dx.Files.FILE_KEY_ECRASH5, move1_ecrash5);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH5, 'Q', move2_ecrash5, filedate);

// ########################################################################### 
//                    ECRASH6 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH6 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH6_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH6, mod_PrepEcrashFLAccidentPRKeys.flc6_ptotal, dx.Files.FILE_KEY_ECRASH6, L_FILE_KEY_ECRASH6, bk_ecrash6);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH6, dx.Files.FILE_KEY_ECRASH6, move1_ecrash6);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH6, 'Q', move2_ecrash6, filedate);
	 
// ########################################################################### 
//                    ECRASH7 KEY
// ##########################################################################
   L_FILE_KEY_ECRASH7 := dx.Files.FLACCIDENT_PR_KEY_PREFIX + '::' +  dx.Files.ECRASH_PRODUCT + '::' + filedate + '::' + dx.Files.ECRASH7_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ECRASH7, mod_PrepEcrashFLAccidentPRKeys.flc7_ptotal, dx.Files.FILE_KEY_ECRASH7, L_FILE_KEY_ECRASH7, bk_ecrash7);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ECRASH7, dx.Files.FILE_KEY_ECRASH7, move1_ecrash7);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ECRASH7, 'Q', move2_ecrash7, filedate);
	 
// ########################################################################### 
//                    ACCNBR KEY
// ##########################################################################
   L_FILE_KEY_ACCNBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ACCNBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ACCNBR, mod_PrepEcrashPRKeys().dep_accnbr_base, dx.Files.FILE_KEY_ACCNBR, L_FILE_KEY_ACCNBR, bk_accnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ACCNBR, dx.Files.FILE_KEY_ACCNBR, move1_accnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ACCNBR, 'Q', move2_accnbr, filedate);

// ########################################################################### 
//                    ACCNBRV1 KEY
// ##########################################################################
   L_FILE_KEY_ACCNBRV1 := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ACCNBRV1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_ACCNBRV1, mod_PrepEcrashPRKeys().dep_accnbrv1_base, dx.Files.FILE_KEY_ACCNBRV1, L_FILE_KEY_ACCNBRV1, bk_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ACCNBRV1, dx.Files.FILE_KEY_ACCNBRV1, move1_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ACCNBRV1, 'Q', move2_accnbrv1, filedate);
	 
// ########################################################################### 
//              PARTIAL REPORT NBR KEY
// ##########################################################################
   L_FILE_KEY_PARTIALACCNBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.PARTIAL_ACCNBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_PARTIALACCNBR, mod_PrepEcrashPRKeys().clean_partnbr, dx.Files.FILE_KEY_PARTIAL_ACCNBR, L_FILE_KEY_PARTIALACCNBR, bk_partialaccnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_PARTIALACCNBR, dx.Files.FILE_KEY_PARTIAL_ACCNBR, move1_partialaccnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_PARTIAL_ACCNBR, 'Q', move2_partialaccnbr, filedate);

// ########################################################################### 
//                       BDID KEY
// ##########################################################################
   L_FILE_KEY_BDID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.BDID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BDID, mod_PrepEcrashPRKeys().ded_bdid_base, dx.Files.FILE_KEY_BDID, L_FILE_KEY_BDID, bk_bdid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BDID, dx.Files.FILE_KEY_BDID, move1_bdid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_BDID, 'Q', move2_bdid, filedate);
	 
// ########################################################################### 
//                        DID KEY
// ##########################################################################
   L_FILE_KEY_DID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.DID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_DID, mod_PrepEcrashPRKeys().DIDBase, dx.Files.FILE_KEY_DID, L_FILE_KEY_DID, bk_did);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DID, dx.Files.FILE_KEY_DID, move1_did);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_DID, 'Q', move2_did, filedate);
	 
// ########################################################################### 
//                       DL NBR KEY
// ##########################################################################
   L_FILE_KEY_DLNBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.DL_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_DLNBR, mod_PrepEcrashPRKeys().dep_dlnbr_base, dx.Files.FILE_KEY_DL_NBR, L_FILE_KEY_DLNBR, bk_dlnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DLNBR, dx.Files.FILE_KEY_DL_NBR, move1_dlnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_DL_NBR, 'Q', move2_dlnbr, filedate);

// ########################################################################### 
//                       TAG NBR KEY
// ##########################################################################
   L_FILE_KEY_TAGNBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.TAG_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_TAGNBR, mod_PrepEcrashPRKeys().dep_tagnbr_base, dx.Files.FILE_KEY_TAG_NBR, L_FILE_KEY_TAGNBR, bk_tagnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_TAGNBR, dx.Files.FILE_KEY_TAG_NBR, move1_tagnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_TAG_NBR, 'Q', move2_tagnbr, filedate);
	 
// ########################################################################### 
//                       VIN KEY
// ##########################################################################	
   L_FILE_KEY_VIN := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.VIN_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_VIN, mod_PrepEcrashPRKeys().VinBase, dx.Files.FILE_KEY_VIN, L_FILE_KEY_VIN, bk_vin);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VIN, dx.Files.FILE_KEY_VIN, move1_vin);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_VIN, 'Q', move2_vin, filedate);

// ########################################################################### 
//                       VIN7 KEY
// ########################################################################## 
   L_FILE_KEY_VIN7 := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.VIN7_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_VIN7, mod_PrepEcrashPRKeys().ecrash_vin_base_7, dx.Files.FILE_KEY_VIN7, L_FILE_KEY_VIN7, bk_vin7);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VIN7, dx.Files.FILE_KEY_VIN7, move1_vin7);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_VIN7, 'Q', move2_vin7, filedate);

// ########################################################################### 
//                   BY AGENCYID KEY
// ########################################################################## 
   L_FILE_KEY_BY_AGENCYID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_AGENCY_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYAGENCYID, mod_PrepEcrashAnalyticKeys().by_AgencyID, dx.Files.FILE_KEY_ANALYTICS_BY_AGENCY_ID, L_FILE_KEY_BY_AGENCYID, bk_agencyid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_AGENCYID, dx.Files.FILE_KEY_ANALYTICS_BY_AGENCY_ID, move1_agencyid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_AGENCY_ID, 'Q', move2_agencyid, filedate);
	 
// ########################################################################### 
//                      BY COLLISION TYPE KEY
// ########################################################################## 
   L_FILE_KEY_BY_CT := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_COLLISION_TYPE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYCOLLISIONTYPE, mod_PrepEcrashAnalyticKeys().dsByCollisionType, dx.Files.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE, L_FILE_KEY_BY_CT, bk_ct);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_CT, dx.Files.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE, move1_ct);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_COLLISION_TYPE, 'Q', move2_ct, filedate);

// ########################################################################### 
//                   BY DOW KEY
// ########################################################################## 
   L_FILE_KEY_BY_DOW := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_DOW_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYDOW, mod_PrepEcrashAnalyticKeys().by_DOW, dx.Files.FILE_KEY_ANALYTICS_BY_DOW, L_FILE_KEY_BY_DOW, bk_dow);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_DOW, dx.Files.FILE_KEY_ANALYTICS_BY_DOW, move1_dow);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_DOW, 'Q', move2_dow, filedate);
	
// ########################################################################### 
//                   BY HOD KEY
// ########################################################################## 
   L_FILE_KEY_BY_HOD := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_HOD_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYHOD, mod_PrepEcrashAnalyticKeys().by_HOD, dx.Files.FILE_KEY_ANALYTICS_BY_HOD, L_FILE_KEY_BY_HOD, bk_hod);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_HOD, dx.Files.FILE_KEY_ANALYTICS_BY_HOD, move1_hod);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_HOD, 'Q', move2_hod, filedate);
		 
// ########################################################################### 
//                   BY INTER KEY
// ########################################################################## 
   L_FILE_KEY_BY_INTER := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_INTER_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYINTER, mod_PrepEcrashAnalyticKeys().dsByInter, dx.Files.FILE_KEY_ANALYTICS_BY_INTER, L_FILE_KEY_BY_INTER, bk_inter);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_INTER, dx.Files.FILE_KEY_ANALYTICS_BY_INTER, move1_inter);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_INTER, 'Q', move2_inter, filedate);
	
// ########################################################################### 
//                   BY MOY KEY
// ########################################################################## 
   L_FILE_KEY_BY_MOY := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ANALYTICS_BY_MOY_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_BYMOY, mod_PrepEcrashAnalyticKeys().by_MOY, dx.Files.FILE_KEY_ANALYTICS_BY_MOY, L_FILE_KEY_BY_MOY, bk_moy);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_BY_MOY, dx.Files.FILE_KEY_ANALYTICS_BY_MOY, move1_moy);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ANALYTICS_BY_MOY, 'Q', move2_moy, filedate);
	
// ########################################################################### 
//                    DOL KEY
// ########################################################################## 
   L_FILE_KEY_DOL := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.DOL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_DOL, mod_PrepEcrashKeys().dep_base, dx.Files.FILE_KEY_DOL, L_FILE_KEY_DOL, bk_dol);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DOL, dx.Files.FILE_KEY_DOL, move1_dol);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_DOL, 'Q', move2_dol, filedate);
	
// ########################################################################### 
//             LINK ID KEY
// ########################################################################## 
   L_FILE_KEY_LINKIDS := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.LINKIDS_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_LINKIDS, FLAccidents_Ecrash.Key_EcrashV2_LinkIds.Key, dx.Files.FILE_KEY_LINKIDS, L_FILE_KEY_LINKIDS, bk_linkids);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_LINKIDS, dx.Files.FILE_KEY_LINKIDS, move1_linkids);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_LINKIDS, 'Q', move2_linkids, filedate);

// ########################################################################### 
//           UNRESTRICTED ACCNBRV1 KEY
// ########################################################################## 
   L_FILE_KEY_UNRESTRICTED_ACCNBRV1 := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.UNRESTRICTED_ACCNBRV1_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_UNRESTRICTEDACCNBRV1, mod_PrepEcrashKeys().Unrestricted_dep_accnbr_base, dx.Files.FILE_KEY_UNRESTRICTED_ACCNBRV1, L_FILE_KEY_UNRESTRICTED_ACCNBRV1, bk_unrestricted_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_UNRESTRICTED_ACCNBRV1, dx.Files.FILE_KEY_UNRESTRICTED_ACCNBRV1, move1_unrestricted_accnbrv1);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_UNRESTRICTED_ACCNBRV1, 'Q', move2_unrestricted_accnbrv1, filedate);
	
// ########################################################################### 
//                   DELTADATE KEY
// ########################################################################## 	 
   L_FILE_KEY_DELTADATE := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.DELTA_DATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_DELTADATE, mod_PrepEcrashKeys().DateFile, dx.Files.FILE_KEY_DELTA_DATE, L_FILE_KEY_DELTADATE, bk_deltadate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DELTADATE, dx.Files.FILE_KEY_DELTA_DATE, move1_deltadate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_DELTA_DATE, 'Q', move2_deltadate, filedate);
	 
// ########################################################################### 
//                   AGENCY KEY
// ########################################################################## 
   L_FILE_KEY_AGENCY := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.AGENCY_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_AGENCY, mod_PrepEcrashKeys().AgencyBase, dx.Files.FILE_KEY_AGENCY, L_FILE_KEY_AGENCY, bk_agency);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_AGENCY, dx.Files.FILE_KEY_AGENCY, move1_agency);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_AGENCY, 'Q', move2_agency, filedate);
	
// ########################################################################### 
//                   PHOTO ID KEY
// ########################################################################## 
   L_FILE_KEY_PHOTO_ID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.PHOTO_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_PHOTOID, mod_PrepEcrashKeys().ds_PhotoSuperCmbnd, dx.Files.FILE_KEY_PHOTO_ID, L_FILE_KEY_PHOTO_ID, bk_photoid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_PHOTO_ID, dx.Files.FILE_KEY_PHOTO_ID, move1_photoid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_PHOTO_ID, 'Q', move2_photoid, filedate);
	
// ########################################################################### 
//                   REPORT ID KEY
// ########################################################################## 
   L_FILE_KEY_REPORT_ID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.REPORT_ID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_REPORTID, mod_PrepEcrashKeys().dep_Report_base, dx.Files.FILE_KEY_REPORT_ID, L_FILE_KEY_REPORT_ID, bk_reportid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_REPORT_ID, dx.Files.FILE_KEY_REPORT_ID, move1_reportid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_REPORT_ID, 'Q', move2_reportid, filedate);
	
// ########################################################################### 
//                   SUPPLEMENTAL KEY
// ########################################################################## 
   L_FILE_KEY_SUPPLEMENTAL := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.SUPPLEMENTAL_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_SUPPLEMENTAL, mod_PrepEcrashKeys().ded_base, dx.Files.FILE_KEY_SUPPLEMENTAL, L_FILE_KEY_SUPPLEMENTAL, bk_supplemental);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_SUPPLEMENTAL, dx.Files.FILE_KEY_SUPPLEMENTAL, move1_supplemental);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_SUPPLEMENTAL, 'Q', move2_supplemental, filedate);
	
// ########################################################################### 
//                   DLN NBR DL STATE KEY
// ########################################################################## 
   L_FILE_KEY_DLNNBR_DLSTATE := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.DLN_NBR_DL_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_DLNNBRDLSTATE, mod_PrepEcrashSearchKeys().uSlimDlnNbrDLState, dx.Files.FILE_KEY_DLN_NBR_DL_STATE, L_FILE_KEY_DLNNBR_DLSTATE, bk_dlnnbrdlstate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_DLNNBR_DLSTATE, dx.Files.FILE_KEY_DLN_NBR_DL_STATE, move1_dlnnbrdlstate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_DLN_NBR_DL_STATE, 'Q', move2_dlnnbrdlstate, filedate);
	 
// ########################################################################### 
//                      VIN NBR KEY
// ########################################################################## 
   L_FILE_KEY_VINNBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.VINNBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_VINNBR, mod_PrepEcrashSearchKeys().uSlimVinNbr, dx.Files.FILE_KEY_VINNBR, L_FILE_KEY_VINNBR, bk_vinnbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_VINNBR, dx.Files.FILE_KEY_VINNBR, move1_vinnbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_VINNBR, 'Q', move2_vinnbr, filedate);
	 
// ########################################################################### 
//                  LICENSE PLATE NBR KEY
// ########################################################################## 
   L_FILE_KEY_LICENSE_PLATENBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.LICENSE_PLATE_NBR_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_LICENSEPLATENBR, mod_PrepEcrashSearchKeys().uSlimLicensePlateNbr, dx.Files.FILE_KEY_LICENSE_PLATE_NBR, L_FILE_KEY_LICENSE_PLATENBR, bk_licenseplatenbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_LICENSE_PLATENBR, dx.Files.FILE_KEY_LICENSE_PLATE_NBR, move1_licenseplatenbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_LICENSE_PLATE_NBR, 'Q', move2_licenseplatenbr, filedate);

// ########################################################################### 
//                  OFFICER BADGE NBR KEY
// ########################################################################## 
   L_FILE_KEY_OFFICER_BADGENBR := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.OFFICER_BADGE_NBR_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_OFFICERBADGENBR, mod_PrepEcrashSearchKeys().uSlimOfficerBadgeNbr, dx.Files.FILE_KEY_OFFICER_BADGE_NBR_STATE, L_FILE_KEY_OFFICER_BADGENBR, bk_officerbadgenbr);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_OFFICER_BADGENBR, dx.Files.FILE_KEY_OFFICER_BADGE_NBR_STATE, move1_officerbadgenbr);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_OFFICER_BADGE_NBR_STATE, 'Q', move2_officerbadgenbr, filedate);

// ########################################################################### 
//                  LAST NAME KEY
// ########################################################################## 
   L_FILE_KEY_LASTNAME := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.LAST_NAME_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_LASTNAME, mod_PrepEcrashSearchKeys().uSlimLastName, dx.Files.FILE_KEY_LAST_NAME_STATE, L_FILE_KEY_LASTNAME, bk_lastname);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_LASTNAME, dx.Files.FILE_KEY_LAST_NAME_STATE, move1_lastname);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_LAST_NAME_STATE, 'Q', move2_lastname, filedate);

// ########################################################################### 
//              PREF NAME STATE KEY
// ########################################################################## 
   L_FILE_KEY_PREFNAME := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.PREFNAME_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_PREFNAMESTATE, mod_PrepEcrashSearchKeys().uSlimPrefNameState, dx.Files.FILE_KEY_PREFNAME_STATE, L_FILE_KEY_PREFNAME, bk_prefname_state);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_PREFNAME, dx.Files.FILE_KEY_PREFNAME_STATE, move1_prefname_state);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_PREFNAME_STATE, 'Q', move2_prefname_state, filedate);

// ########################################################################### 
//              REPORT LINK ID KEY
// ########################################################################## 
   L_FILE_KEY_REPORT_LINKID := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.REPORT_LINKID_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_REPORTLINKID, mod_PrepEcrashSearchKeys().uSlimReportLinkId, dx.Files.FILE_KEY_REPORT_LINKID, L_FILE_KEY_REPORT_LINKID, bk_reportlinkid);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_REPORT_LINKID, dx.Files.FILE_KEY_REPORT_LINKID, move1_reportlinkid);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_REPORT_LINKID, 'Q', move2_reportlinkid, filedate);

// ########################################################################### 
//              ST AND LOCATION KEY
// ########################################################################## 
   L_FILE_KEY_ST_AND_LOCATION := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.ST_AND_LOCATION_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_STANDLOCATION, mod_PrepEcrashSearchKeys().uAccidentLocation, dx.Files.FILE_KEY_ST_AND_LOCATION, L_FILE_KEY_ST_AND_LOCATION, bk_standlocation);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_ST_AND_LOCATION, dx.Files.FILE_KEY_ST_AND_LOCATION, move1_standlocation);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_ST_AND_LOCATION, 'Q', move2_standlocation, filedate);

// ########################################################################### 
//             AGENCY ID SENT DATE KEY
// ########################################################################## 
   L_FILE_KEY_AGENCYID_SENTDATE := dx.Files.KEY_PREFIX + '::' + filedate + '::' + dx.Files.AGENCY_ID_SENT_DATE_STATE_SUFFIX;
   RoxieKeybuild.MAC_build_logical(dx.KEY_AGENCYIDSENTDATE, mod_PrepEcrashSearchKeys().tbSlimAgencyIdSentdate, dx.Files.FILE_KEY_AGENCY_ID_SENT_DATE_STATE, L_FILE_KEY_AGENCYID_SENTDATE, bk_agencyid_sentdate);
   RoxieKeyBuild.Mac_SK_Move_To_Built(L_FILE_KEY_AGENCYID_SENTDATE, dx.Files.FILE_KEY_AGENCY_ID_SENT_DATE_STATE, move1_agencyid_sentdate);
   RoxieKeyBuild.Mac_SK_Move_V3(dx.Files.FILE_KEY_AGENCY_ID_SENT_DATE_STATE, 'Q', move2_agencyid_sentdate, filedate);


build_keys := parallel(bk_ecrash0, bk_ecrash1, bk_ecrash2, bk_ecrash3, bk_ecrash4, bk_ecrash5, bk_ecrash6, bk_ecrash7,                 //EcrashFLAccidentPRKeys
                       bk_accnbr, bk_accnbrv1, bk_partialaccnbr, bk_bdid, bk_did, bk_dlnbr, bk_tagnbr, bk_vin, bk_vin7,                //EcrashPRKeys
											 bk_agencyid, bk_ct, bk_dow, bk_hod, bk_inter, bk_moy,                                                           //EcrashAnalyticsKeys                                           
											 bk_dol, bk_linkids, bk_unrestricted_accnbrv1, bk_deltadate, bk_agency, bk_photoid, bk_reportid, bk_supplemental,//EcrashKeys
											 bk_dlnnbrdlstate, bk_vinnbr, bk_licenseplatenbr, bk_officerbadgenbr, bk_lastname, bk_prefname_state, bk_reportlinkid, bk_standlocation, bk_agencyid_sentdate);//EcrashSearchKeys
							
move_built_keys := parallel(move1_ecrash0, move1_ecrash1, move1_ecrash2, move1_ecrash3, move1_ecrash4, move1_ecrash5, move1_ecrash6, move1_ecrash7,
                      move1_accnbr, move1_accnbrv1, move1_partialaccnbr, move1_bdid, move1_did, move1_dlnbr, move1_tagnbr, move1_vin, move1_vin7,
										  move1_agencyid, move1_ct, move1_dow, move1_hod, move1_inter, move1_moy,
										  move1_dol, move1_linkids, move1_unrestricted_accnbrv1, move1_deltadate, move1_agency, move1_photoid, move1_reportid, move1_supplemental,
										  move1_dlnnbrdlstate, move1_vinnbr, move1_licenseplatenbr, move1_officerbadgenbr, move1_lastname, move1_prefname_state, move1_reportlinkid, move1_standlocation, move1_agencyid_sentdate);
											
move_qa_keys := parallel(move2_ecrash0, move2_ecrash1, move2_ecrash2, move2_ecrash3, move2_ecrash4, move2_ecrash5, move2_ecrash6, move2_ecrash7,
                      move2_accnbr, move2_accnbrv1, move2_partialaccnbr, move2_bdid, move2_did, move2_dlnbr, move2_tagnbr, move2_vin, move2_vin7,
										  move2_agencyid, move2_ct, move2_dow, move2_hod, move2_inter, move2_moy,
										  move2_dol, move2_linkids, move2_unrestricted_accnbrv1, move2_deltadate, move2_agency, move2_photoid, move2_reportid, move2_supplemental,
										  move2_dlnnbrdlstate, move2_vinnbr, move2_licenseplatenbr, move2_officerbadgenbr, move2_lastname, move2_prefname_state, move2_reportlinkid, move2_standlocation, move2_agencyid_sentdate);

build_ecrash_keys_all := sequential(	
                                    FLAccidents_Ecrash.CreateSuperFiles,
                                    FLAccidents_Ecrash.fn_Validate,
                                    FLAccidents_Ecrash.Proc_Build_Alpha(filedate),			
					                          build_keys,
					                          move_built_keys,
					                          move_qa_keys,
					                          FLAccidents_Ecrash.proc_build_ecrashV2_autokey(filedate)
					                          );
					
RETURN build_ecrash_keys_all;
												   
END;