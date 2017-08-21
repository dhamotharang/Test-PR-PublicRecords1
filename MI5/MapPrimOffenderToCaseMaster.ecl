
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

AZCR_court_desc := if(L.OLD_RECORD_SUPPLIER_CD_C = 'AZCR',
															trim(					 
															MAP(L.court_desc = 'CASA GRANDE JUSTICE' =>'CGJ',
																	L.court_desc = 'CASA GRANDE MUNICIPAL' =>'CGM',
																	L.court_desc = 'APACHE JUNCTION JUSTICE' =>'AJJ',
																	L.court_desc = 'APACHE JUNCTION MUNICIPAL' =>'AJM',
																	L.court_desc = 'QUARTZSITE MUNICIPAL' =>'QM',
																	L.court_desc = 'QUARTZSITE JUSTICE' =>'QJ',
																	L.court_desc = 'BULLHEAD CITY JUSTICE' =>'BCJ',
																	L.court_desc = 'BULLHEAD CITY MUNI' =>'BCM',
																	L.court_desc = 'PINETOP-LAKESIDE JUSTICE' =>'PLJ',
																	L.court_desc = 'PINETOP-LAKESIDE MUNICIPAL' =>'PLM',
																	L.court_desc = 'FLAGSTAFF JUSTICE' =>'FJ',
																	L.court_desc = 'FLAGSTAFF MUNICIPAL' =>'FM',
																	L.court_desc = 'LAKE HAVASU CITY JUSTICE' =>'LHCJ',
																	L.court_desc = 'LAKE HAVASU MUNI'=>'LHM',
																	L.court_desc = 'SIERRA VISTA JUSTICE' =>'SVJ',
																	L.court_desc = 'SIERRA VISTA MUNICIPAL'  =>'SVM',
																	L.court_desc) [ ..10]),''); 
																	
																	
SOURCE_UID_C := MAP(TRIM(L.COURT_ID) = 'court_code' => L.court_cd,
											       TRIM(L.COURT_ID) = 'court_desc' => L.court_desc, 
														     TRIM(L.COURT_ID) = 'old_rec_supplier_cd' => L.OLD_RECORD_SUPPLIER_CD_C, L.COURT_ID );																	


TRANS_NUM := (STRING) L.ECL_CADE_ID;
C := L.ECL_CADE_ID;
FOUR_DIGIT_TRANS_NUM := IF(LENGTH(TRANS_NUM) <=4,INTFORMAT(C,4,1),TRANS_NUM[LENGTH(TRANS_NUM)-3.. ]);
CASE_NUM_WITH_TRANS_NUM := IF(L.CASE_NUMBER<>'',TRIM(L.CASE_NUMBER) + FOUR_DIGIT_TRANS_NUM
										     ,(String) HASH(L.OFFENDER_KEY+L.CASE_COURT)+ FOUR_DIGIT_TRANS_NUM);
USE_FIRST_LOGIC_NAMES := //IF(L.LNAME + L.FNAME + L.MNAME + L.NAME_SUFFIX <> '','Y','N'); 
                         IF(L.LNAME <> '','Y','N');
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
SELF.CAMA_ID := '';                     
SELF.CASE_TYPE_CD := '1';        
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
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
SELF.SOURCE_UID_C := if(L.OLD_RECORD_SUPPLIER_CD_C <> 'AZCR',SOURCE_UID_C,AZCR_court_desc);


                          // MAP(TRIM(L.COURT_ID) = 'court_code' => L.court_cd,
											       // TRIM(L.COURT_ID) = 'court_desc' => L.court_desc, 
														     // TRIM(L.COURT_ID) = 'old_rec_supplier_cd' => L.OLD_RECORD_SUPPLIER_CD_C, L.COURT_ID );
																 
																 
																 
                      //MAP(L.CASE_COURT <> '' => L.CASE_COURT,
                       //   L.Vendor_descr <> '' => L.Vendor_descr,
													//  L.OLD_RECORD_SUPPLIER_CD_C);
                           //MAP(L.CASE_COURT <> '' => L.CASE_COURT,
                            // FN_Get_CodesV3_descr('CRIM_OFFENDER2','VENDOR','',StringLib.StringToUpperCase(L.VENDOR)) <> ''
														   //  => FN_Get_CodesV3_descr('CRIM_OFFENDER2','VENDOR','',StringLib.StringToUpperCase(L.VENDOR)),L.OLD_RECORD_SUPPLIER_CD_C);
SELF.SOURCE_STATE_CD_C := '';
SELF.SOURCE_COUNTY_CD_C := '';
SELF.SOURCE_COUNTY_NAME_C := '';
SELF.DISTRICT_NAME_UID := '';
SELF.CADE_CADE_ID := '';
SELF.CASE_SUBJECT_SEQ_C := '1';
SELF.CREATED_BY := 'INFRMLOAD';
SELF.CREATION_DT := '';//StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';
SELF.LAST_UPDATE_DT := '';
SELF.BATCH_NUMBER := '';
SELF.DOB := //IF(LENGTH(TRIM(L.DOB))=8,L.DOB,'.'); 
            IF(_validate.date.fIsValid(L.DOB)=true,L.DOB,'.');
SELF.SSN := //MAP(L.ORIG_SSN<>'' => L.ORIG_SSN,
                        //  L.SSN<>'' => L.SSN,
		                    //  '.'); 
												MAP(L.ORIG_SSN<>'' => L.ORIG_SSN, '.'); 
												
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
SELF.SUBJECT_AGE := '';
SELF.NC_DOB := //IF(LENGTH(TRIM(L.DOB))<>8,L.DOB,''); 
               IF(_validate.date.fIsValid(L.DOB)=false,L.DOB,'');
SELF := [];
END;
		
ds_CaseMasterPrimary := PROJECT(File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCaseMaster(LEFT));  

export MapPrimOffenderToCaseMaster := SORT(ds_CaseMasterPrimary,ecl_cade_id);