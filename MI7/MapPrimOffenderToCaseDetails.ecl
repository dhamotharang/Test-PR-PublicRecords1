



import crim_common;
import crim_cp_ln;
import _validate;

Layout_case_details_Offender_key := Layout_case_details_cp;

Layout_case_details_Offender_key   tr_PrimOffenderToCaseDetails(File_Primary_Offender_ECL_Cade_id L) := TRANSFORM 
  
  STRING1 USE_ADDRESS_CLEANER := IF(TRIM(L.PRIM_RANGE) + TRIM(L.PREDIR) + TRIM(L.PRIM_NAME) + TRIM(L.ADDR_SUFFIX) + TRIM(L.POSTDIR) + 
	                                  TRIM(L.UNIT_DESIG) + TRIM(L.SEC_RANGE) + TRIM(L.P_CITY_NAME) + TRIM(L.STATE) + TRIM(L.ZIP5) + TRIM(L.ZIP4) <> '','Y','N');
  SELF.ECL_CADE_ID := L.ECL_CADE_ID;
  SELF.OFFENDER_KEY := L.OFFENDER_KEY; 
  SELF.CADE_ID := '';
	SELF.CASE_DT_C := IF(_validate.date.fIsValid(L.CASE_FILING_DT)=true,L.CASE_FILING_DT,'');
	SELF.CASE_SUFFIX_FLG := '';
	SELF.CASE_CATEGORY_CD_C := '';
	SELF.CASE_YEAR := '';
	SELF.DOCKET_SEQ_F := L.CASE_NUMBER;
	SELF.ORIG_SOURCE_DIVISION_NAME := L.CASE_COURT;
	SELF.DOCUMENT_NUMBER_F := L.DOC_NUM;
	SELF.SUBJECT_STATUS_FLG := '';
	SELF.SUBJECT_ID := L.DOC_NUM;
	SELF.SUBJECT_TYPE := '';
	SELF.SUBJECT_SSN_C := //MAP(L.ORIG_SSN<>'' => TRIM(L.ORIG_SSN),
                         // L.SSN<>'' => TRIM(L.SSN),
		                     // '.');
												 MAP(L.ORIG_SSN<>'' => L.ORIG_SSN, '.'); 
												 
	SELF.SUBJECT_DOB_C := //IF(LENGTH(TRIM(L.DOB))=8,TRIM(L.DOB),'');
	                      IF(_validate.date.fIsValid(L.DOB)=true,L.DOB,'');
	SELF.SUBJECT_SEX_CD_C := // CASE(TRIM(L.SEX_DESCR,LEFT,RIGHT),'Male' => 'M', 'Female'=> 'F', 'O');	
	                             //L.SEX_DESCR;	
															 l.sex;
	                         //CASE(TRIM(FN_Get_CodesV3_descr('CRIM_OFFENDER2','SEX','',L.SEX),LEFT,RIGHT),'Male' => 'M', 'Female'=> 'F', 'O');
	                         // CASE(TRIM(FN_Get_CodesV3_descr('CRIM_OFFENDER2','SEX','',StringLib.StringToUpperCase(L.SEX)),LEFT,RIGHT),'Male' => 'M', 'Female'=> 'F', 'O');
	SELF.SUBJECT_RACE_CD_C := IF(L.RACE_DESC<>'',
	                                           REGEXREPLACE('All Others ',REGEXREPLACE('ALL OTHERS',REGEXREPLACE('Corporation',REGEXREPLACE('UNKNOWN',
	                                           REGEXREPLACE('Toe(s), left foot',REGEXREPLACE('OTHER',REGEXREPLACE('Male',REGEXREPLACE('FEMALE',REGEXREPLACE('Unknown/Other',TRIM(L.RACE_DESC),'', NOCASE)
																						 ,'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
																							REGEXREPLACE('t',REGEXREPLACE('`',
																							REGEXREPLACE('Q',REGEXREPLACE('Y',
																							REGEXREPLACE('X',REGEXREPLACE('UN',REGEXREPLACE('U',REGEXREPLACE('OTH',REGEXREPLACE('OT',REGEXREPLACE('9',REGEXREPLACE('8',REGEXREPLACE('88',REGEXREPLACE('7',
																							REGEXREPLACE('6',
																							REGEXREPLACE('5',REGEXREPLACE('4',REGEXREPLACE('3',
																							REGEXREPLACE('2',REGEXREPLACE('1',REGEXREPLACE('0',REGEXREPLACE('!',TRIM(L.RACE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
																							'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE)
																								);
	SELF.SUBJECT_ADDRESS_LINE_1_C := TRIM(IF(USE_ADDRESS_CLEANER='Y', IF(LENGTH(TRIM(L.PRIM_RANGE))>0,TRIM(L.PRIM_RANGE) + ' ','') +
																																		IF(LENGTH(TRIM(L.PREDIR))>0,TRIM(L.PREDIR) + ' ','') +
																																		IF(LENGTH(TRIM(L.PRIM_NAME))>0,TRIM(L.PRIM_NAME) + ' ','') +
																																		IF(LENGTH(TRIM(L.ADDR_SUFFIX))>0,TRIM(L.ADDR_SUFFIX) + ' ','') +
																																		IF(LENGTH(TRIM(L.POSTDIR))>0,TRIM(L.POSTDIR) + ' ',''),
																																			 IF(LENGTH(TRIM(L.STREET_ADDRESS_1))>0,TRIM(L.STREET_ADDRESS_1) + ' ','') +
																																			 IF(LENGTH(TRIM(L.STREET_ADDRESS_2))>0,TRIM(L.STREET_ADDRESS_2) + ' ','') +
																																			 IF(LENGTH(TRIM(L.STREET_ADDRESS_3))>0,TRIM(L.STREET_ADDRESS_3) + ' ','')
																																	   ));
	SELF.SUBJECT_ADDRESS_LINE_2_C := TRIM(IF(USE_ADDRESS_CLEANER='Y', IF(LENGTH(TRIM(L.UNIT_DESIG))>0,TRIM(L.UNIT_DESIG) + ' ','') +
																																		IF(LENGTH(TRIM(L.SEC_RANGE))>0,TRIM(L.SEC_RANGE) + ' ',''),
																																			IF(LENGTH(TRIM(L.STREET_ADDRESS_4))>0,TRIM(L.STREET_ADDRESS_4) + ' ','') +
																																			IF(LENGTH(TRIM(L.STREET_ADDRESS_5))>0,TRIM(L.STREET_ADDRESS_5) + ' ','')
																																	   ));																															   
	SELF.SUBJECT_CITY_NAME_C := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.P_CITY_NAME),'');
	SELF.SUBJECT_STATE_CD_C := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.STATE),'');
	SELF.SUBJECT_ZIP_CD_C := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.ZIP5),'');
	SELF.SUBJECT_ZIP_4 := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.ZIP4),'');
	SELF.CASE_DISPOSITION_MESSAGE := '';
	SELF.CRSU_CRSU_ID := L.ECL_CADE_ID;
	SELF.SENTENCE_DISPOSITION_MOD_DT_F := '';
	SELF.CASE_DISPOSITION_DT_C := '';
	SELF.CREATED_BY := 'HPCCLOAD';
	SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
	SELF.LAST_UPDATED_BY := '';
	SELF.LAST_UPDATE_DT := '';
	SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C;
	SELF.BATCH_NUMBER :=  '';
	SELF.SUBJECT_HEIGHT_C := TRIM(L.HEIGHT);
	SELF.SUBJECT_WEIGHT_C := TRIM(REGEXREPLACE('X0',REGEXREPLACE('000',REGEXREPLACE('00K',REGEXREPLACE('00N',REGEXREPLACE('00O',REGEXREPLACE('00R',REGEXREPLACE('T P',REGEXREPLACE('M',REGEXREPLACE('LEA',REGEXREPLACE('ARG',TRIM(L.WEIGHT)
	                             ,'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE));
	SELF.SUBJECT_EYE_C := IF(L.EYE_COLOR_DESC<>'',REGEXREPLACE('UNKNOWN',REGEXREPLACE('Hand, left',REGEXREPLACE('Blind, right eye',TRIM(L.EYE_COLOR_DESC),'', NOCASE),'', NOCASE),'', NOCASE),
	                                     TRIM(REGEXREPLACE('UNK',REGEXREPLACE('L33',REGEXREPLACE('XXX',TRIM(L.EYE_COLOR),'', NOCASE),'', NOCASE),'', NOCASE)));
	SELF.SUBJECT_HAIR_C := IF(L.HAIR_COLOR_DESC<>'',REGEXREPLACE('UNKNOWN',TRIM(L.HAIR_COLOR_DESC),'',NOCASE),
	                                      TRIM(REGEXREPLACE('180',REGEXREPLACE('XXX',REGEXREPLACE('UNK',(TRIM(L.HAIR_COLOR)),'', NOCASE),'', NOCASE),'', NOCASE)));
	SELF.SENTENCE_EXPIRATION_DT_C := '';
	SELF.FINGER_PRINT := '';
	SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
	SELF.SUBJECT_SKIN := IF(L.SKIN_COLOR_DESC<>'',TRIM(L.SKIN_COLOR_DESC),REGEXREPLACE('X',REGEXREPLACE('XXX',TRIM(L.SKIN_COLOR),'', NOCASE),'', NOCASE));
	SELF.SUBJECT_PHONE := '';
	SELF.SUBJECT_AGE_C := '';
	SELF.PERSONAL_INFO := IF(TRIM(L.DID) <>'','ADL# ' + TRIM(L.DID) + ' #* ','') +
	                      IF(TRIM(L.DLE_NUM) <>'','LAW ENFORMENT# ' + TRIM(L.DLE_NUM) + ' #* ','') +
												IF(TRIM(L.FBI_NUM) <>'','FBI# ' + TRIM(L.FBI_NUM) + ' #* ','') +
												IF(TRIM(L.INS_NUM) <>'','INS# ' + TRIM(L.INS_NUM) + ' #* ','') +
												IF(TRIM(L.ID_NUM) <>'','ID# ' + TRIM(L.ID_NUM) + ' #* ','') +
												IF(TRIM(L.CITIZENSHIP) <>'','CITIZENSHIP ' + TRIM(L.CITIZENSHIP) + ' #* ','') +
												IF(TRIM(L.PLACE_OF_BIRTH) <>'','BIRTH PLACE ' + TRIM(L.PLACE_OF_BIRTH) + ' #* ','');
	SELF.OTH_PERSONAL_INFO := 'ProcDt: ' + TRIM(L.PROCESS_DATE) + '; ' +
	                          'OffKey: ' + TRIM(L.OFFENDER_KEY) + '; ' + 
														'Ven: ' + TRIM(L.VENDOR) + '; ' +
														'ST: ' + TRIM(L.STATE_ORIGIN) + '; ' +
														'SF: ' + TRIM(L.SOURCE_FILE)  + 
														'; ECL_CADE_ID: ' + L.ECL_CADE_ID +
														'; SRC UPLOAD DT: ' + L.src_upload_date;
	SELF.NC_CASE_DT :=  IF(_validate.date.fIsValid(L.CASE_FILING_DT)=false,L.CASE_FILING_DT,'');
	SELF.NC_SUBJECT_DOB :=  IF(_validate.date.fIsValid(L.DOB)=false,L.DOB,'');
	SELF.SCAR_TATTOO := '';
	SELF.ETHNICITY := '';
	SELF.CASE_BUILD := '';
	SELF := [];
END;	

	ds_CaseDetailsPrimary := PROJECT(File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCaseDetails(LEFT));
  

export MapPrimOffenderToCaseDetails := SORT(ds_CaseDetailsPrimary,ecl_cade_id)
                         : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapPrimOffenderToCaseDetails');   
                             

