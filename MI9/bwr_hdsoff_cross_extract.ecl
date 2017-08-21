







//*** BEFORE RUN: Set (1) Spray latest driver file
//                                (2) Set Batch number
//																 (3) Set CROSS Keys

import crim_common;
import crim_cp_ln;
import mi9;
import mi7;

//*****Envoke mapping attributes*****


//*** Need to run first mi9.MapValidCaseMasterSourceUID and below order
a := OUTPUT(mi9.MapValidCaseMasterSourceUID
						 ,{MI7.bCaseMasterMaxKey + CAMA_ID,
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
							MI7.bCaseDetailsMaxKey + ecl_cade_id,
							CASE_SUBJECT_SEQ_C,
							CREATED_BY,
							CREATION_DT,
							LAST_UPDATED_BY,
							LAST_UPDATE_DT,
							MI7.bBatchNumber,
							DOB,	
							SSN,
							OLD_RECORD_SUPPLIER_CD_C,
							SUBJECT_AGE,
							NC_DOB},'~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(200));


b := OUTPUT(mi9.MapValidCaseDetailsSourceUID
										,{MI7.bCaseDetailsMaxKey + ecl_cade_id,
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
										MI7.bCaseDetailsMaxKey + CRSU_CRSU_ID,
										SENTENCE_DISPOSITION_MOD_DT_F,
										CASE_DISPOSITION_DT_C,
										CREATED_BY,
										CREATION_DT,
										LAST_UPDATED_BY,
										LAST_UPDATE_DT,
										RECORD_SUPPLIER_CD,
										MI7.bBatchNumber,
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
										CASE_BUILD},'~thor_data400::out::crim::cross_soff::case_details'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(200));
																				

c := OUTPUT(mi9.MapValidCriminalSupplimentalSourceUID
										,{MI7.bCaseDetailsMaxKey + CRSU_ID,
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
											MI7.bCaseDetailsMaxKey + ecl_cade_id,
											CREATED_BY,
											CREATION_DT,
											LAST_UPDATED_BY,
											LAST_UPDATE_DT,
											RECORD_SUPPLIER_CD,
											MI7.bBatchNumber,
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
											CUSTODY_LOCATION},'~thor_data400::out::crim::cross_soff::criminal_supplimental'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(200));
 

d := OUTPUT(MI9.MapValidAdditionalCasesSourceUID
                    ,{MI7.bAdditionalCasesMaxKey + ADCA_ID,
										CASE_ID,
									  CASE_DESCRIPTION,
										MI7.bCaseDetailsMaxKey + ecl_cade_id,
										CREATED_BY,
										CREATION_DT,
										LAST_UPDATED_BY,
										LAST_UPDATE_DT,
										RECORD_SUPPLIER_CD,
										MI7.bBatchNumber,
										OLD_RECORD_SUPPLIER_CD},'~thor_data400::out::crim::cross_soff::additional_cases'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));
                                                                     

e := OUTPUT(MI9.MapValidAdditionalInformationSourceUID
                ,{MI7.bAdditionalInformationMaxKey+ ADIN_ID,
								 NARRATIVE_INFORMATION,
								 MI7.bCaseDetailsMaxKey + ecl_cade_id,
								 CREATED_BY,
								 CREATION_DT,
								 LAST_UPDATED_BY,
								 LAST_UPDATE_DT,
								 RECORD_SUPPLIER_CD,
								 MI7.bBatchNumber,
								 OLD_RECORD_SUPPLIER_CD},'~thor_data400::out::crim::cross_soff::additional_information'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));


f := OUTPUT(mi9.MapValidCriminalChargesSourceUID
                   		,{MI7.bCriminalChargesMaxKey + ECL_CHARGE_ID,
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
												MI7.bBatchNumber,
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
												CUSTODY_DT_C,
												REFERENCE_INFO,
												ADMIT_DT_C,
												RELEASE_DT_C,
												CONVICT_DT_C,
												NC_OFFENSE_DT,
												NC_DISPOSITION_DT,
											  CHARGE_INFO,
											  CUSTODY_INFO,
												OFFENSE_STATUS},'~thor_data400::out::crim::cross_soff::criminal_charges'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(200));

