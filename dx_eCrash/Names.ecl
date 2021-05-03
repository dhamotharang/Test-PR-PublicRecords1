IMPORT doxie;
 
EXPORT Names := MODULE

  SHARED LOCATION_PREFIX := '~';
  SHARED VERSION := doxie.Version_SuperKey;

  EXPORT ECRASH_PRODUCT := 'ecrash';
  EXPORT ECRASHV2_PRODUCT := 'ecrashV2';
  EXPORT ECRASHV2_AUTOKEY := 'autokey';

  EXPORT KEY_PREFIX := LOCATION_PREFIX + 'thor_data400::key::' + ECRASHV2_PRODUCT;
  EXPORT KEY_AUTOKEY_PREFIX := KEY_PREFIX + '::' + ECRASHV2_AUTOKEY + '::';
  EXPORT FLACCIDENT_PR_KEY_PREFIX := LOCATION_PREFIX + 'thor_data400::key';

//***************************************************************
//           FL accidents PR keys suffix
//***************************************************************
  EXPORT ECRASH0_SUFFIX := 'ecrash0';
  EXPORT ECRASH1_SUFFIX := 'ecrash1';
  EXPORT ECRASH2V_SUFFIX := 'ecrash2v';
  EXPORT ECRASH3V_SUFFIX := 'ecrash3v';
  EXPORT ECRASH4_SUFFIX := 'ecrash4';
  EXPORT ECRASH5_SUFFIX := 'ecrash5';
  EXPORT ECRASH6_SUFFIX := 'ecrash6';
  EXPORT ECRASH7_SUFFIX := 'ecrash7';

//***************************************************************
//           FL accidents PR keys File definitions
//***************************************************************
  EXPORT i_ECRASH0 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH0_SUFFIX;
  EXPORT i_ECRASH0_SF := i_ECRASH0 + '_' + VERSION;

  EXPORT i_ECRASH1 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH1_SUFFIX;
  EXPORT i_ECRASH1_SF := i_ECRASH1 + '_' + VERSION;

  EXPORT i_ECRASH2V := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH2V_SUFFIX;
  EXPORT i_ECRASH2V_SF := i_ECRASH2V + '_' + VERSION;

  EXPORT i_ECRASH3V := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH3V_SUFFIX;
  EXPORT i_ECRASH3V_SF := i_ECRASH3V + '_' + VERSION;

  EXPORT i_ECRASH4 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH4_SUFFIX;
  EXPORT i_ECRASH4_SF := i_ECRASH4 + '_' + VERSION;

  EXPORT i_ECRASH5 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH5_SUFFIX;
  EXPORT i_ECRASH5_SF := i_ECRASH5 + '_' + VERSION;

  EXPORT i_ECRASH6 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH6_SUFFIX;
  EXPORT i_ECRASH6_SF := i_ECRASH6 + '_' + VERSION;

  EXPORT i_ECRASH7 := FLACCIDENT_PR_KEY_PREFIX + '::' + ECRASH7_SUFFIX;
  EXPORT i_ECRASH7_SF := i_ECRASH7 + '_' + VERSION;

//***********************************************************************
//                Ecrash PR keys suffix
//***********************************************************************
  EXPORT ACCNBRV1_SUFFIX := 'accnbrv1';
  EXPORT ACCNBR_SUFFIX := 'accnbr';
  EXPORT BDID_SUFFIX := 'bdid';
  EXPORT DID_SUFFIX := 'did';
  EXPORT DL_NBR_SUFFIX := 'dlnbr';
  EXPORT TAG_NBR_SUFFIX := 'tagnbr';
  EXPORT VIN7_SUFFIX := 'vin7';
  EXPORT VIN_SUFFIX := 'vin';
 
//***************************************************************
//           Ecrash PR keys File definitions
//***************************************************************
  EXPORT i_ACCNBRV1 := KEY_PREFIX + '_' + ACCNBRV1_SUFFIX;
  EXPORT i_ACCNBRV1_SF := i_ACCNBRV1 + '_' + VERSION;
 
  EXPORT i_ACCNBR := KEY_PREFIX + '_' + ACCNBR_SUFFIX;
  EXPORT i_ACCNBR_SF := i_ACCNBR + '_' + VERSION;
 
  EXPORT i_BDID := KEY_PREFIX + '_' + BDID_SUFFIX;
  EXPORT i_BDID_SF := i_BDID + '_' + VERSION;
 
  EXPORT i_DID := KEY_PREFIX + '_' + DID_SUFFIX;
  EXPORT i_DID_SF := i_DID + '_' + VERSION;
 
  EXPORT i_DL_NBR := KEY_PREFIX + '_' + DL_NBR_SUFFIX;
  EXPORT i_DL_NBR_SF := i_DL_NBR + '_' + VERSION;
 
  EXPORT i_TAG_NBR := KEY_PREFIX + '_' + TAG_NBR_SUFFIX;
  EXPORT i_TAG_NBR_SF := i_TAG_NBR + '_' + VERSION;
 
  EXPORT i_VIN7 := KEY_PREFIX + '_' + VIN7_SUFFIX;
  EXPORT i_VIN7_SF := i_VIN7 + '_' + VERSION;
 
  EXPORT i_VIN := KEY_PREFIX + '_' + VIN_SUFFIX;
  EXPORT i_VIN_SF := i_VIN + '_' + VERSION;
 
