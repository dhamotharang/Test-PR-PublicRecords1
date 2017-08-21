

import crim_common;
import crim_cp_ln;
import _validate;

// Layout_CaseMaster_Offender_key := RECORD
// INTEGER ecl_cade_id;
// crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
// crim_cp_ln.Layout_cross_case_master;
// end;


Layout_CaseMaster_Offender_key := Layout_case_master_cp;

//Layout_CaseMaster_Offender_key tr_PrimOffenderToCaseMaster(File_Primary_Offender_ECL_Cade_id L, INTEGER C ) := TRANSFORM
//TRANS_NUM := (STRING) C;
//FOUR_DIGIT_TRANS_NUM := IF(LENGTH(TRANS_NUM) <=4,INTFORMAT(C,4,1),TRANS_NUM[LENGTH(TRANS_NUM)-3.. ]);

Layout_CaseMaster_Offender_key tr_PrimOffenderToCaseMaster(File_Primary_Offender_ECL_Cade_id L) := TRANSFORM
//TRANS_NUM := TRIM(L.ECL_CADE_ID);
//C := (INTEGER) TRIM(L.ECL_CADE_ID);
TRANS_NUM := (STRING) L.ECL_CADE_ID;
C := L.ECL_CADE_ID;
FOUR_DIGIT_TRANS_NUM := IF(LENGTH(TRANS_NUM) <=4,INTFORMAT(C,4,1),TRANS_NUM[LENGTH(TRANS_NUM)-3.. ]);
CASE_NUM_WITH_TRANS_NUM       //:= IF(L.CASE_NUMBER<>'',TRIM(L.CASE_NUMBER) + FOUR_DIGIT_TRANS_NUM
										          // ,(String) HASH(L.OFFENDER_KEY+L.CASE_COURT)+ FOUR_DIGIT_TRANS_NUM);
												:= (String) HASH(L.OFFENDER_KEY+L.CASE_COURT)+ FOUR_DIGIT_TRANS_NUM;
USE_FIRST_LOGIC_NAMES := //IF(L.LNAME + L.FNAME + L.MNAME + L.NAME_SUFFIX <> '','Y','N'); 
                         IF(L.LNAME <> '','Y','N');
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
//SELF.CAMA_ID := '';                     
SELF.CASE_TYPE_CD := '1';        
SELF.RECORD_SUPPLIER_CD_C := 
                                                      Map(l.source_file = 'NJ_DOC' and l.case_type =  'ADM' => '9041',
																											        l.source_file = 'NJ_DOC' and l.case_type =  'REL' => '9041',
																															l.source_file = 'NJ_DOC' and l.case_type =  'RES' => '9040',	
                                                              l.RECORD_SUPPLIER_CD_C);
SELF.JURISDICTION_FLG := 'S';         
SELF.CASE_NUM_C := CASE_NUM_WITH_TRANS_NUM;              
SELF.SUBJECT_LAST_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',L.LNAME,''); 
SELF.SUBJECT_FIRST_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.FNAME<>'',L.FNAME,'.'),'');  
SELF.SUBJECT_MIDDLE_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.MNAME<>'',L.MNAME,'.'),''); 
SELF.SUBJECT_NAME_SUFFIX_C := IF(USE_FIRST_LOGIC_NAMES='Y',IF(L.NAME_SUFFIX<>'',L.NAME_SUFFIX,'.'),''); 
SELF.SUBJECT_FULL_NAME_C := IF(USE_FIRST_LOGIC_NAMES='Y',TRIM(IF(LENGTH(TRIM(L.LNAME))> 0,TRIM(L.LNAME) + ' ','')
																												 + IF(LENGTH(TRIM(L.FNAME))> 0,TRIM(L.FNAME) + ' ','')
																													+ IF(LENGTH(TRIM(L.MNAME))> 0,TRIM(L.MNAME) + ' ','')
																														+ IF(LENGTH(TRIM(L.NAME_SUFFIX))> 0,TRIM(L.NAME_SUFFIX) + ' ',''))
																														   ,TRIM(L.PTY_NM,LEFT,RIGHT) + '~^' + L.PTY_NM_FMT);
SELF.SUBJECT_TYPE_FLG_C := '';
SELF.SOURCE_UID_C :=  L.COURT_ID;
SELF.SOURCE_STATE_CD_C :=  L.state_origin;
SELF.SOURCE_COUNTY_CD_C := '0';
SELF.SOURCE_COUNTY_NAME_C := 'No County';  //TRIM(L.DID);
SELF.DISTRICT_NAME_UID := '638';
SELF.CADE_CADE_ID := '';
SELF.CASE_SUBJECT_SEQ_C := '1';
SELF.CREATED_BY := 'HPCCLOAD';
SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';
SELF.LAST_UPDATE_DT := '';
SELF.BATCH_NUMBER := '';
SELF.DOB := //IF(LENGTH(TRIM(L.DOB))=8,L.DOB,'.'); 
            IF(_validate.date.fIsValid(L.DOB)=true,L.DOB,'.');
SELF.SSN := MAP(L.ORIG_SSN<>'' => L.ORIG_SSN,
                          L.SSN<>'' => L.SSN,
		                      '.'); 
SELF.OLD_RECORD_SUPPLIER_CD_C := 
                                                              Map(l.source_file = 'NJ_DOC' and l.case_type =  'ADM' => 'NJAD',
																											                l.source_file = 'NJ_DOC' and l.case_type =  'REL' => 'NJRL',
																															        l.source_file = 'NJ_DOC' and l.case_type =  'RES' => 'NJRS',	
                                                                      L.OLD_RECORD_SUPPLIER_CD_C);
																															
SELF.SUBJECT_AGE := '';
SELF.NC_DOB := //IF(LENGTH(TRIM(L.DOB))<>8,L.DOB,''); 
               IF(_validate.date.fIsValid(L.DOB)=false,L.DOB,'');
SELF := [];
END;
		
ds_CaseMasterPrimary := PROJECT(File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCaseMaster(LEFT));  

export MapPrimOffenderToCaseMaster := SORT(ds_CaseMasterPrimary,ecl_cade_id);

