

import crim_common;
import crim_cp_ln;
import hygenics_soff;
 
Layout_Case_Master_and_soff_out_main := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
CM_DOB := MapPrimOffenderToCaseMaster.DOB;
CM_SSN := MapPrimOffenderToCaseMaster.SSN;
CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
CM_SOURCE_UID := MapPrimOffenderToCaseMaster.source_uid_c;
INTEGER ecl_cade_id;
hygenics_soff.Layout_Out_Main_cross;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
Layout_LN_Cross_Extract_Driver.court_id;
END;

Layout_CaseMaster_Offender_key := Layout_case_master_cp;

Layout_Case_Master_and_soff_out_main tr_Attach_CM_Constants_OffenderAlias(MapPrimOffenderToCaseMaster L, File_Alias_Offender_ECL_Cade_id R) := TRANSFORM
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

AliasNickNames := TRIM(TRIM(L.orig_lastname,left,right)  + ' ' + TRIM(L.orig_firstname,left,right) + ' ' +TRIM(L.orig_middlename,left,right) + ' ' + TRIM(L.orig_suffix,left,right), left, right);

USE_FIRST_LOGIC_NAMES := //IF(L.LNAME + L.FNAME + L.MNAME + L.NAME_SUFFIX <> '','Y','N');
                          IF(L.orig_lastname <> '','Y','N');
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.Seisint_Primary_Key;
//SELF.CAMA_ID := '';                    
SELF.CASE_TYPE_CD := '1';         
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF.JURISDICTION_FLG := 'S';    
SELF.CASE_NUM_C := L.CM_CASE_NUM;  //Case Number taken from primary case master name.              
SELF.SUBJECT_LAST_NAME_C :=     IF(USE_FIRST_LOGIC_NAMES='Y',L.orig_lastname,TRIM(AliasNickNames)); 
                                               //IF(USE_FIRST_LOGIC_NAMES='Y',L.LNAME,'.'); 
SELF.SUBJECT_FIRST_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.orig_firstname<>'',L.orig_firstname,'.'),'.');   
SELF.SUBJECT_MIDDLE_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.orig_middlename<>'',L.orig_middlename,'.'),'.'); 
SELF.SUBJECT_NAME_SUFFIX_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.orig_suffix<>'',L.orig_suffix,'.'),'.'); 
SELF.SUBJECT_FULL_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',
                                                                                      TRIM(IF(LENGTH(TRIM(L.orig_lastname))> 0,TRIM(L.orig_lastname) + ' ','')
																												                                   + IF(LENGTH(TRIM(L.orig_firstname))> 0,TRIM(L.orig_firstname) + ' ','')
																													                                 + IF(LENGTH(TRIM(L.orig_middlename))> 0,TRIM(L.orig_middlename) + ' ','')
																														                               + IF(LENGTH(TRIM(L.orig_suffix))> 0,TRIM(L.orig_suffix) + ' ',''))
																														                                  //,TRIM(L.PTY_NM,LEFT,RIGHT) + '~^' + L.PTY_NM_FMT);
																															                               ,TRIM(AliasNickNames,LEFT,RIGHT));
SELF.SUBJECT_TYPE_FLG_C := 'A';
SELF.SOURCE_UID_C :=  L.CM_SOURCE_UID; //Source UID taken from primary case master name.
SELF.SOURCE_STATE_CD_C := '';
SELF.SOURCE_COUNTY_CD_C := '';
SELF.SOURCE_COUNTY_NAME_C := '';
SELF.DISTRICT_NAME_UID := '';
SELF.CADE_CADE_ID := '';
SELF.CASE_SUBJECT_SEQ_C := '1';
SELF.CREATED_BY := 'HPCCLOAD';
SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
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
  
export MapAliasOffenderToCaseMaster := SORT(ds_CaseMasterAlias,ecl_cade_id)
                                                                    : persist ('~thor_data400::persist::out::crim::cross_soff::MapAliasOffenderToCaseMaster');   