//***********************************************************************
//                Ecrash Analytics keys suffix
//***********************************************************************
  EXPORT ANALYTICS_BY_AGENCY_ID_SUFFIX := 'analytics_byagencyid'; 
  EXPORT ANALYTICS_BY_COLLISION_TYPE_SUFFIX := 'analytics_bycollisiontype'; 
  EXPORT ANALYTICS_BY_DOW_SUFFIX := 'analytics_bydow'; 
  EXPORT ANALYTICS_BY_HOD_SUFFIX := 'analytics_byhod'; 
  EXPORT ANALYTICS_BY_INTER_SUFFIX := 'analytics_byinter';
  EXPORT ANALYTICS_BY_MOY_SUFFIX := 'analytics_bymoy';
 
//***************************************************************
//           Ecrash Analytics keys File definitions
//***************************************************************
  EXPORT i_ANALYTICS_BY_AGENCY_ID := KEY_PREFIX + '::' + ANALYTICS_BY_AGENCY_ID_SUFFIX;
  EXPORT i_ANALYTICS_BY_AGENCY_ID_SF := i_ANALYTICS_BY_AGENCY_ID + '_' + VERSION;
  
  EXPORT i_ANALYTICS_BY_COLLISION_TYPE := KEY_PREFIX + '::' + ANALYTICS_BY_COLLISION_TYPE_SUFFIX;
  EXPORT i_ANALYTICS_BY_COLLISION_TYPE_SF := i_ANALYTICS_BY_COLLISION_TYPE + '_' + VERSION;
  
  EXPORT i_ANALYTICS_BY_DOW := KEY_PREFIX + '::' + ANALYTICS_BY_DOW_SUFFIX;
  EXPORT i_ANALYTICS_BY_DOW_SF := i_ANALYTICS_BY_DOW + '_' + VERSION;
  
  EXPORT i_ANALYTICS_BY_HOD := KEY_PREFIX + '::' + ANALYTICS_BY_HOD_SUFFIX;
  EXPORT i_ANALYTICS_BY_HOD_SF := i_ANALYTICS_BY_HOD + '_' + VERSION;
  
  EXPORT i_ANALYTICS_BY_INTER := KEY_PREFIX + '::' + ANALYTICS_BY_INTER_SUFFIX;
  EXPORT i_ANALYTICS_BY_INTER_SF := i_ANALYTICS_BY_INTER + '_' + VERSION;
  
  EXPORT i_ANALYTICS_BY_MOY := KEY_PREFIX + '::' + ANALYTICS_BY_MOY_SUFFIX;
  EXPORT i_ANALYTICS_BY_MOY_SF := i_ANALYTICS_BY_MOY + '_' + VERSION;
 
//***********************************************************************
//                Ecrash keys suffix
//***********************************************************************
  EXPORT AGENCY_SUFFIX := 'agency';
  EXPORT AGENCYSOURCE_SUFFIX := 'agencysource';
  EXPORT UNRESTRICTED_ACCNBRV1_SUFFIX := 'unrestricted_accnbrv1'; 
  EXPORT PHOTO_ID_SUFFIX := 'PhotoId';
  EXPORT DOL_SUFFIX := 'dol';
  EXPORT DELTA_DATE_SUFFIX := 'deltadate'; 
  EXPORT REPORT_ID_SUFFIX := 'reportid'; 
  EXPORT SUPPLEMENTAL_SUFFIX := 'supplemental'; 

