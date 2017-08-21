
import crim_common;
import crim_cp_ln;
 
Layout_Case_Master_and_Moxie_Crim_Offender := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
CM_DOB := MapPrimOffenderToCaseMaster.DOB;
CM_SSN := MapPrimOffenderToCaseMaster.SSN;
CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
CM_SOURCE_UID := MapPrimOffenderToCaseMaster.source_uid_c;
INTEGER ecl_cade_id;
Crim_Common.Layout_Moxie_Crim_Offender2.previous; 
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
//Layout_LN_Cross_Extract_Driver.court_id;
//Crim_Common.Layout_Moxie_Court_Offenses.court_cd;
//Crim_Common.Layout_Moxie_Court_Offenses.court_desc;	
END;

// Layout_CaseMaster_Offender_key := RECORD
// INTEGER ecl_cade_id;
// crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
// crim_cp_ln.Layout_cross_case_master;
// end;

Layout_CaseMaster_Offender_key := Layout_case_master_cp;

Layout_Case_Master_and_Moxie_Crim_Offender tr_Attach_CM_Constants_OffenderAlias(MapPrimOffenderToCaseMaster L, File_Alias_Offender_ECL_Cade_id R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
SELF.CM_DOB := L.DOB;																																	 
SELF.CM_SSN := L.SSN;
SELF.CM_NC_DOB := L.NC_DOB;
SELF.CM_SOURCE_UID := L.SOURCE_UID_C;
SELF := R;
END;

ds_CaseMasterAndOffAlias := JOIN(MapPrimOffenderToCaseMaster,File_Alias_Offender_ECL_Cade_id,
																		  LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																			 tr_Attach_CM_Constants_OffenderAlias(LEFT,RIGHT));
                                 

Layout_CaseMaster_Offender_key  tr_AliasOffenderToCaseMaster(ds_CaseMasterAndOffAlias L) := TRANSFORM
USE_FIRST_LOGIC_NAMES := //IF(L.LNAME + L.FNAME + L.MNAME + L.NAME_SUFFIX <> '','Y','N');
                          IF(L.LNAME <> '','Y','N');
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
SELF.CAMA_ID := '';                     
SELF.CASE_TYPE_CD := '1';         
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF.JURISDICTION_FLG := 'S';    
SELF.CASE_NUM_C := L.CM_CASE_NUM;  //Case Number taken from primary case master name.              
SELF.SUBJECT_LAST_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',L.LNAME,''); 
SELF.SUBJECT_FIRST_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.FNAME<>'',L.FNAME,'.'),'');   
SELF.SUBJECT_MIDDLE_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.MNAME<>'',L.MNAME,'.'),''); 
SELF.SUBJECT_NAME_SUFFIX_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.NAME_SUFFIX<>'',L.NAME_SUFFIX,'.'),''); 
SELF.SUBJECT_FULL_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',TRIM(IF(LENGTH(TRIM(L.LNAME))> 0,TRIM(L.LNAME) + ' ','')
																												 + IF(LENGTH(TRIM(L.FNAME))> 0,TRIM(L.FNAME) + ' ','')
																													+ IF(LENGTH(TRIM(L.MNAME))> 0,TRIM(L.MNAME) + ' ','')
																														+ IF(LENGTH(TRIM(L.NAME_SUFFIX))> 0,TRIM(L.NAME_SUFFIX) + ' ',''))
																														   ,TRIM(L.PTY_NM,LEFT,RIGHT) + '~^' + L.PTY_NM_FMT);
SELF.SUBJECT_TYPE_FLG_C := 'A';
SELF.SOURCE_UID_C := //MAP(TRIM(L.COURT_ID) = L.COURT_CD => L.court_cd,
											//       TRIM(L.COURT_ID) = L.COURT_DESC => L.court_desc, L.OLD_RECORD_SUPPLIER_CD_C);
                    L.CM_SOURCE_UID;
SELF.SOURCE_STATE_CD_C := '';
SELF.SOURCE_COUNTY_CD_C := '';
SELF.SOURCE_COUNTY_NAME_C := '';
SELF.DISTRICT_NAME_UID := '';
SELF.CADE_CADE_ID := '';
SELF.CASE_SUBJECT_SEQ_C := '1';
SELF.CREATED_BY := 'INFRMLOAD';
SELF.CREATION_DT := ''; //StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';
SELF.LAST_UPDATE_DT := '';
SELF.BATCH_NUMBER := '';
SELF.DOB := L.CM_DOB; //DOB taken from primary case master name.
SELF.SSN := L.CM_SSN; //SSN taken from primary case master name.
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
SELF.SUBJECT_AGE := '';
SELF.NC_DOB := L.CM_NC_DOB;  //NC_DOB taken from primary case master name.
SELF := [];
END;

		
ds_CaseMasterAlias := PROJECT(ds_CaseMasterAndOffAlias,tr_AliasOffenderToCaseMaster(LEFT));
  
export MapAliasOffenderToCaseMaster := SORT(ds_CaseMasterAlias,ecl_cade_id);