g := OUTPUT(mi9.MapValidCriminalSentencesSourceUID
				             		 ,{MI7.bCriminalSentencesMaxKey + CRSE_ID,
													SENTENCE_AMT_C,
												  SENTENCE_COMMENT_C,
													MI7.bCriminalChargesMaxKey + ECL_CHARGE_ID,
													SETY_SENTENCE_TYPE_CD_C,
													CREATED_BY,
													CREATION_DT,
													LAST_UPDATED_BY,
													LAST_UPDATE_DT,
													RECORD_SUPPLIER_CD,
													MI7.bBatchNumber,
													OLD_RECORD_SUPPLIER_CD},'~thor_data400::out::crim::cross_soff::criminal_sentences'+ crim_common.version_development,CSV(SEPARATOR('|#~|'), TERMINATOR('\n')),OVERWRITE,EXPIRE(200));

		
		
sequential(a,b,c,d,e,f,g);	
													

//*****DeSray files*****
h := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::case_details'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_CASE_DETAILS'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
i := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::case_master'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_CASE_MASTER'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									
j := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::criminal_supplimental'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_CRIMINAL_SUPPLIMENTAL'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
									

									
k := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::criminal_charges'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_CRIMINAL_CHARGES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);
								
l := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::criminal_sentences'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_CRIMINAL_SENTENCES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);	

m := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::additional_cases'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_ADDITIONAL_CASES'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);	
										
n := FileServices.DeSpray('~thor_data400::out::crim::cross_soff::additional_information'+ crim_common.version_development,
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/LN_CROSS_ADDITIONAL_INFORMATION'+ crim_common.version_development + '.dat',
										,
										,
										,
										TRUE);									

 sequential(h,i,j,k,l,m,n);
 
 
 ////******Generare Soff Cross Thru Date Report******** 

import ut;