//***************************************************************
//           Ecrash keys File definitions
//***************************************************************
  EXPORT i_AGENCY := KEY_PREFIX + '_' + AGENCY_SUFFIX; 
  EXPORT i_AGENCY_SF := i_AGENCY + '_' + VERSION; 
	
  EXPORT i_AGENCYSOURCE := KEY_PREFIX + '_' + AGENCYSOURCE_SUFFIX; 
  EXPORT i_AGENCYSOURCE_SF := i_AGENCYSOURCE + '_' + VERSION; 
  
  EXPORT i_UNRESTRICTED_ACCNBRV1 := KEY_PREFIX + '_' + UNRESTRICTED_ACCNBRV1_SUFFIX;
  EXPORT i_UNRESTRICTED_ACCNBRV1_SF := i_UNRESTRICTED_ACCNBRV1 + '_' + VERSION;
 
  EXPORT i_PHOTO_ID := KEY_PREFIX + '_' + PHOTO_ID_SUFFIX; 
  EXPORT i_PHOTO_ID_SF := i_PHOTO_ID + '_' + VERSION; 
  
  EXPORT i_DOL := KEY_PREFIX + '_' + DOL_SUFFIX;
  EXPORT i_DOL_SF := i_DOL + '_' + VERSION;
  
  EXPORT i_DELTA_DATE := KEY_PREFIX + '_' + DELTA_DATE_SUFFIX;
  EXPORT i_DELTA_DATE_SF := i_DELTA_DATE + '_' + VERSION;
  
  EXPORT i_REPORT_ID := KEY_PREFIX + '_' + REPORT_ID_SUFFIX;
  EXPORT i_REPORT_ID_SF := i_REPORT_ID + '_' + VERSION;
  
  EXPORT i_SUPPLEMENTAL := KEY_PREFIX + '_' + SUPPLEMENTAL_SUFFIX;
  EXPORT i_SUPPLEMENTAL_SF := i_SUPPLEMENTAL + '_' + VERSION;
  
//***********************************************************************
//                Ecrash Search keys suffix
//***********************************************************************
  EXPORT DLN_NBR_DL_STATE_SUFFIX := 'dlnnbrdlstate'; 
  EXPORT LAST_NAME_STATE_SUFFIX := 'lastname_state'; 
  EXPORT LICENSE_PLATE_NBR_SUFFIX := 'licenseplatenbr'; 
  EXPORT OFFICER_BADGE_NBR_STATE_SUFFIX := 'officerbadgenbr'; 
  EXPORT PREFNAME_STATE_SUFFIX := 'prefname_state'; 
  EXPORT ST_AND_LOCATION_SUFFIX := 'standlocation'; 
  EXPORT VINNBR_SUFFIX := 'vinnbr';
  EXPORT AGENCY_ID_SENT_DATE_STATE_SUFFIX := 'agencyid_sentdate';

//***************************************************************
//           Ecrash Search keys File definitions
//*************************************************************** 
  EXPORT i_DLN_NBR_DL_STATE := KEY_PREFIX + '_' + DLN_NBR_DL_STATE_SUFFIX;
  EXPORT i_DLN_NBR_DL_STATE_SF := i_DLN_NBR_DL_STATE + '_' + VERSION;
  
  EXPORT i_LAST_NAME_STATE := KEY_PREFIX + '_' + LAST_NAME_STATE_SUFFIX;
  EXPORT i_LAST_NAME_STATE_SF := i_LAST_NAME_STATE + '_' + VERSION;
  
  EXPORT i_LICENSE_PLATE_NBR := KEY_PREFIX + '_' + LICENSE_PLATE_NBR_SUFFIX;
  EXPORT i_LICENSE_PLATE_NBR_SF := i_LICENSE_PLATE_NBR + '_' + VERSION;
  
  EXPORT i_OFFICER_BADGE_NBR_STATE := KEY_PREFIX + '_' + OFFICER_BADGE_NBR_STATE_SUFFIX;
  EXPORT i_OFFICER_BADGE_NBR_STATE_SF := i_OFFICER_BADGE_NBR_STATE + '_' + VERSION;
  
  EXPORT i_PREFNAME_STATE := KEY_PREFIX + '_' + PREFNAME_STATE_SUFFIX;
  EXPORT i_PREFNAME_STATE_SF := i_PREFNAME_STATE + '_' + VERSION;
  
  EXPORT i_ST_AND_LOCATION := KEY_PREFIX + '_' + ST_AND_LOCATION_SUFFIX;
  EXPORT i_ST_AND_LOCATION_SF := i_ST_AND_LOCATION + '_' + VERSION;
  
  EXPORT i_VINNBR := KEY_PREFIX + '_' + VINNBR_SUFFIX;
  EXPORT i_VINNBR_SF := i_VINNBR + '_' + VERSION;
  
  EXPORT i_AGENCY_ID_SENT_DATE_STATE := KEY_PREFIX + '_' + AGENCY_ID_SENT_DATE_STATE_SUFFIX;
  EXPORT i_AGENCY_ID_SENT_DATE_STATE_SF := i_AGENCY_ID_SENT_DATE_STATE + '_' + VERSION;
END;
