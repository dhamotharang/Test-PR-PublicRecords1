


import crim_common;
import crim_cp_ln;
import _validate;

Layout_Court_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
//Crim_Common.Layout_Moxie_Court_Offenses;
Crim_Common.Layout_In_DOC_Offenses.previous;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_num;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_state;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_number;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_type_desc;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
// string330 ct_off_lev_desc;
// string330 arr_off_lev_desc;
// string330 pr_off_lev_desc;
end;

Layout_Case_Master_and_Moxie_Court_Offenses := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
CM_DOB := MapPrimOffenderToCaseMaster.DOB;
CM_SSN := MapPrimOffenderToCaseMaster.SSN;
CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
CM_SOURCE_UID := MapPrimOffenderToCaseMaster.source_uid_c;
Layout_Court_Offenses_ECL_Cade_id;
END;


Layout_Case_Master_and_Moxie_Court_Offenses tr_Attach_CM_Constants_Court_offenses(MapPrimOffenderToCaseMaster L, File_Crim_Offenses_ECL_Cade_id R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
SELF.CM_DOB := L.DOB;																																	 
SELF.CM_SSN := L.SSN;
SELF.CM_NC_DOB := L.NC_DOB;
SELF.CM_SOURCE_UID := L.SOURCE_UID_C;
SELF := R;
END;


ds_CaseMasterCrimOffenses := JOIN(MapPrimOffenderToCaseMaster,File_Crim_Offenses_ECL_Cade_id,
																			LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																			 tr_Attach_CM_Constants_Court_offenses(LEFT,RIGHT));
 

// Layout_CriminalCharges_Offender_key := RECORD
// INTEGER ecl_cade_id;
// INTEGER ecl_charge_id;
// crim_common.Layout_Moxie_Court_Offenses.offender_key;
// Crim_CP_LN.layout_cross_criminal_charges;
// end;

Layout_CriminalCharges_Offender_key := Layout_criminal_charges_cp;

Layout_CriminalCharges_Offender_key  tr_CourtOffensesToCrimCharges(ds_CaseMasterCrimOffenses L) 
                                                    := TRANSFORM//, SKIP(L.CASE_NUMBER<>L.COURT_CASE_NUMBER AND L.COURT_CASE_NUMBER <> '')

/////////////////////////////////////////////////////////////////////////////////////////////////////////

ORIGINAL_CHARGE_F := TRIM(
                           IF(LENGTH(TRIM(L.chg))> 0,TRIM(L.chg) +'; ','')
													+ IF(LENGTH(TRIM(L.off_desc_1))> 0,TRIM(L.off_desc_1) +'; ','')
													 + IF(LENGTH(TRIM(L.off_desc_2))> 0,TRIM(L.off_desc_2) +'; ','')
														+ IF(LENGTH(TRIM(L.add_off_desc))> 0,TRIM(L.add_off_desc) +'; ','')
															+ IF(LENGTH(TRIM(L.off_lev))> 0,TRIM(L.off_lev) +'; ','')
																		  )
														   [1..LENGTH(TRIM(
															   IF(LENGTH(TRIM(L.chg))> 0,TRIM(L.chg) +'; ','')
																+ IF(LENGTH(TRIM(L.off_desc_1))> 0,TRIM(L.off_desc_1) +'; ','')
																 + IF(LENGTH(TRIM(L.off_desc_2))> 0,TRIM(L.off_desc_2) +'; ','')
																	+ IF(LENGTH(TRIM(L.add_off_desc))> 0,TRIM(L.add_off_desc) +'; ','')
																	  + IF(LENGTH(TRIM(L.off_lev))> 0,TRIM(L.off_lev) +'; ','')
																	  ))-1];
																		
																		
ORIGINAL_CODE_SECTION := TRIM(
                           IF(LENGTH(TRIM(L.off_code))> 0,TRIM(L.off_code) +'; ','')
													+ IF(LENGTH(TRIM(L.add_off_desc))> 0,TRIM(L.add_off_desc) +'; ','')
				  											  )
														   [1..LENGTH(TRIM(
															   IF(LENGTH(TRIM(L.off_code))> 0,TRIM(L.off_code) +'; ','')
																+ IF(LENGTH(TRIM(L.add_off_desc))> 0,TRIM(L.add_off_desc) +'; ','')
																 	  ))-1];

ORIGINAL_CASE_TYPE_C := CASE(TRIM(L.off_typ,LEFT,RIGHT),'F' => 'F', 'M'=> 'M', '');

AMENDED_CHARGE_C :=  TRIM(
                           IF(LENGTH(TRIM(L.ct_chg))> 0,TRIM(L.ct_chg) +'; ','')
													+ IF(LENGTH(TRIM(L.ct_off_desc_1))> 0,TRIM(L.ct_off_desc_1) +'; ','')
													 + IF(LENGTH(TRIM(L.ct_off_desc_2))> 0,TRIM(L.ct_off_desc_2) +'; ','')
														+ IF(LENGTH(TRIM(L.ct_addl_desc_cd))> 0,TRIM(L.ct_addl_desc_cd) +'; ','') 
														  + IF(LENGTH(TRIM(L.ct_off_lev))> 0,TRIM(L.ct_off_lev) +'; ','')  
															 )
														   [1..LENGTH(TRIM(
															   IF(LENGTH(TRIM(L.ct_chg))> 0,TRIM(L.ct_chg) +'; ','')
																+ IF(LENGTH(TRIM(L.ct_off_desc_1))> 0,TRIM(L.ct_off_desc_1) +'; ','')
																 + IF(LENGTH(TRIM(L.ct_off_desc_2))> 0,TRIM(L.ct_off_desc_2) +'; ','')
																	+ IF(LENGTH(TRIM(L.ct_addl_desc_cd))> 0,TRIM(L.ct_addl_desc_cd) +'; ','')
																	   + IF(LENGTH(TRIM(L.ct_off_lev))> 0,TRIM(L.ct_off_lev) +'; ','')  
																	 ))-1];
																	 
AMENDED_CODE_SECTION := MAP(LENGTH(TRIM(L.ct_off_code)) > 0 => TRIM(L.ct_off_code),'');																	 

/////////////////////////////////////////////////////////////////////////////////////////////////


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
SELF.ORIGINAL_CHARGE_CLASS_FLG_F := L.chg_typ_flg;
SELF.AMENDED_CHARGE_C_A_X := '';
SELF.AMENDED_CHARGE_NUMBER_OCCUR := '';
SELF.AMENDED_CHARGE_C :=  IF(LENGTH(TRIM(AMENDED_CHARGE_C))> 0,TRIM(AMENDED_CHARGE_C),ORIGINAL_CHARGE_F); 
SELF.AMENDED_CHARGE_SHORT := '';
SELF.AMENDED_CODE_SECTION := IF(LENGTH(TRIM(AMENDED_CODE_SECTION))> 0,TRIM(AMENDED_CODE_SECTION),ORIGINAL_CODE_SECTION);
SELF.AMENDED_CASE_TYPE := IF(LENGTH(TRIM(ORIGINAL_CASE_TYPE_C))> 0,TRIM(ORIGINAL_CASE_TYPE_C),''); 
SELF.AMENDED_CHARGE_QUALIFIER_FLG := '';
SELF.AMENDED_CHARGE_CLASS_FLG := L.ct_chg_typ_flg;
SELF.CHARGE_DELETION_FLG := ''; //L.off_delete_flag;
SELF.DISPOSITION := TRIM(MAP(L.ct_disp_desc_1 <> '' and L.ct_disp_desc_2 <> '' and L.ct_disp_cd <> ''
																	 => TRIM(L.ct_disp_desc_1) + '; ' + TRIM(L.ct_disp_desc_2) + ' - ' + TRIM(L.ct_disp_cd),
																				L.ct_disp_desc_1 <> '' and L.ct_disp_desc_2 <> ''
																				 => TRIM(L.ct_disp_desc_1) + '; ' + TRIM(L.ct_disp_desc_2),
																							L.ct_disp_desc_1 <> '' and L.ct_disp_cd <> ''
																								=> TRIM(L.ct_disp_desc_1) + ' - ' + TRIM(L.ct_disp_cd),
																										L.ct_disp_desc_2 <> '' and L.ct_disp_cd <> ''
																											=> TRIM(L.ct_disp_desc_2) + ' - ' + TRIM(L.ct_disp_cd),
																												 L.ct_disp_desc_1 <> ''
																													=> TRIM(L.ct_disp_desc_1),
																														L.ct_disp_desc_2 <> ''
																														 => TRIM(L.ct_disp_desc_2),
																																L.ct_disp_cd <> ''
																																 => TRIM(L.ct_disp_cd),''));
SELF.DISPOSITION_DT :=  IF(_validate.date.fIsValid(L.ct_disp_dt)=true,L.ct_disp_dt,'');
SELF.DISPOSITION_MSG := TRIM(MAP(L.ct_fnl_plea_cd <> '' and L.ct_fnl_plea <> ''
															    => 'PLEA: ' + TRIM(L.ct_fnl_plea_cd) + '; ' + TRIM(L.ct_fnl_plea),
                                    L.ct_fnl_plea_cd <> ''
															        => 'PLEA: ' + TRIM(L.ct_fnl_plea_cd),
																			 L.ct_fnl_plea <> ''
															          => 'PLEA: ' + TRIM(L.ct_fnl_plea),''));
SELF.COUNT_TYPE := '';
SELF.CHARGE_COUNT := L.num_of_counts;
SELF.APPEAL_DT_F := ''; 
SELF.OFFENSE_DT_C := IF(_validate.date.fIsValid(L.OFF_DATE)=true,L.OFF_DATE,'');
SELF.OFFENSE_TOWN_C := '';
SELF.OFFENSE_DESCRIPTION_C := '';
SELF.OFFENSE_LEVEL_NUM := '';
SELF.ORIG_PLEA_CD := ''; 
SELF.ORIG_PLEA_DT := '';
SELF.PLEA_WITHDRAWN_DT := '';
SELF.NEW_PLEA_CD := '';
SELF.CONCLUDED_BY_CD := '';
SELF.DRIVERS_LICENSE_NUMBER_F := '';
SELF.DRIVERS_LICENSE_STATE_CD_F := '';
SELF.CAMA_CASE_NUM := TRIM(L.CM_CASE_NUM);
SELF.CAMA_SOURCE_UID := //L.CM_SOURCE_UID;
                       MAP(TRIM(L.COURT_ID) = 'court_code' => L.court_cd,
											       TRIM(L.COURT_ID) = 'court_desc' => L.court_desc, L.OLD_RECORD_SUPPLIER_CD_C);
SELF.CAMA_CASE_SUBJECT_SEQ := '1';
SELF.CREATED_BY := 'INFRMLOAD';
SELF.CREATION_DT := '';//StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';
SELF.LAST_UPDATE_DT := '';
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF.BATCH_NUMBER := '';
SELF.ARREST_DISPOSITION_DT_F := IF(_validate.date.fIsValid(L.arr_disp_date)=true,L.arr_disp_date,'');
SELF.ARREST_DISPOSITION_MSG_F := TRIM(MAP(L.arr_disp_desc_1 <> '' and L.arr_disp_desc_2 <> '' and L.arr_disp_cd <> '' and L.arr_disp_desc_3 <> ''
																	 => TRIM(L.arr_disp_desc_1) + '; ' + TRIM(L.arr_disp_desc_2) + '; ' + TRIM(L.arr_disp_desc_3) + ' - ' + TRIM(L.arr_disp_cd),
																				L.arr_disp_desc_1 <> '' and L.arr_disp_desc_2 <> '' and L.arr_disp_desc_3 <> ''
																				 => TRIM(L.arr_disp_desc_1) + '; ' + TRIM(L.arr_disp_desc_2)+ '; ' + TRIM(L.arr_disp_desc_3),
																				    L.arr_disp_desc_1 <> '' and L.arr_disp_desc_2 <> ''
																				     => TRIM(L.arr_disp_desc_1) + '; ' + TRIM(L.arr_disp_desc_2),
																							 L.arr_disp_desc_1 <> '' and L.arr_disp_cd <> ''
																								=> TRIM(L.arr_disp_desc_1) + ' - ' + TRIM(L.arr_disp_cd),
																										L.arr_disp_desc_2 <> '' and L.arr_disp_cd <> ''
																											=> TRIM(L.arr_disp_desc_2) + ' - ' + TRIM(L.arr_disp_cd),
																											  L.arr_disp_desc_3 <> '' and L.arr_disp_cd <> ''
																										    	=> TRIM(L.arr_disp_desc_3) + ' - ' + TRIM(L.arr_disp_cd),
																												    L.arr_disp_desc_1 <> ''
																													   => TRIM(L.arr_disp_desc_1),
																													   	L.arr_disp_desc_2 <> ''
																													  	 => TRIM(L.arr_disp_desc_2),
																															    L.arr_disp_desc_3 <> ''
																													          => TRIM(L.arr_disp_desc_3),
																															      	L.arr_disp_cd <> ''
																																       => TRIM(L.arr_disp_cd),''));															    
SELF.COURT_LOCATION_C := TRIM(MAP(L.court_desc <> '' and L.court_cd <> '' 
													 => TRIM(L.court_desc) + ' - ' + TRIM(L.court_cd),
																L.court_desc <> ''
																 => TRIM(L.court_desc),
																			L.court_cd <> ''
																				=> TRIM(L.court_cd),''));
SELF.CAUSE_NUMBER_C := L.case_num;
SELF.COURT_PROVISION_C := '';
SELF.DISPOSITION_DURING_APPEAL :='';
SELF.FINAL_DECISION_ON_APPEAL := '';
SELF.SENTENCE_STATUS_CHG_DT_C := '';
SELF.AGENCY_RECEIVING_CUSTODY := '';
SELF.PROSECUTOR_LOCATION := '';
SELF.PROSECUTOR_CASE_REFFER_TO := '';                                  
SELF.CHARGE_REJECTED_DT := '';
SELF.PROSECUTOR_ACTION := ''; 
SELF.PROSECUTOR_OFFENSE := ''; 
SELF.PROSECUTION_CASE_TYPE := '';
SELF.PROSECUTE_GENERAL_OFFENSE_CHAR := '';
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
SELF.CHARGE_FILE_DT := '';
SELF.PROSECUTOR_CODE_SECTION := '';
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
SELF.CONVICT_DT_C := '';
SELF.NC_OFFENSE_DT := IF(_validate.date.fIsValid(L.OFF_DATE)=false,L.OFF_DATE,'');
SELF.NC_DISPOSITION_DT := IF(_validate.date.fIsValid(L.ct_disp_dt)=false,L.ct_disp_dt,'');
SELF.CHARGE_INFO := IF(TRIM(L.arr_date) <>'','Arrest Date: ' + TRIM(L.arr_date) + ' #* ','') +
	                      IF(TRIM(L.Ct_Dist) <>'','Court District: ' + TRIM(L.Ct_Dist) + ' #* ','');
SELF.CUSTODY_INFO := '';
SELF.OFFENSE_STATUS :=  '';
SELF := [];
END;

		
ds_CriminalCharges := PROJECT(ds_CaseMasterCrimOffenses,tr_CourtOffensesToCrimCharges(LEFT));
  
export MapCourtOffensesToCriminalCharges := SORT(ds_CriminalCharges,ecl_cade_id,ecl_charge_id);



