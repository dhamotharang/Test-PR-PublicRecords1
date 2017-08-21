


import crim_common;
import crim_cp_ln;

Layout_ecl_cade_id_ecl_charge_id_offender_key := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
Crim_Common.Layout_In_DOC_Offenses.previous.process_date;
Crim_Common.Layout_In_DOC_Offenses.previous.offender_key;
Crim_Common.Layout_In_DOC_Offenses.previous.source_file;
crim_cp_ln.Layout_cross_case_master.old_record_supplier_cd_c;
crim_cp_ln.Layout_cross_case_master.record_supplier_cd_c;
end;


Layout_ecl_cade_id_ecl_charge_id_offender_key  tr_ecl_cade_id_ecl_charge_id_offender_key(mi6.File_Crim_Offenses_ECL_Cade_id L) := TRANSFORM
SELF := L;
END;		

ds_ecl_cade_id_ecl_charge_id_offender_key := PROJECT(mi6.File_Crim_Offenses_ECL_Cade_id,tr_ecl_cade_id_ecl_charge_id_offender_key(LEFT));

//output(choosen(ds_ecl_cade_id_ecl_charge_id_offender_key,500));

dedup_ecl_cade_id := dedup(ds_ecl_cade_id_ecl_charge_id_offender_key,ecl_cade_id);

//output(choosen(dedup_ecl_cade_id,500));


///////////////////////////////////////////////////////////


distribute_dedup_ecl_cade_id := DISTRIBUTE(dedup_ecl_cade_id,HASH32(offender_key));
distribute_File_Crim_Punishment :=  DISTRIBUTE(mi6.File_Crim_Punishment,HASH32(offender_key));

Layout_Crim_Punishments_ECL_Cade_Charge_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
crim_cp_ln.Layout_cross_case_master.old_record_supplier_cd_c;
crim_cp_ln.Layout_cross_case_master.record_supplier_cd_c;
Crim_Common.Layout_In_DOC_Punishment.previous;
end;

Layout_Crim_Punishments_ECL_Cade_Charge_id  tr_Add_ECL_CadeID_ChargeID_To_Crim_Punishments
                                           (distribute_dedup_ecl_cade_id L, distribute_File_Crim_Punishment R) := TRANSFORM
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := L.ECL_CHARGE_ID;
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
SELF := R;
END;	

ds_Crim_Punishment_ECL_CadeCharge_id := JOIN(distribute_dedup_ecl_cade_id,distribute_File_Crim_Punishment,
																		              LEFT.offender_key=RIGHT.offender_key
																		      	        and LEFT.Process_date = RIGHT.Process_date,
																			                tr_Add_ECL_CadeID_ChargeID_To_Crim_Punishments(LEFT,RIGHT),LOCAL);

sort_Crim_Punishment_ECL_CadeCharge_id := SORT(ds_Crim_Punishment_ECL_CadeCharge_id,ECL_CADE_ID);



////////////////////////////////////////////////////////////////////////////////////////////////////////////




import crim_common;
import crim_cp_ln;


Layout_Normalize_Sentences := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
Crim_Common.Layout_In_DOC_Offenses.previous.offender_key;
Crim_CP_LN.layout_cross_criminal_sentences.SENTENCE_COMMENT_C;
Crim_CP_LN.layout_cross_criminal_sentences.SETY_SENTENCE_TYPE_CD_C;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
end;

