







import crim_common;
import crim_cp_ln;
import mi8;


//*****shadow load attributes***** 
ds_shadow_load_case_details := join(mi8.MapPrimOffenderToCaseDetails,mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		
ds_shadow_load_case_master  := join(sort(MI8.MapCreateCaseMasterKeys,ecl_cade_id,subject_type_flg_c),mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd_c = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		
ds_shadow_load_crim_supp    := join(mi8.MapOffenderToCriminalSupplimental,mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		
//ds_shadow_load_add_cases    := join(mi8.MapOffenderToAdditionalCases,mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		
ds_shadow_load_crim_charges := join(mi8.MapCourtOffensesToCriminalCharges,mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		
ds_shadow_load_crim_sent    :=  join(sort(MI8.MapCreateCrimSentencesKeys,ecl_cade_id), mi8.File_LN_Cross_Extract_Driver,LEFT.old_record_supplier_cd = RIGHT.old_record_supplier_cd and RIGHT.shadow_load_flag = 'Y',lookup);		



//*****DeSray shadow load files*****
a := FileServices.DeSpray('~thor_data400::out::crim_cp_ln::case_details_shadow_load'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/doc/shadow_files/LN_CROSS_CASE_DETAILS'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
b := FileServices.DeSpray('~thor_data400::out::crim_cp_ln::case_master_shadow_load'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/doc/shadow_files/LN_CROSS_CASE_MASTER'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
c := FileServices.DeSpray('~thor_data400::out::crim_cp_ln::criminal_supplimental_shadow_load'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/doc/shadow_files/LN_CROSS_CRIMINAL_SUPPLIMENTAL'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									

									
e := FileServices.DeSpray('~thor_data400::out::crim_cp_ln::criminal_charges_shadow_load'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/doc/shadow_files/LN_CROSS_CRIMINAL_CHARGES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
								
f := FileServices.DeSpray('~thor_data400::out::crim_cp_ln::criminal_sentences_shadow_load'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/doc/shadow_files/LN_CROSS_CRIMINAL_SENTENCES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);	



//*****Envoke mapping attributes and despray attributes*****
 sequential(//mi8.proc_build_vendor_stats_doc(crim_common.Version_Development),
       parallel(
			         OUTPUT(ds_shadow_load_case_details
									 //(ecl_cade_id <=30000)
									,{ecl_cade_id,
									 CASE_DT_C,
									 CASE_SUFFIX_FLG,
									 CASE_CATEGORY_CD_C,
									 CASE_YEAR,
									 DOCKET_SEQ_F,
									 ORIG_SOURCE_DIVISION_NAME,
									 DOCUMENT_NUMBER_F,
									 SUBJECT_STATUS_FLG,
									 SUBJECT_ID,
									 SUBJECT_TYPE,
									 SUBJECT_SSN_C,
									 SUBJECT_DOB_C,
									 SUBJECT_SEX_CD_C,
									 SUBJECT_RACE_CD_C,
									 SUBJECT_ADDRESS_LINE_1_C,
									 SUBJECT_ADDRESS_LINE_2_C,
									 SUBJECT_CITY_NAME_C,
									 SUBJECT_STATE_CD_C,
									 SUBJECT_ZIP_CD_C,
									 SUBJECT_ZIP_4,
									 CASE_DISPOSITION_MESSAGE,
									 CRSU_CRSU_ID,
									 SENTENCE_DISPOSITION_MOD_DT_F,
									 CASE_DISPOSITION_DT_C,
									 CREATED_BY,
									 CREATION_DT,
									 LAST_UPDATED_BY,
									 LAST_UPDATE_DT,
									 RECORD_SUPPLIER_CD,
									 BATCH_NUMBER,
									 SUBJECT_HEIGHT_C,
									 SUBJECT_WEIGHT_C,
									 SUBJECT_EYE_C,
									 SUBJECT_HAIR_C,
									 SENTENCE_EXPIRATION_DT_C,
									 FINGER_PRINT,
									 OLD_RECORD_SUPPLIER_CD,
									 SUBJECT_SKIN,
									 SUBJECT_PHONE,
									 SUBJECT_AGE_C,
									 PERSONAL_INFO,
									 OTH_PERSONAL_INFO,
									 NC_CASE_DT,
									 NC_SUBJECT_DOB,
									 SCAR_TATTOO,
									 ETHNICITY,
									 CASE_BUILD},'~thor_data400::out::crim_cp_ln::case_details_shadow_load'+ crim_common.version_development,CSV(SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));
																				
OUTPUT(ds_shadow_load_case_master
						// (ecl_cade_id <=30000)
						 ,{CAMA_ID,
							CASE_TYPE_CD,	
							RECORD_SUPPLIER_CD_C,	
							JURISDICTION_FLG,	
							CASE_NUM_C,
							SUBJECT_LAST_NAME_C,
							SUBJECT_FIRST_NAME_C,	
							SUBJECT_MIDDLE_NAME_C,
							SUBJECT_NAME_SUFFIX_C,		
							SUBJECT_FULL_NAME_C,
							SUBJECT_TYPE_FLG_C,
							SOURCE_UID_C,
							SOURCE_STATE_CD_C,
							SOURCE_COUNTY_CD_C,	
							SOURCE_COUNTY_NAME_C,
							DISTRICT_NAME_UID,
							ecl_cade_id,
							CASE_SUBJECT_SEQ_C,
							CREATED_BY,
							CREATION_DT,
							LAST_UPDATED_BY,
							LAST_UPDATE_DT,
							BATCH_NUMBER,
							DOB,	
							SSN,
							OLD_RECORD_SUPPLIER_CD_C,
							SUBJECT_AGE,
							NC_DOB},'~thor_data400::out::crim_cp_ln::case_master_shadow_load'+ crim_common.version_development,CSV(SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));

OUTPUT(ds_shadow_load_crim_supp
									//	(ecl_cade_id <=30000)
										,{CRSU_ID,
											ASSIGNED_JUDGE,
											REFERRED_JUDGE,
											TERM_DT,
											ORIGINAL_COURT_ID,
											ARREST_DT_C,
											ARRAIGN_DT_F,
											FIRST_COURT_DT_F,
											JAIL_RELEASE_DT_C,
											TICKET_NUMBER,
											ARRESTING_AGENCY_CD,
											ARRESTING_AGENCY_PLACE_C,
											SEIZED_PROPERTY_NUMBER,
											COSTS_ORDERED,
											COSTS_IMPOSED,
											IMPRISONED_SWITCH_FLG,
											COMMENCED_BY_CD,
											ecl_cade_id,
											CREATED_BY,
											CREATION_DT,
											LAST_UPDATED_BY,
											LAST_UPDATE_DT,
											RECORD_SUPPLIER_CD,
											BATCH_NUMBER,
											AGENCY_CASE_NUMBER_F,
											CUSTODIAL_AGENCY_ID,
											CUSTODIAL_AGENCY,
											COUNTY_OF_COMMITMENT_F,
											CUSTODY_STATUS,
											CHARGING_DOCUMENT,
											JUDGE_DOC_ENTERED_BY,
											JUDGE_DOC_ENTERED_DT,
											OFFENDER_LEGAL_REPRESENTER,
											WITNESS_NAME,
											TRIAL_DT_C,
											CASE_SERVED_DT,
											OLD_RECORD_SUPPLIER_CD,
											TRIAL_TYPE,
											WARRANT_INFO_F,
											MTR_INFO,
											CUSTODY_INFO_CASE,
											PROBATION_INFO,
											CUSTODY_LOCATION},'~thor_data400::out::crim_cp_ln::criminal_supplimental_shadow_load'+ crim_common.version_development,CSV(SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));
 
OUTPUT(ds_shadow_load_crim_charges
                     //  (ecl_cade_id <=30000)
											,{ECL_CHARGE_ID,
												ORIGINAL_CHARGE_C_A_X,
												ORIGINAL_CHARGE_NUMBER_OCCUR,
											  ORIGINAL_CHARGE_F,
												ORIGINAL_CHARGE_SHORT,
												ORIGINAL_CODE_SECTION,
												ORIGINAL_CASE_TYPE_C,
												ORIGINAL_CHARGE_QUALIFIER_FLG,
												ORIGINAL_CHARGE_CLASS_FLG_F,
												AMENDED_CHARGE_C_A_X,
												AMENDED_CHARGE_NUMBER_OCCUR,
											  AMENDED_CHARGE_C,
												AMENDED_CHARGE_SHORT,
												AMENDED_CODE_SECTION,
												AMENDED_CASE_TYPE,
												AMENDED_CHARGE_QUALIFIER_FLG,
												AMENDED_CHARGE_CLASS_FLG,
												CHARGE_DELETION_FLG,
												DISPOSITION,
												DISPOSITION_DT,
											  DISPOSITION_MSG,
												COUNT_TYPE,
												CHARGE_COUNT,
												APPEAL_DT_F,
												OFFENSE_DT_C,
												OFFENSE_TOWN_C,
												OFFENSE_DESCRIPTION_C,
												OFFENSE_LEVEL_NUM,
												ORIG_PLEA_CD,
												ORIG_PLEA_DT;
												PLEA_WITHDRAWN_DT,
												NEW_PLEA_CD,
												CONCLUDED_BY_CD,
												DRIVERS_LICENSE_NUMBER_F,
												DRIVERS_LICENSE_STATE_CD_F,
												CAMA_CASE_NUM,
												CAMA_SOURCE_UID,
												CAMA_CASE_SUBJECT_SEQ,
												CREATED_BY,
												CREATION_DT,
												LAST_UPDATED_BY,
												LAST_UPDATE_DT,
												RECORD_SUPPLIER_CD_C,
												BATCH_NUMBER,
												ARREST_DISPOSITION_DT_F,
											  ARREST_DISPOSITION_MSG_F,
												COURT_LOCATION_C,
												CAUSE_NUMBER_C,
												COURT_PROVISION_C,
												DISPOSITION_DURING_APPEAL,
												FINAL_DECISION_ON_APPEAL,
												SENTENCE_STATUS_CHG_DT_C,
												AGENCY_RECEIVING_CUSTODY,
												PROSECUTOR_LOCATION,
												PROSECUTOR_CASE_REFFER_TO,
												CHARGE_REJECTED_DT,
											  PROSECUTOR_ACTION,
											  PROSECUTOR_OFFENSE,
												PROSECUTION_CASE_TYPE,
												PROSECUTE_GENERAL_OFFENSE_CHAR,
											  OTHER_CONVICTION_OFFENSE,
											  PRIM_INDICTMENT_OFFENSE,
												PRIM_INDICTMENT_CLASS,
												ARRAIGNED_OFFENSE,
												ARRAIGNED_CASE_TYPE_C,
												ARRAIGNED_CODE_SECTION_C,
												CALLED_AND_FAILED_DT,
												FAILURE_TO_APPEAR_DT,
												METHOD_OF_DISPOSITION_CD,
												NON_MV_FAIL_TO_COMPLY_DT,
												MV_FAILURE_TO_COMPLY_DT,
												SHOW_CAUSE_ORDER_DT,
												OFFENDER_TYPE,
												OLD_RECORD_SUPPLIER_CD,
												CHARGE_FILE_DT,
												PROSECUTOR_CODE_SECTION,
												CAPIAS_DT,
												REARREST_DT,
												BOND_HEARING_DT,
												PROS_DECISION_DT,
												CHARGE_REOPEN_DT,
												CHG_REOPEN_CLOSE_DT,
												PRIM_INDICTMENT_NUMBER,
											  REOPEN_REASON,
												CHECKED_DT_C,
												CLOSEOUT_DT_C,
												REFERENCE_INFO,
												CUSTODY_DT_C,
												ADMIT_DT_C,
												RELEASE_DT_C,
												CONVICT_DT_C,
												NC_OFFENSE_DT,
												NC_DISPOSITION_DT,
											  CHARGE_INFO,
											  CUSTODY_INFO,
												OFFENSE_STATUS},'~thor_data400::out::crim_cp_ln::criminal_charges_shadow_load'+ crim_common.version_development,CSV(SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));

OUTPUT(ds_shadow_load_crim_sent
				               //   (ecl_cade_id <=30000)	
												 ,{CRSE_ID,
													SENTENCE_AMT_C,
												  SENTENCE_COMMENT_C,
													ECL_CHARGE_ID,
													SETY_SENTENCE_TYPE_CD_C,
													CREATED_BY,
													CREATION_DT,
													LAST_UPDATED_BY,
													LAST_UPDATE_DT,
													RECORD_SUPPLIER_CD,
													BATCH_NUMBER,
													OLD_RECORD_SUPPLIER_CD},'~thor_data400::out::crim_cp_ln::criminal_sentences_shadow_load'+ crim_common.version_development,CSV(SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5))

													
													
													

),a,b,c,e,f
	 );