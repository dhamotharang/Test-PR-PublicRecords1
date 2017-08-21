


import crim_common;
import crim_cp_ln;
import _validate;

Layout_case_details_Offender_key := Layout_case_details_cp;

Layout_case_details_Offender_key   tr_PrimOffenderToCaseDetails(Distribute_File_Primary_Offender_ECL_Cade_id L) := TRANSFORM 
  
  STRING1 USE_ADDRESS_CLEANER := IF(TRIM(L.PRIM_RANGE) + TRIM(L.PREDIR) + TRIM(L.PRIM_NAME) + TRIM(L.ADDR_SUFFIX) + TRIM(L.POSTDIR) + 
	                                  TRIM(L.UNIT_DESIG) + TRIM(L.SEC_RANGE) + TRIM(L.P_CITY_NAME) + TRIM(L.ST) + TRIM(L.ZIP5) + TRIM(L.ZIP4) <> '','Y','N');
  
	SELF.ECL_CADE_ID := L.ECL_CADE_ID;
  SELF.OFFENDER_KEY := L.Seisint_Primary_Key; 
  SELF.CADE_ID := '';
	SELF.CASE_DT_C := '';
	SELF.CASE_SUFFIX_FLG := '';
	SELF.CASE_CATEGORY_CD_C := '';
	SELF.CASE_YEAR := '';
	SELF.DOCKET_SEQ_F := '';
	SELF.ORIG_SOURCE_DIVISION_NAME := '';
	SELF.DOCUMENT_NUMBER_F := L.DOC_NUMBER;
	SELF.SUBJECT_STATUS_FLG := '';
	SELF.SUBJECT_ID := L.SOR_NUMBER;
	SELF.SUBJECT_TYPE := '';
	SELF.SUBJECT_SSN_C := MAP(L.SSN<>'' => L.SSN, '.'); 												 
	SELF.SUBJECT_DOB_C :=  IF(_validate.date.fIsValid(L.DOB)=true,L.DOB,'');
	SELF.SUBJECT_SEX_CD_C := L.SEX;	
	SELF.SUBJECT_RACE_CD_C := L.RACE;
																								
	SELF.SUBJECT_ADDRESS_LINE_1_C := TRIM(IF(USE_ADDRESS_CLEANER='Y', IF(LENGTH(TRIM(L.PRIM_RANGE))>0,TRIM(L.PRIM_RANGE) + ' ','') +
																																		IF(LENGTH(TRIM(L.PREDIR))>0,TRIM(L.PREDIR) + ' ','') +
																																		IF(LENGTH(TRIM(L.PRIM_NAME))>0,TRIM(L.PRIM_NAME) + ' ','') +
																																		IF(LENGTH(TRIM(L.ADDR_SUFFIX))>0,TRIM(L.ADDR_SUFFIX) + ' ','') +
																																		IF(LENGTH(TRIM(L.POSTDIR))>0,TRIM(L.POSTDIR) + ' ',''),
																																			 IF(LENGTH(TRIM(L.REGISTRATION_ADDRESS_1))>0,TRIM(L.REGISTRATION_ADDRESS_1) + ' ','') +
																																			 IF(LENGTH(TRIM(L.REGISTRATION_ADDRESS_2))>0,TRIM(L.REGISTRATION_ADDRESS_2) + ' ','') +
																																			 IF(LENGTH(TRIM(L.REGISTRATION_ADDRESS_3))>0,TRIM(L.REGISTRATION_ADDRESS_3) + ' ','')
																																	   ));    

	SELF.SUBJECT_ADDRESS_LINE_2_C := TRIM(IF(USE_ADDRESS_CLEANER='Y', IF(LENGTH(TRIM(L.UNIT_DESIG))>0,TRIM(L.UNIT_DESIG) + ' ','') +
																																		IF(LENGTH(TRIM(L.SEC_RANGE))>0,TRIM(L.SEC_RANGE) + ' ',''),
																																			IF(LENGTH(TRIM(L.REGISTRATION_ADDRESS_4))>0,TRIM(L.REGISTRATION_ADDRESS_4) + ' ','') +
																																			IF(LENGTH(TRIM(L.REGISTRATION_ADDRESS_5))>0,TRIM(L.REGISTRATION_ADDRESS_5) + ' ','')
																																	   ));							
																																		 
	SELF.SUBJECT_CITY_NAME_C := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.P_CITY_NAME),'');
	SELF.SUBJECT_STATE_CD_C := IF(USE_ADDRESS_CLEANER='Y',TRIM(L.ST),'');
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
	SELF.SUBJECT_HEIGHT_C := L.HEIGHT;
	SELF.SUBJECT_WEIGHT_C := L.WEIGHT;	
	
	                              
	SELF.SUBJECT_EYE_C := L.EYE_COLOR;
	
	                                    
	SELF.SUBJECT_HAIR_C :=  L.HAIR_COLOR;
	
	                                     
	SELF.SENTENCE_EXPIRATION_DT_C := '';
	SELF.FINGER_PRINT := L.FINGERPRINT_LINK;
	SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
	SELF.SUBJECT_SKIN := L.SKIN_TONE; 
	SELF.SUBJECT_PHONE := L.REGISTRATION_HOME_PHONE;
	SELF.SUBJECT_AGE_C := L.AGE;
	
	SELF.PERSONAL_INFO := IF(TRIM(L.REGISTRATION_CELL_PHONE) <>'','CELL PHN# ' + TRIM(L.REGISTRATION_CELL_PHONE) + ' #* ','') +  // check mapping
	                                       IF(TRIM(L.OFFENDER_ID) <>'','ID# ' + TRIM(L.OFFENDER_ID) + ' #* ','') +
																				 IF(TRIM(L.ST_ID_NUMBER) <>'','STID# ' + TRIM(L.ST_ID_NUMBER) + ' #* ','') +
																				 IF(TRIM(L.FBI_NUMBER) <>'','FBI#  ' + TRIM(L.FBI_NUMBER) + ' #* ','') +
																				 IF(TRIM(L.NCIC_NUMBER) <>'','NCIC# ' + TRIM(L.NCIC_NUMBER) + ' #* ','');
								
												
	SELF.OTH_PERSONAL_INFO :=  'SPK: ' + TRIM(L.Seisint_Primary_Key) + '; ' + 
																						'Ven: ' + TRIM(L.VENDOR_CODE) + '; ' +
																						'ST: ' + TRIM(L.ORIG_STATE_CODE) + '; ' +
																						'SF: ' + TRIM(L.SOURCE_FILE)  + '; ' +
																						'ECL_CADE_ID: ' + L.ECL_CADE_ID + '; ' +
																						'SRC UPLOAD DT: ' + L.src_upload_date + '; ' +
																						'DtFR: ' + TRIM(L.DT_FIRST_REPORTED) + '; ' +
																						'DtLR: ' + TRIM(L.DT_LAST_REPORTED) ; 
														
	SELF.NC_CASE_DT :=  ''; 
	SELF.NC_SUBJECT_DOB :=  IF(_validate.date.fIsValid(L.DOB)=false,L.DOB[1..4],'');
	SELF.SCAR_TATTOO := '';
	SELF.ETHNICITY := '';
	SELF.CASE_BUILD := '';
	SELF := [];
END;	

	ds_CaseDetailsPrimary := PROJECT(Distribute_File_Primary_Offender_ECL_Cade_id,tr_PrimOffenderToCaseDetails(LEFT));
  

export MapPrimOffenderToCaseDetails := SORT(ds_CaseDetailsPrimary,ecl_cade_id)
                         : persist ('~thor_data400::persist::out::crim::cross_soff::MapPrimOffenderToCaseDetails');   
                             

