

import _validate;

Layout_CaseMaster_Offender_key := Layout_case_master_cp;

Layout_CaseMaster_Offender_key tr_PrimOffenderToCaseMaster(Distribute_File_Primary_Offender_ECL_Cade_id L) := TRANSFORM
																	
SOURCE_UID_C := L.COURT_ID;		

AliasNickNames := TRIM(TRIM(L.orig_lastname,left,right)  + ' ' + TRIM(L.orig_firstname,left,right) + ' ' +TRIM(L.orig_middlename,left,right) + ' ' + TRIM(L.orig_suffix,left,right), left, right);

TRANS_NUM := (STRING) L.ECL_CADE_ID;
C := L.ECL_CADE_ID;
FOUR_DIGIT_TRANS_NUM := IF(LENGTH(TRANS_NUM) <=4,INTFORMAT(C,4,1),TRANS_NUM[LENGTH(TRANS_NUM)-3.. ]);
CASE_NUM_WITH_TRANS_NUM := (String) HASH(L.Seisint_Primary_Key)+ FOUR_DIGIT_TRANS_NUM;
USE_FIRST_LOGIC_NAMES := //IF(L.LNAME + L.FNAME + L.MNAME + L.NAME_SUFFIX <> '','Y','N'); 
                         IF(L.orig_lastname <> '','Y','N');
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.offender_key := L.Seisint_Primary_Key;
//SELF.CAMA_ID := '';                     
SELF.CASE_TYPE_CD := '1';        
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF.JURISDICTION_FLG := 'S';         
SELF.CASE_NUM_C := CASE_NUM_WITH_TRANS_NUM;              
SELF.SUBJECT_LAST_NAME_C :=     IF(USE_FIRST_LOGIC_NAMES='Y',L.orig_lastname,TRIM(AliasNickNames)); 
                                                     //IF(USE_FIRST_LOGIC_NAMES='Y',L.LNAME,''); 
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
SELF.SUBJECT_TYPE_FLG_C := '';
SELF.SOURCE_UID_C := SOURCE_UID_C;
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
SELF.DOB :=  IF(_validate.date.fIsValid(L.DOB)=true,L.DOB,'.');
SELF.SSN := MAP(L.SSN<>'' => L.SSN, '.'); 
												
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
SELF.SUBJECT_AGE := '';
SELF.NC_DOB :=  IF(_validate.date.fIsValid(L.DOB)=false,L.DOB[1..4],'');
SELF := [];
END;
		
ds_CaseMasterPrimary := PROJECT(Distribute_File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCaseMaster(LEFT));  

export MapPrimOffenderToCaseMaster := SORT(ds_CaseMasterPrimary,ecl_cade_id)
                                                                   : persist ('~thor_data400::persist::out::crim::cross_soff::MapPrimOffenderToCaseMaster');