// dslayout := RECORD
  // unsigned8 did;
  // unsigned1 score;
  // string9 ssn_appended;
  // unsigned1 ssn_perms;
  // string8 dt_first_reported;
  // string8 dt_last_reported;
  // string8 src_upload_date;
  // string30 orig_state;
  // string2 orig_state_code;
  // string16 seisint_primary_key;
  // string2 vendor_code;
  // string20 source_file;
  // string2 record_type;
  // string50 name_orig;
  // string30 lname;
  // string30 fname;
  // string20 mname;
 // string20 name_suffix;
  // string1 name_type;
  // string320 intnet_email_address_1;
  // string320 intnet_email_address_2;
  // string320 intnet_email_address_3;
  // string320 intnet_email_address_4;
  // string320 intnet_email_address_5;
  // string320 intnet_instant_message_addr_1;
  // string320 intnet_instant_message_addr_2;
  // string320 intnet_instant_message_addr_3;
  // string320 intnet_instant_message_addr_4;
  // string320 intnet_instant_message_addr_5;
  // string320 intnet_user_name_1;
  // string255 intnet_user_name_1_url;
  // string320 intnet_user_name_2;
  // string255 intnet_user_name_2_url;
  // string320 intnet_user_name_3;
  // string255 intnet_user_name_3_url;
  // string320 intnet_user_name_4;
  // string255 intnet_user_name_4_url;
  // string320 intnet_user_name_5;
  // string255 intnet_user_name_5_url;
  // string50 offender_status;
  // string40 offender_category;
  // string10 risk_level_code;
  // string50 risk_description;
  // string50 police_agency;
  // string35 police_agency_contact_name;
  // string55 police_agency_address_1;
  // string35 police_agency_address_2;
  // string10 police_agency_phone;
  // string25 registration_type;
  // string8 reg_date_1;
  // string28 reg_date_1_type;
  // string8 reg_date_2;
  // string28 reg_date_2_type;
  // string8 reg_date_3;
  // string28 reg_date_3_type;
  // string125 registration_address_1;
  // string45 registration_address_2;
  // string35 registration_address_3;
  // string35 registration_address_4;
  // string35 registration_address_5;
  // string35 registration_county;
  // string10 registration_home_phone;
  // string10 registration_cell_phone;
  // string125 other_registration_address_1;
  // string45 other_registration_address_2;
  // string35 other_registration_address_3;
  // string35 other_registration_address_4;
  // string35 other_registration_address_5;
  // string35 other_registration_county;
  // string10 other_registration_phone;
  // string125 temp_lodge_address_1;
  // string45 temp_lodge_address_2;
  // string35 temp_lodge_address_3;
  // string35 temp_lodge_address_4;
  // string35 temp_lodge_address_5;
  // string35 temp_lodge_county;
  // string10 temp_lodge_phone;
  // string55 employer;
  // string55 employer_address_1;
  // string35 employer_address_2;
  // string35 employer_address_3;
  // string35 employer_address_4;
  // string35 employer_address_5;
  // string35 employer_county;
  // string10 employer_phone;
  // string140 employer_comments;
  // string75 professional_licenses_1;
  // string75 professional_licenses_2;
  // string75 professional_licenses_3;
  // string75 professional_licenses_4;
  // string75 professional_licenses_5;
  // string55 school;
  // string55 school_address_1;
  // string35 school_address_2;
  // string35 school_address_3;
  // string35 school_address_4;
  // string35 school_address_5;
  // string35 school_county;
  // string10 school_phone;
  // string140 school_comments;
  // string30 offender_id;
  // string30 doc_number;
  // string30 sor_number;
  // string30 st_id_number;
  // string30 fbi_number;
  // string30 ncic_number;
  // string9 ssn;
  // string8 dob;
  // string8 dob_aka;
  // string3 age;
  // string250 dna;
  // string30 race;
  // string30 ethnicity;
  // string10 sex;
  // string40 hair_color;
  // string40 eye_color;
  // string3 height;
  // string3 weight;
  // string20 skin_tone;
  // string30 build_type;
  // string200 scars_marks_tattoos;
  // string6 shoe_size;
  // string1 corrective_lense_flag;
  // string140 addl_comments_1;
  // string140 addl_comments_2;
  // string30 orig_dl_number;
  // string2 orig_dl_state;
  // string150 orig_dl_link;
  // string8 orig_dl_date;
  // string1 passport_type;
  // string10 passport_code;
  // string25 passport_number;
  // string50 passport_first_name;
  // string100 passport_given_name;
  // string30 passport_nationality;
  // string8 passport_dob;
 // string55 passport_place_of_birth;
  // string10 passport_sex;
  // string8 passport_issue_date;
  // string55 passport_authority;
  // string8 passport_expiration_date;
  // string50 passport_endorsement;
  // string150 passport_link;
  // string8 passport_date;
  // string4 orig_veh_year_1;
  // string40 orig_veh_color_1;
  // string40 orig_veh_make_model_1;
  // string40 orig_veh_plate_1;
  // string17 orig_registration_number_1;
  // string2 orig_veh_state_1;
  // string50 orig_veh_location_1;
  // string4 orig_veh_year_2;
  // string40 orig_veh_color_2;
  // string40 orig_veh_make_model_2;
  // string40 orig_veh_plate_2;
  // string17 orig_registration_number_2;
  // string2 orig_veh_state_2;
  // string50 orig_veh_location_2;
  // string4 orig_veh_year_3;
  // string40 orig_veh_color_3;
  // string40 orig_veh_make_model_3;
  // string40 orig_veh_plate_3;
  // string17 orig_registration_number_3;
  // string2 orig_veh_state_3;
  // string50 orig_veh_location_3;
  // string4 orig_veh_year_4;
  // string40 orig_veh_color_4;
  // string40 orig_veh_make_model_4;
  // string40 orig_veh_plate_4;
  // string17 orig_registration_number_4;
  // string2 orig_veh_state_4;
  // string50 orig_veh_location_4;
  // string4 orig_veh_year_5;
  // string40 orig_veh_color_5;
  // string40 orig_veh_make_model_5;
  // string40 orig_veh_plate_5;
  // string17 orig_registration_number_5;
  // string2 orig_veh_state_5;
  // string50 orig_veh_location_5;
  // string150 fingerprint_link;
  // string8 fingerprint_date;
  // string150 palmprint_link;
  // string8 palmprint_date;
  // string150 image_link;
  // string8 image_date;
  // string6 addr_dt_last_seen;
  // qstring10 prim_range;
  // string2 predir;
  // qstring28 prim_name;
  // qstring4 addr_suffix;
  // string2 postdir;
  // qstring10 unit_desig;
  // qstring8 sec_range;
  // qstring25 p_city_name;
  // qstring25 v_city_name;
  // string2 st;
  // qstring5 zip5;
  // qstring4 zip4;
  // qstring4 cart;
  // string1 cr_sort_sz;
  // qstring4 lot;
  // string1 lot_order;
  // string2 dbpc;
  // string1 chk_digit;
  // string2 rec_type;
  // qstring5 county;
  // qstring10 geo_lat;
  // qstring11 geo_long;
  // qstring4 msa;
  // qstring7 geo_blk;
  // string1 geo_match;
  // qstring4 err_stat;
  // unsigned1 clean_errors;
  // unsigned8 rawaid;
  // string1 curr_incar_flag;
  // string1 curr_parole_flag;
  // string1 curr_probation_flag;