Layout_Normalize_Sentences tr_Normalize_Sentences(sort_Crim_Punishment_ECL_CadeCharge_id L, INTEGER C) := TRANSFORM 

  // sent_length *************************************************************************************//
	sent_length_clean := IF(L.sent_length<>'',
													REGEXREPLACE('0',
													REGEXREPLACE('0.',
													REGEXREPLACE('-0',
													REGEXREPLACE('-0',
													REGEXREPLACE('0 0 0',
													REGEXREPLACE('00Y00M',
													REGEXREPLACE('0 0  0',
													REGEXREPLACE('0  0  0',
													REGEXREPLACE('000',
													REGEXREPLACE('00000',
													REGEXREPLACE('6',
													REGEXREPLACE('000000',
													REGEXREPLACE('0000000',
													REGEXREPLACE('0000000-',
													REGEXREPLACE('00000000',
													REGEXREPLACE('000000000',
													REGEXREPLACE('0000000-0000000',
													REGEXREPLACE('XXX',TRIM(L.sent_length),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
													'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'');  				              
	
  sent_length_desc_clean :=  IF(L.sent_length_desc<>'',
													    		REGEXREPLACE('Years    Months    Days',TRIM(L.sent_length_desc),'', NOCASE),'');  				              
		

	sent_length := TRIM(
										 IF(LENGTH(TRIM(sent_length_clean))> 0,TRIM(sent_length_clean) +'; ','')
										+ IF(LENGTH(TRIM(sent_length_desc_clean))> 0,TRIM(sent_length_desc_clean) +'; ','')
																)
												 [1..LENGTH(TRIM(
													 IF(LENGTH(TRIM(sent_length_clean))> 0,TRIM(sent_length_clean) +'; ','')
													+ IF(LENGTH(TRIM(sent_length_desc_clean))> 0,TRIM(sent_length_desc_clean) +'; ','')													 
															))-1];	
															
	
	// cur_stat_inm *************************************************************************************//	
	cur_stat_inm := TRIM(
							 IF(LENGTH(TRIM(L.cur_stat_inm))> 0,TRIM(L.cur_stat_inm) +'; ','')
							+ IF(LENGTH(TRIM(L.cur_stat_inm_desc))> 0,TRIM(L.cur_stat_inm_desc) +'; ','')
													)
									 [1..LENGTH(TRIM(
										 IF(LENGTH(TRIM(L.cur_stat_inm))> 0,TRIM(L.cur_stat_inm) +'; ','')
										+ IF(LENGTH(TRIM(L.cur_stat_inm_desc))> 0,TRIM(L.cur_stat_inm_desc) +'; ','')													 
												))-1];
														
	// cur_loc_inm *************************************************************************************//		
	cur_loc_inm := TRIM(
								 IF(LENGTH(TRIM(L.cur_loc_inm_cd))> 0,TRIM(L.cur_loc_inm_cd) +'; ','')
								+ IF(LENGTH(TRIM(L.cur_loc_inm))> 0,TRIM(L.cur_loc_inm) +'; ','')
														)
										 [1..LENGTH(TRIM(
											 IF(LENGTH(TRIM(L.cur_loc_inm_cd))> 0,TRIM(L.cur_loc_inm_cd) +'; ','')
											+ IF(LENGTH(TRIM(L.cur_loc_inm))> 0,TRIM(L.cur_loc_inm) +'; ','')													 
													))-1];	 
	
	// inm_com_cty *************************************************************************************//	
	inm_com_cty := TRIM(
							 IF(LENGTH(TRIM(L.inm_com_cty_cd))> 0,TRIM(L.inm_com_cty_cd) +'; ','')
							+ IF(LENGTH(TRIM(L.inm_com_cty))> 0,TRIM(L.inm_com_cty) +'; ','')
													)
									 [1..LENGTH(TRIM(
										 IF(LENGTH(TRIM(L.inm_com_cty_cd))> 0,TRIM(L.inm_com_cty_cd) +'; ','')
										+ IF(LENGTH(TRIM(L.inm_com_cty))> 0,TRIM(L.inm_com_cty) +'; ','')													 
												))-1];	 
													
	// cur_loc_sec *************************************************************************************//	
	//MD,MN,MX
	cur_loc_sec := CASE(TRIM(L.cur_loc_sec,LEFT,RIGHT),
	                          '' => '',
	                          'MAX' => 'MAX', 
														   'MAXIMUM'=> 'MAXIMUM', 
															   'MED'=> 'MED', 
																   'MEDIMUM'=> 'MEDIMUM', 
																	   'MEDIUM-II'=> 'MEDIUM-II', 
																		   'MIN'=> 'MIN', 
																			   'MINIMUM 1'=> 'MINIMUM 1', 
															             'MINIMUM 2'=> 'MINIMUM 2', 
																					   'MINIMUM 3'=> 'MINIMUM 3',      
															                 'Minimum Direct'=> 'Minimum Direct',
																							   'Minimum Restricted'=> 'Minimum Restricted', 
															                     'Minimum Trustee'=> 'Minimum Trustee',
																									    'Maximum' => 'Maximum', 
																											  'Medium' => 'Medium', 
																												  'Minimum' => 'Minimum', 'Current Location Security: ' + L.cur_loc_sec);
																													
																													
	cur_loc_sec_sety_code := CASE(TRIM(L.cur_loc_sec,LEFT,RIGHT),
	                          'MAX' => 'MX', 
														   'MAXIMUM'=> 'MX', 
															   'MED'=> 'MD', 
																   'MEDIMUM'=> 'MD', 
																	   'MEDIUM-II'=> 'MD', 
																		   'MIN'=> 'MN', 
																			   'MINIMUM 1'=> 'MN', 
															             'MINIMUM 2'=> 'MN', 
																					   'MINIMUM 3'=> 'MN',      
															                 'Minimum Direct'=> 'MN',
																							   'Minimum Restricted'=> 'MN', 
															                     'Minimum Trustee'=> 'MN',
																									    'Maximum' => 'MX', 
																											  'Medium' => 'MD', 
																												  'Minimum' => 'MN', '31');		
																													
																													
	// latest_adm_dt *************************************************************************************//	
	latest_adm_dt :=  IF(L.latest_adm_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.latest_adm_dt),'', NOCASE),'');  
	
	// sch_rel_dt *************************************************************************************//	
	sch_rel_dt :=  IF(L.sch_rel_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.sch_rel_dt),'', NOCASE),'');  
															
	// act_rel_dt *************************************************************************************//	
	act_rel_dt :=  IF(L.act_rel_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.act_rel_dt),'', NOCASE),'');  														

	// ctl_rel_dt *************************************************************************************//	
	ctl_rel_dt :=  IF(L.ctl_rel_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.ctl_rel_dt),'', NOCASE),'');  								

  
	// presump_par_rel_dt *************************************************************************************//	
	presump_par_rel_dt :=  IF(L.presump_par_rel_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.presump_par_rel_dt),'', NOCASE),'');  		

  // mutl_part_pgm_dt *************************************************************************************//	
	mutl_part_pgm_dt :=  IF(L.mutl_part_pgm_dt<>'',
											    		REGEXREPLACE('00000000',TRIM(L.mutl_part_pgm_dt),'', NOCASE),'');  	
	
	
  // par_cur_stat *************************************************************************************//	
	par_cur_stat := TRIM(
							 IF(LENGTH(TRIM(L.par_cur_stat))> 0,TRIM(L.par_cur_stat) +'; ','')
							+ IF(LENGTH(TRIM(L.par_cur_stat_desc))> 0,TRIM(L.par_cur_stat_desc) +'; ','')
													)
									 [1..LENGTH(TRIM(
										 IF(LENGTH(TRIM(L.par_cur_stat))> 0,TRIM(L.par_cur_stat) +'; ','')
										+ IF(LENGTH(TRIM(L.par_cur_stat_desc))> 0,TRIM(L.par_cur_stat_desc) +'; ','')													 
												))-1];	
												
	// par_st_dt *************************************************************************************//
  par_st_dt :=  IF(L.par_st_dt<>'',
											 REGEXREPLACE('00000000',TRIM(L.par_st_dt),'', NOCASE),''); 
											 
											 
	// par_sch_end_dt *************************************************************************************//	
	par_sch_end_dt :=  IF(L.par_sch_end_dt<>'',
											 REGEXREPLACE('00000000',TRIM(L.par_sch_end_dt),'', NOCASE),''); 												 
											 
	// par_act_end_dt *************************************************************************************//	
	par_act_end_dt :=  IF(L.par_act_end_dt<>'',
											 REGEXREPLACE('00000000',TRIM(L.par_act_end_dt),'', NOCASE),''); 	
											 
	// par_cty	*************************************************************************************//
	par_cty := TRIM(
							 IF(LENGTH(TRIM(L.par_cty))> 0,TRIM(L.par_cty) +'; ','')
							+ IF(LENGTH(TRIM(L.par_cty_cd))> 0,TRIM(L.par_cty_cd) +'; ','')
													)
									 [1..LENGTH(TRIM(
										 IF(LENGTH(TRIM(L.par_cty))> 0,TRIM(L.par_cty) +'; ','')
										+ IF(LENGTH(TRIM(L.par_cty_cd))> 0,TRIM(L.par_cty_cd) +'; ','')													 
												))-1];	
	

  // ****************************************************************************************************						 

  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.ecl_charge_id := L.ecl_charge_id;
	SELF.offender_key := L.offender_key;
	SELF.SENTENCE_COMMENT_C := CHOOSE(C,IF(LENGTH(TRIM(sent_length))>0,TRIM(sent_length,LEFT,RIGHT),''),
	                                    IF(LENGTH(TRIM(cur_stat_inm))>0,TRIM(cur_stat_inm,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(cur_loc_inm ))>0, 'Current Location: '+ TRIM(cur_loc_inm ,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(inm_com_cty))>0, 'Inmate Community County: '+ TRIM(inm_com_cty,LEFT,RIGHT),''),
										                	IF(LENGTH(TRIM(L.cur_sec_class_dt))>0,'Security Class Date: '+  TRIM(L.cur_sec_class_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),								 
																			IF(LENGTH(TRIM(cur_loc_sec))>0,TRIM(cur_loc_sec,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.gain_time))>0,TRIM(L.gain_time,LEFT,RIGHT),''),   
																			IF(LENGTH(TRIM(L.gain_time_eff_dt))>0,TRIM(L.gain_time_eff_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(latest_adm_dt))>0,TRIM(latest_adm_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(sch_rel_dt))>0,TRIM(sch_rel_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(act_rel_dt))>0,TRIM(act_rel_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(ctl_rel_dt))>0,'Ctl Rel Dt: '+  TRIM(ctl_rel_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(presump_par_rel_dt))>0,TRIM(presump_par_rel_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(mutl_part_pgm_dt))>0,'Mutl Part Pgm Dt: '+  TRIM(mutl_part_pgm_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(par_cur_stat))>0,TRIM(par_cur_stat,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(par_st_dt))>0,TRIM(par_st_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(par_sch_end_dt))>0,'Parole Sch End Dt: ' + TRIM(par_sch_end_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(par_act_end_dt))>0,TRIM(par_act_end_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(par_cty))>0,TRIM(par_cty,LEFT,RIGHT),'')	
																				 );
	SELF.SETY_SENTENCE_TYPE_CD_C := CHOOSE(C,IF(LENGTH(TRIM(sent_length))>0,'32',''),                    //Sety Code for sent_length,
																						IF(LENGTH(TRIM(cur_stat_inm))>0,'CU',''),                  //Sety Code for cur_stat_inm,
																						IF(LENGTH(TRIM(cur_loc_inm))>0,'31',''),                   //Sety Code for cur_loc_inm,
																						IF(LENGTH(TRIM(inm_com_cty))>0,'31',''),                   //Sety Code for inm_com_cty,
																						IF(LENGTH(TRIM(L.cur_sec_class_dt))>0,'31',''),              //Sety Code for cur_sec_class_dt,
																						IF(LENGTH(TRIM(cur_loc_sec))>0,'',cur_loc_sec_sety_code),  //Sety Code for cur_loc_sec,
																						IF(LENGTH(TRIM(L.gain_time))>0,'GT',''),                     //Sety Code for gain_time,
																						IF(LENGTH(TRIM(L.gain_time_eff_dt))>0,'GE',''),               //Sety Code for gain_time_eff_dt,
																						IF(LENGTH(TRIM(latest_adm_dt))>0,'LA',''),                  //Sety Code for latest_adm_dt,																						
																						IF(LENGTH(TRIM(sch_rel_dt))>0,'RD',''),                     //Sety Code for sch_rel_dt,
																						IF(LENGTH(TRIM(act_rel_dt))>0,'RZ',''),                     //Sety Code for act_rel_dt,
																						IF(LENGTH(TRIM(ctl_rel_dt))>0,'31',''),                     //Sety Code for ctl_rel_dt,
																						IF(LENGTH(TRIM(presump_par_rel_dt))>0,'PP',''),             //Sety Code for presump_par_rel_dt,
																						IF(LENGTH(TRIM(mutl_part_pgm_dt))>0,'31',''),               //Sety Code for mutl_part_pgm_dt,
																						IF(LENGTH(TRIM(par_cur_stat))>0,'CU',''),                   //Sety Code for par_cur_stat,
																						IF(LENGTH(TRIM(par_st_dt))>0,'88',''),                      //Sety Code for par_st_dt,
																						IF(LENGTH(TRIM(par_sch_end_dt))>0,'42',''),                 //Sety Code for par_sch_end_dt,
																						IF(LENGTH(TRIM(par_act_end_dt))>0,'89',''),                 //Sety Code for par_act_end_dt,
																						IF(LENGTH(TRIM(par_cty))>0,'58','')                        //Sety Code for par_cty,
																						);     
																						
		// 31  Other
		// 32  Sentence
		// 42  Parole
		// 58  Supervision County
		// 88  Parole Start Date
		// 89  Parole End Date
		// CU  Current Status
		// GE  Gain Time Effective Dt
		// GT  Gain Time
		// LA  Latest Admission Dt
		// MD  Medium Security
		// MN  Minimum Security
		// MX  Maximum Security
		// PP  Presumptive Parole Release Date
		// RD  Projected Release Date
		// RZ  Release Date																		
																								

  SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
  SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C; 
end;																			
		 

ds_NormSentences := NORMALIZE(sort_Crim_Punishment_ECL_CadeCharge_id,19,tr_Normalize_Sentences(LEFT,COUNTER));


Layout_CriminalSentences_Offender_key := Layout_criminal_sentences_cp;

Layout_CriminalSentences_Offender_key  tr_CourtOffensesToCrimSentences(ds_NormSentences L) 
                                                    := TRANSFORM, SKIP(L.SENTENCE_COMMENT_C = '')
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := L.ECL_CHARGE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
SELF.CRSE_ID := '';
SELF.SENTENCE_AMT_C := '';
SELF.SENTENCE_COMMENT_C := TRIM(L.SENTENCE_COMMENT_C);
SELF.CRCH_CRCH_ID := '';
SELF.SETY_SENTENCE_TYPE_CD_C := TRIM(L.SETY_SENTENCE_TYPE_CD_C);
SELF.CREATED_BY := 'INFRMLOAD';
SELF.CREATION_DT := '';//StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := ''; 
SELF.LAST_UPDATE_DT := '';
SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C; 
SELF.BATCH_NUMBER := '';
SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
SELF := [];
END;	

ds_CriminalSentences := PROJECT(ds_NormSentences,tr_CourtOffensesToCrimSentences(LEFT));

ds_sort_CriminalSentences := SORT(ds_CriminalSentences,ecl_cade_id,ecl_charge_id);

ds_dedup_CriminalSentences := dedup(ds_sort_CriminalSentences,ecl_cade_id,ecl_charge_id,offender_key,crse_id,sentence_amt_c,sentence_comment_c,sety_sentence_type_cd_c);

//export MapCrimPunishmentsToCriminalSentences := SORT(ds_CriminalSentences,ecl_cade_id,ecl_charge_id);

export MapCrimPunishmentsToCriminalSentences := SORT(ds_dedup_CriminalSentences,ecl_cade_id,ecl_charge_id);




////////////////////////////////////////////////////////////////////////////////////////////////////////////

