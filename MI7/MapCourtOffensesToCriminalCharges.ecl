



import crim_common;
import crim_cp_ln;
import _validate;
import hygenics_eval;

Layout_Court_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
hygenics_eval.Layout_Common_Court_Offenses;
hygenics_eval.Layout_Common_Crim_Offender.dl_num;
hygenics_eval.Layout_Common_Crim_Offender.dl_state;
hygenics_eval.Layout_Common_Crim_Offender.case_number;
hygenics_eval.Layout_Common_Crim_Offender.case_type_desc;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
string330 ct_off_lev_desc;
string330 arr_off_lev_desc;
string330 pr_off_lev_desc;
end;

Layout_Case_Master_and_Moxie_Court_Offenses := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
CM_DOB := MapPrimOffenderToCaseMaster.DOB;
CM_SSN := MapPrimOffenderToCaseMaster.SSN;
CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
CM_SOURCE_UID := MapPrimOffenderToCaseMaster.source_uid_c;
Layout_Court_Offenses_ECL_Cade_id;
END;


Layout_Case_Master_and_Moxie_Court_Offenses tr_Attach_CM_Constants_Court_offenses(MapPrimOffenderToCaseMaster L, File_Court_Offenses_ECL_Cade_id R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
SELF.CM_DOB := L.DOB;																																	 
SELF.CM_SSN := L.SSN;
SELF.CM_NC_DOB := L.NC_DOB;
SELF.CM_SOURCE_UID := L.SOURCE_UID_C;
SELF := R;
END;


ds_CaseMasterCourtOffenses := JOIN(MapPrimOffenderToCaseMaster,File_Court_Offenses_ECL_Cade_id,
																			LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																			 tr_Attach_CM_Constants_Court_offenses(LEFT,RIGHT)); 

Layout_CriminalCharges_Offender_key := Layout_criminal_charges_cp;

Layout_CriminalCharges_Offender_key  tr_CourtOffensesToCrimCharges(ds_CaseMasterCourtOffenses L) 
                                                    := TRANSFORM//, SKIP(L.CASE_NUMBER<>L.COURT_CASE_NUMBER AND L.COURT_CASE_NUMBER <> '')


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


ORIGINAL_CHARGE_F := TRIM(
                           IF(LENGTH(TRIM(L.arr_off_desc_1))> 0,TRIM(L.arr_off_desc_1) +'; ','')
													+ IF(LENGTH(TRIM(L.arr_off_desc_2))> 0,TRIM(L.arr_off_desc_2) +'; ','')
													 + IF(LENGTH(TRIM(L.arr_off_type_desc))> 0,TRIM(L.arr_off_type_desc) +'; ','')
														+ IF(LENGTH(TRIM(L.arr_statute_desc))> 0,TRIM(L.arr_statute_desc) +'; ','')
														   //+IF(LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','ARR_OFF_LEV',L.vendor,L.court_off_lev))) > 0,
														     //    TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','ARR_OFF_LEV',L.vendor,L.court_off_lev))+ '; ','')
																+ IF(LENGTH(TRIM(L.arr_off_lev_desc))> 0,TRIM(L.arr_off_lev_desc) +'; ','')
																		  )
														   [1..LENGTH(TRIM(
															   IF(LENGTH(TRIM(L.arr_off_desc_1))> 0,TRIM(L.arr_off_desc_1) +'; ','')
																+ IF(LENGTH(TRIM(L.arr_off_desc_2))> 0,TRIM(L.arr_off_desc_2) +'; ','')
																 + IF(LENGTH(TRIM(L.arr_off_type_desc))> 0,TRIM(L.arr_off_type_desc) +'; ','')
																	+ IF(LENGTH(TRIM(L.arr_statute_desc))> 0,TRIM(L.arr_statute_desc) +'; ','')
																	 // +  IF(LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','ARR_OFF_LEV',L.vendor,L.court_off_lev))) > 0,
														        // TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','ARR_OFF_LEV',L.vendor,L.court_off_lev))+ '; ','')
																		  + IF(LENGTH(TRIM(L.arr_off_lev_desc))> 0,TRIM(L.arr_off_lev_desc) +'; ','')
																	  ))-1];

ORIGINAL_CODE_SECTION := MAP(LENGTH(TRIM(L.arr_statute)) > 0
																 => TRIM(L.arr_statute),'');
																 
ORIGINAL_CASE_TYPE_C := //Map(REGEXFIND('fel',L.arr_off_lev_desc,NOCASE) => 'F',
                              //REGEXFIND('mis',L.arr_off_lev_desc,NOCASE) => 'M','');		
															L.arr_off_lev_desc;
																 
AMENDED_CHARGE_C := TRIM(
                           IF(LENGTH(TRIM(L.court_off_desc_1))> 0,TRIM(L.court_off_desc_1) +'; ','')
													+ IF(LENGTH(TRIM(L.court_off_desc_2))> 0,TRIM(L.court_off_desc_2) +'; ','')
													 + IF(LENGTH(TRIM(L.court_off_type_desc))> 0,TRIM(L.court_off_type_desc) +'; ','')
														+ IF(LENGTH(TRIM(L.court_statute_desc))> 0,TRIM(L.court_statute_desc) +'; ','')
														 +  IF(LENGTH(TRIM(L.case_type_desc))> 0,TRIM(L.case_type_desc) +'; ','')
														   //+  IF(LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','COURT_OFF_LEV',L.vendor,L.court_off_lev))) > 0,
														    //     TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','COURT_OFF_LEV',L.vendor,L.court_off_lev))+ '; ','')
																  + IF(LENGTH(TRIM(L.ct_off_lev_desc))> 0,TRIM(L.ct_off_lev_desc) +'; ','')
																		  )
														   [1..LENGTH(TRIM(
															   IF(LENGTH(TRIM(L.court_off_desc_1))> 0,TRIM(L.court_off_desc_1) +'; ','')
																+ IF(LENGTH(TRIM(L.court_off_desc_2))> 0,TRIM(L.court_off_desc_2) +'; ','')
																 + IF(LENGTH(TRIM(L.court_off_type_desc))> 0,TRIM(L.court_off_type_desc) +'; ','')
																	+ IF(LENGTH(TRIM(L.court_statute_desc))> 0,TRIM(L.court_statute_desc) +'; ','')
																	 + IF(LENGTH(TRIM(L.case_type_desc))> 0,TRIM(L.case_type_desc) +'; ','')
																	   // +  IF(LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','COURT_OFF_LEV',L.vendor,L.court_off_lev))) > 0,
														           //   TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','COURT_OFF_LEV',L.vendor,L.court_off_lev))+ '; ','')
																			  + IF(LENGTH(TRIM(L.ct_off_lev_desc))> 0,TRIM(L.ct_off_lev_desc) +'; ','')
																	  ))-1];
																 
AMENDED_CODE_SECTION := MAP(LENGTH(TRIM(L.court_statute)) > 0 AND LENGTH(TRIM(L.court_additional_statutes)) > 0 and LENGTH(TRIM(L.court_off_code)) > 0
															 => TRIM(L.court_statute) + '; ' + TRIM(L.court_additional_statutes) + '; ' + TRIM(L.court_off_code),
																LENGTH(TRIM(L.court_statute)) > 0
																 => TRIM(L.court_statute),
																	LENGTH(TRIM(L.court_additional_statutes)) > 0
																	 => TRIM(L.court_additional_statutes),  
																	  LENGTH(TRIM(L.court_off_code)) > 0
																	    => TRIM(L.court_off_code),																	 
																	 '');
																	 
AMENDED_CASE_TYPE := //Map(REGEXFIND('fel',L.ct_off_lev_desc,NOCASE) => 'F',
                              //REGEXFIND('mis',L.ct_off_lev_desc,NOCASE) => 'M','');
															L.ct_off_lev_desc;
																	 
															 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := L.ECL_CHARGE_ID; 
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
SELF.CRCH_ID_C := '';
SELF.ORIGINAL_CHARGE_C_A_X := '';
SELF.ORIGINAL_CHARGE_NUMBER_OCCUR := '';
SELF.ORIGINAL_CHARGE_F := ORIGINAL_CHARGE_F;
SELF.ORIGINAL_CHARGE_SHORT := '';
SELF.ORIGINAL_CODE_SECTION := ORIGINAL_CODE_SECTION;
SELF.ORIGINAL_CASE_TYPE_C := ORIGINAL_CASE_TYPE_C;
SELF.ORIGINAL_CHARGE_QUALIFIER_FLG := '';
SELF.ORIGINAL_CHARGE_CLASS_FLG_F := '';
SELF.AMENDED_CHARGE_C_A_X := '';
SELF.AMENDED_CHARGE_NUMBER_OCCUR := '';
SELF.AMENDED_CHARGE_C := IF(LENGTH(TRIM(AMENDED_CHARGE_C))> 0,TRIM(AMENDED_CHARGE_C),ORIGINAL_CHARGE_F); 
SELF.AMENDED_CHARGE_SHORT := '';
SELF.AMENDED_CODE_SECTION := IF(LENGTH(TRIM(AMENDED_CODE_SECTION))> 0,TRIM(AMENDED_CODE_SECTION),ORIGINAL_CODE_SECTION);
SELF.AMENDED_CASE_TYPE := IF(LENGTH(TRIM(AMENDED_CASE_TYPE))> 0,TRIM(AMENDED_CASE_TYPE),ORIGINAL_CASE_TYPE_C);
SELF.AMENDED_CHARGE_QUALIFIER_FLG := '';
SELF.AMENDED_CHARGE_CLASS_FLG := '';
SELF.CHARGE_DELETION_FLG := L.off_delete_flag;
SELF.DISPOSITION := //if(TRIM(L.source_file) <> 'TX-Midland',
																						TRIM(MAP(L.court_disp_desc_1 <> '' and L.court_disp_desc_2 <> '' and L.court_disp_code <> ''
																								 => TRIM(L.court_disp_desc_1) + '; ' + TRIM(L.court_disp_desc_2) + ' - ' + TRIM(L.court_disp_code),
																											L.court_disp_desc_1 <> '' and L.court_disp_desc_2 <> ''
																											 => TRIM(L.court_disp_desc_1) + '; ' + TRIM(L.court_disp_desc_2),
																														L.court_disp_desc_1 <> '' and L.court_disp_code <> ''
																															=> TRIM(L.court_disp_desc_1) + ' - ' + TRIM(L.court_disp_code),
																																	L.court_disp_desc_2 <> '' and L.court_disp_code <> ''
																																		=> TRIM(L.court_disp_desc_2) + ' - ' + TRIM(L.court_disp_code),
																																			 L.court_disp_desc_1 <> ''
																																				=> TRIM(L.court_disp_desc_1),
																																					L.court_disp_desc_2 <> ''
																																					 => TRIM(L.court_disp_desc_2),
																																							L.court_disp_code <> ''
																																							 => TRIM(L.court_disp_code),''));
																																							// ,'');
SELF.DISPOSITION_DT :=  IF(_validate.date.fIsValid(L.court_disp_date)=true,L.court_disp_date,'');
SELF.DISPOSITION_MSG := IF(L.court_final_plea <> '','PLEA: ' + TRIM(L.court_final_plea),'');
SELF.COUNT_TYPE := '';
SELF.CHARGE_COUNT := L.num_of_counts;
SELF.APPEAL_DT_F :=  IF(_validate.date.fIsValid(L.appeal_date)=true,L.appeal_date,'');
SELF.OFFENSE_DT_C := IF(_validate.date.fIsValid(L.OFF_DATE)=true,L.OFF_DATE,'');
SELF.OFFENSE_TOWN_C := l.offense_town;
SELF.OFFENSE_DESCRIPTION_C := '';
SELF.OFFENSE_LEVEL_NUM := '';
SELF.ORIG_PLEA_CD := IF(LENGTH(TRIM(L.court_final_plea))= 2, TRIM(L.court_final_plea), TRIM(L.court_final_plea[1..2]));
SELF.ORIG_PLEA_DT := '';
SELF.PLEA_WITHDRAWN_DT := '';
SELF.NEW_PLEA_CD := '';
SELF.CONCLUDED_BY_CD := '';
SELF.DRIVERS_LICENSE_NUMBER_F := IF(L.traffic_dl_no <> '', TRIM(L.traffic_dl_no),TRIM(L.DL_NUM)); 
SELF.DRIVERS_LICENSE_STATE_CD_F := IF(L.traffic_dl_st <> '', TRIM(L.traffic_dl_st),TRIM(L.DL_STATE)); 
SELF.CAMA_CASE_NUM := TRIM(L.CM_CASE_NUM);
SELF.CAMA_SOURCE_UID := L.CM_SOURCE_UID;                       
SELF.CAMA_CASE_SUBJECT_SEQ := '1';
SELF.CREATED_BY := 'HPCCLOAD';
SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';
SELF.LAST_UPDATE_DT := '';
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF.BATCH_NUMBER := '';
SELF.ARREST_DISPOSITION_DT_F :=  IF(_validate.date.fIsValid(L.arr_disp_date)=true,L.arr_disp_date,'');
SELF.ARREST_DISPOSITION_MSG_F := TRIM(MAP(L.arr_disp_desc_1 <> '' and L.arr_disp_desc_2 <> '' and L.arr_disp_code <> ''
																	 => TRIM(L.arr_disp_desc_1) + '; ' + TRIM(L.arr_disp_desc_2) + ' - ' + TRIM(L.arr_disp_code),
																				L.arr_disp_desc_1 <> '' and L.arr_disp_desc_2 <> ''
																				 => TRIM(L.arr_disp_desc_1) + '; ' + TRIM(L.arr_disp_desc_2),
																							L.arr_disp_desc_1 <> '' and L.arr_disp_code <> ''
																								=> TRIM(L.arr_disp_desc_1) + ' - ' + TRIM(L.arr_disp_code),
																										L.arr_disp_desc_2 <> '' and L.arr_disp_code <> ''
																											=> TRIM(L.arr_disp_desc_2) + ' - ' + TRIM(L.arr_disp_code),
																												 L.arr_disp_desc_1 <> ''
																													=> TRIM(L.arr_disp_desc_1),
																														L.arr_disp_desc_2 <> ''
																														 => TRIM(L.arr_disp_desc_2),
																																L.arr_disp_code <> ''
																																 => TRIM(L.arr_disp_code),''));	
																																 
court_loc :=  TRIM(MAP(L.court_desc <> '' and L.court_cd <> '' => TRIM(L.court_desc) + ' - ' + TRIM(L.court_cd),
												           L.court_desc <> '' => TRIM(L.court_desc),
																			 L.court_cd <> ''  => TRIM(L.court_cd),''));
																																 
SELF.COURT_LOCATION_C := Map(l.cty_conv <> ''  =>l.cty_conv,court_loc);
																				
SELF.CAUSE_NUMBER_C := L.le_agency_case_number;
SELF.COURT_PROVISION_C := TRIM(MAP(LENGTH(TRIM(L.sent_addl_prov_desc_1))> 0 and LENGTH(TRIM(L.sent_addl_prov_desc_2))> 0 and LENGTH(TRIM(L.sent_addl_prov_code))> 0 
													=> TRIM(L.sent_addl_prov_desc_1) + '; ' + TRIM(L.sent_addl_prov_desc_2) + ' - ' + TRIM(L.sent_addl_prov_code),
														 LENGTH(TRIM(L.sent_addl_prov_desc_1))> 0 and LENGTH(TRIM(L.sent_addl_prov_desc_2))> 0
															 => TRIM(L.sent_addl_prov_desc_1) + '; ' + TRIM(L.sent_addl_prov_desc_2),
																 LENGTH(TRIM(L.sent_addl_prov_desc_1))> 0 and LENGTH(TRIM(L.sent_addl_prov_code))> 0 
																	=> TRIM(L.sent_addl_prov_desc_1) + ' - ' + TRIM(L.sent_addl_prov_code),
																	 LENGTH(TRIM(L.sent_addl_prov_desc_2))> 0 and LENGTH(TRIM(L.sent_addl_prov_code))> 0 
																		 => TRIM(L.sent_addl_prov_desc_2) + ' - ' + TRIM(L.sent_addl_prov_code),
																				LENGTH(TRIM(L.sent_addl_prov_desc_1))> 0
																				 => TRIM(L.sent_addl_prov_desc_1),
																					LENGTH(TRIM(L.sent_addl_prov_desc_2))> 0
																						=> TRIM(L.sent_addl_prov_desc_2),
																						 LENGTH(TRIM(L.sent_addl_prov_code))> 0
																							 => TRIM(L.sent_addl_prov_code),''));
SELF.DISPOSITION_DURING_APPEAL := TRIM(l.appeal_off_disp);
SELF.FINAL_DECISION_ON_APPEAL := TRIM(l.appeal_final_decision);
SELF.SENTENCE_STATUS_CHG_DT_C := '';
SELF.AGENCY_RECEIVING_CUSTODY := TRIM(MAP(LENGTH(TRIM(L.sent_agency_rec_cust))> 0 and LENGTH(TRIM(L.sent_agency_rec_cust_ori))> 0 
																		=> TRIM(L.sent_agency_rec_cust) + ' - ' + TRIM(L.sent_agency_rec_cust_ori),
																			 LENGTH(TRIM(L.sent_agency_rec_cust))> 0 
																				 => TRIM(L.sent_agency_rec_cust),
																					 LENGTH(TRIM(L.sent_agency_rec_cust_ori))> 0 
																						=> TRIM(L.sent_agency_rec_cust_ori),''));
SELF.PROSECUTOR_LOCATION := '';
SELF.PROSECUTOR_CASE_REFFER_TO := TRIM(MAP(L.pros_refer <> '' and L.pros_refer_cd <> '' 
																			=> TRIM(L.pros_refer) + ' - ' + TRIM(L.pros_refer_cd),
																					L.pros_refer <> ''
																					 => TRIM(L.pros_refer),
																								L.pros_refer_cd <> ''
																									=> TRIM(L.pros_refer_cd),
																											 L.pros_assgn <> '' and L.pros_assgn_cd <> '' 
																											=> TRIM(L.pros_assgn) + ' - ' + TRIM(L.pros_assgn_cd),
																													L.pros_assgn <> ''
																													 => TRIM(L.pros_assgn),
																														L.pros_assgn_cd <> ''
																															=> TRIM(L.pros_assgn_cd),''));	
SELF.CHARGE_REJECTED_DT := '';
SELF.PROSECUTOR_ACTION := IF(_validate.date.fIsValid(l.pros_act_filed)=true,'',l.pros_act_filed); 
SELF.PROSECUTOR_OFFENSE := TRIM(MAP(L.pros_off_desc_1 <> '' and L.pros_off_desc_2 <> '' and LENGTH(TRIM(L.pr_off_lev_desc)) > 0 
                                // LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev))) > 0
														   => TRIM(L.pros_off_desc_1) + ' - ' + TRIM(L.pros_off_desc_2) + '; ' + TRIM(L.pr_off_lev_desc),//TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev)
																	L.pros_off_desc_1 <> '' and LENGTH(TRIM(L.pr_off_lev_desc)) > 0 //LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev))) > 0
																	    => TRIM(L.pros_off_desc_1) + '; ' + TRIM(L.pr_off_lev_desc), //TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev)),
																				L.pros_off_desc_2 <> '' and LENGTH(TRIM(L.pr_off_lev_desc)) > 0//LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev))) > 0
																					=> TRIM(L.pros_off_desc_2)+ '; ' + TRIM(L.pr_off_lev_desc),//TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev)),
																					  L.pros_off_desc_1 <> ''
																						  => TRIM(L.pros_off_desc_1),
																							  L.pros_off_desc_2 <> ''
																								  => TRIM(L.pros_off_desc_2), 
																									     LENGTH(TRIM(L.pr_off_lev_desc)) > 0  
																					               => TRIM(L.pr_off_lev_desc),''));	
																									  //LENGTH(TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev))) > 0  
																					          // => TRIM(FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev)),''));	
SELF.PROSECUTION_CASE_TYPE :=// Map(REGEXFIND('fel',L.pr_off_lev_desc,NOCASE) => 'F',
                              //REGEXFIND('mis',L.pr_off_lev_desc,NOCASE) => 'M','');
                                //Map(REGEXFIND('fel',FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev),NOCASE) => 'F',
                                 // REGEXFIND('mis',FN_Get_CodesV3_descr('COURT_OFFENSES','PROS_OFF_LEV',L.vendor,L.pros_off_lev),NOCASE) => 'M','');
																 L.pr_off_lev_desc;
																 
SELF.PROSECUTE_GENERAL_OFFENSE_CHAR := TRIM(MAP(L.pros_off_type_desc <> '' and L.pros_off_type_cd <> '' 
																				 => TRIM(L.pros_off_type_desc) + ' - ' + TRIM(L.pros_off_type_cd),
																							L.pros_off_type_desc <> ''
																							 => TRIM(L.pros_off_type_desc),
																										L.pros_off_type_cd <> ''
																											=> TRIM(L.pros_off_type_cd),''));
SELF.OTHER_CONVICTION_OFFENSE := '';
SELF.PRIM_INDICTMENT_OFFENSE := '';
SELF.PRIM_INDICTMENT_CLASS := '';
SELF.ARRAIGNED_OFFENSE := '';
SELF.ARRAIGNED_CASE_TYPE_C := '';
SELF.ARRAIGNED_CODE_SECTION_C := '';
SELF.CALLED_AND_FAILED_DT := '';
SELF.FAILURE_TO_APPEAR_DT := '';
SELF.METHOD_OF_DISPOSITION_CD := '';
SELF.NON_MV_FAIL_TO_COMPLY_DT := '';
SELF.MV_FAILURE_TO_COMPLY_DT := '';
SELF.SHOW_CAUSE_ORDER_DT := '';
SELF.OFFENDER_TYPE := '';
SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
SELF.CHARGE_FILE_DT := IF(_validate.date.fIsValid(L.arr_date)=true,L.arr_date,'');
SELF.PROSECUTOR_CODE_SECTION := TRIM(L.pros_off_code);
SELF.CAPIAS_DT := '';
SELF.REARREST_DT := '';
SELF.BOND_HEARING_DT := '';
SELF.PROS_DECISION_DT := '';
SELF.CHARGE_REOPEN_DT := '';
SELF.CHG_REOPEN_CLOSE_DT := '';
SELF.PRIM_INDICTMENT_NUMBER := '';
SELF.REOPEN_REASON := '';
SELF.CHECKED_DT_C := '';
SELF.CLOSEOUT_DT_C := '';
SELF.REFERENCE_INFO := '';
SELF.CUSTODY_DT_C := '';
SELF.ADMIT_DT_C := '';
SELF.RELEASE_DT_C := '';
SELF.CONVICT_DT_C := IF(_validate.date.fIsValid(l.convict_dt)=true,l.convict_dt,'');
SELF.NC_OFFENSE_DT :=  IF(_validate.date.fIsValid(L.OFF_DATE)=false,L.OFF_DATE,'');
SELF.NC_DISPOSITION_DT := IF(_validate.date.fIsValid(L.court_disp_date)=false,L.court_disp_date,'');
SELF.CHARGE_INFO := '';
SELF.CUSTODY_INFO := '';
SELF.OFFENSE_STATUS :=  '';
SELF := [];
END;
		
ds_CriminalCharges := PROJECT(ds_CaseMasterCourtOffenses,tr_CourtOffensesToCrimCharges(LEFT));
  
export MapCourtOffensesToCriminalCharges := //SORT(ds_CriminalCharges,ecl_cade_id,ecl_charge_id)
                                                                  ds_CriminalCharges
                                                                    : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapCourtOffensesToCriminalCharges');   
                                                                                             
                                                                                             