// END;

// d1 := dataset('~thor_data400::persist::hd::sex_offender_crossmain', dslayout, flat); 

d1 := mi9.File_IN_SOFF_Offender;
//output(d);

                upload_rec := record
                                d1.source_file;
                                d1.src_upload_date;
                end;
                
upload_table := table(d1
                                                ,upload_rec
                                                ,source_file
                                                ,src_upload_date 
                                                ,few);

//output(sort(upload_table, -src_upload_date));

output(sort(upload_table, source_file));

///use ut.DateFrom_DaysSince1900 to calculate src_upload_date minus 20 day

lMinusDays	:=	20;

//output(ut.DateFrom_DaysSince1900(ut.DaysSince1900(lTest2[1..4], lTest2[5..6], lTest2[7..8]) - lMinusDays));

src_thru_date_report_rec := record
								d1.source_file;
								string8 source_thru_date;
end;

src_thru_date_report_rec   tr_src_upload_date_minus_20days(upload_table L) := TRANSFORM       
	SELF.source_file := l.source_file;
	SELF.source_thru_date := ut.DateFrom_DaysSince1900(ut.DaysSince1900(l.src_upload_date[1..4], l.src_upload_date[5..6], l.src_upload_date[7..8]) - lMinusDays);
END;	
	
ds_src_thru_date_report := PROJECT(upload_table,tr_src_upload_date_minus_20days(LEFT));  

sort_ds_src_thru_date_report := sort(ds_src_thru_date_report,source_file)
                                                      : persist ('~thor_data400::persist::out::crim::cross_soff::src_thru_date_report');

//*****Create Output File****
a1 := OUTPUT(sort_ds_src_thru_date_report
                    ,{source_file,
										source_thru_date},'~thor_data400::persist::out::crim::cross_soff::src_thru_date_report'+ StringLib.GetDateYYYYMMDD(),CSV(SEPARATOR(','), TERMINATOR('\n')),OVERWRITE,EXPIRE(5));
                                                                      
                                         
//*****DeSray files*****
b1 := FileServices.DeSpray('~thor_data400::persist::out::crim::cross_soff::src_thru_date_report'+ StringLib.GetDateYYYYMMDD(),
										'edata12.br.seisint.com',
										'/hds_180/crim_cp_ln/soff/CROSS_SOFF_SOURCE_THRU_DATE_REPORT_' + StringLib.GetDateYYYYMMDD() + '.csv',
										,
										,
										,
										TRUE);
										
sequential(a1,b1);											
 
 


