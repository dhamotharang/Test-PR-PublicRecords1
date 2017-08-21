



import crim_common;
import crim_cp_ln;
import hygenics_eval;
import _validate;

Layout_Normalize_Sentences := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
hygenics_eval.Layout_Common_Court_Offenses.offender_key;
Crim_CP_LN.layout_cross_criminal_sentences.SENTENCE_COMMENT_C;
Crim_CP_LN.layout_cross_criminal_sentences.SETY_SENTENCE_TYPE_CD_C;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
end;

Layout_Normalize_Sentences tr_Normalize_Sentences(File_Court_Offenses_ECL_Cade_id L, INTEGER C) := TRANSFORM, 
																																																 SKIP(L.sent_date +
																																																	L.sent_jail +
																																																	L.sent_susp_time +
																																																	L.sent_court_cost +
																																																	L.sent_court_fine +
																																																	L.sent_susp_court_fine +
																																																	L.sent_probation +
																																																	L.sent_consec +
																																																	L.traffic_ticket_number+
																																																	L.le_agency_desc  +
																																																	L.le_agency_cd +
																																																	L.restitution +
																																																	L.community_service +
																																																	L.Parole +
																																																	L.addl_sent_dates +
                                                                                                 	L.Probation_desc2	+	
																																																	IF(_validate.date.fIsValid(l.pros_act_filed)=true,TRIM(l.pros_act_filed) + ' (YYYYMMDD)','') 
																																																	= '')  																																																	
																					                                                   							

  probation_info := TRIM(
															 IF(LENGTH(TRIM(L.sent_probation))> 0,TRIM(L.sent_probation) +'; ','')
															+ IF(LENGTH(TRIM(L.Probation_desc2))> 0,TRIM(L.Probation_desc2) +'; ','')
																					)
																	 [1..LENGTH(TRIM(
																		 IF(LENGTH(TRIM(L.sent_probation))> 0,TRIM(L.sent_probation) +'; ','')
																		+ IF(LENGTH(TRIM(L.Probation_desc2))> 0,TRIM(L.Probation_desc2) +'; ','')													 
																				))-1];
																				
	agency_info := TRIM(
															 IF(LENGTH(TRIM(L.le_agency_cd))> 0,TRIM(L.le_agency_cd) +'; ','')
															+ IF(LENGTH(TRIM(L.le_agency_desc))> 0,TRIM(L.le_agency_desc) +'; ','')
																					)
																	 [1..LENGTH(TRIM(
																		 IF(LENGTH(TRIM(L.le_agency_cd))> 0,TRIM(L.le_agency_cd) +'; ','')
																		+ IF(LENGTH(TRIM(L.le_agency_desc))> 0,TRIM(L.le_agency_desc) +'; ','')													 
																				))-1];		
																				
			
															

  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.ecl_charge_id := L.ecl_charge_id;
	SELF.offender_key := L.offender_key;
	SELF.SENTENCE_COMMENT_C := CHOOSE(C,IF(LENGTH(TRIM(L.sent_date))>0,TRIM(L.sent_date,LEFT,RIGHT) + ' (YYYYMMDD)',''),
	                                    IF(LENGTH(TRIM(L.sent_jail))>0,TRIM(L.sent_jail,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_susp_time))>0,TRIM(L.sent_susp_time,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_court_cost))>0,TRIM(L.sent_court_cost,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_court_fine))>0 and TRIM(L.sent_court_fine,LEFT,RIGHT) <> '0',TRIM(L.sent_court_fine,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_susp_court_fine))>0 and TRIM(L.sent_susp_court_fine,LEFT,RIGHT) <> '0',TRIM(L.sent_susp_court_fine,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(probation_info))>0,TRIM(probation_info,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_consec))>0,TRIM(L.sent_consec,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.traffic_ticket_number))>0,TRIM(L.traffic_ticket_number,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(agency_info))>0,TRIM(agency_info,LEFT,RIGHT),''),																				 
																 
																			 // if(TRIM(L.source_file) = 'TX-Midland',
																						// TRIM(MAP(L.court_disp_desc_1 <> '' and L.court_disp_desc_2 <> '' and L.court_disp_code <> ''
																								 // => TRIM(L.court_disp_desc_1) + '; ' + TRIM(L.court_disp_desc_2) + ' - ' + TRIM(L.court_disp_code),
																											// L.court_disp_desc_1 <> '' and L.court_disp_desc_2 <> ''
																											 // => TRIM(L.court_disp_desc_1) + '; ' + TRIM(L.court_disp_desc_2),
																														// L.court_disp_desc_1 <> '' and L.court_disp_code <> ''
																															// => TRIM(L.court_disp_desc_1) + ' - ' + TRIM(L.court_disp_code),
																																	// L.court_disp_desc_2 <> '' and L.court_disp_code <> ''
																																		// => TRIM(L.court_disp_desc_2) + ' - ' + TRIM(L.court_disp_code),
																																			 // L.court_disp_desc_1 <> ''
																																				// => TRIM(L.court_disp_desc_1),
																																					// L.court_disp_desc_2 <> ''
																																					 // => TRIM(L.court_disp_desc_2),
																																							// L.court_disp_code <> ''
																																							 // => TRIM(L.court_disp_code),''))
																																							 // ,''),
																																							 
																				IF(LENGTH(TRIM(L.restitution))>0,TRIM(L.restitution,LEFT,RIGHT),''),
																				IF(LENGTH(TRIM(L.community_service))>0,TRIM(L.community_service,LEFT,RIGHT),''),
																				IF(LENGTH(TRIM(L.parole))>0,TRIM(L.parole,LEFT,RIGHT),''),
																				IF(LENGTH(TRIM(L.addl_sent_dates))>0,TRIM(L.addl_sent_dates,LEFT,RIGHT),'')	,
																				IF(_validate.date.fIsValid(l.pros_act_filed)=true,TRIM(l.pros_act_filed) + ' (YYYYMMDD)','') 
																							 );
																							 
	SELF.SETY_SENTENCE_TYPE_CD_C := CHOOSE(C,IF(LENGTH(TRIM(L.sent_date))>0,'51',''), 
																						IF(LENGTH(TRIM(L.sent_jail))>0,'32',''),
																						IF(LENGTH(TRIM(L.sent_susp_time))>0,'40',''),
																						IF(LENGTH(TRIM(L.sent_court_cost))>0,'2',''),
																						IF(LENGTH(TRIM(L.sent_court_fine))>0,'14',''),
																						IF(LENGTH(TRIM(L.sent_susp_court_fine))>0,'33',''), 
																						IF(LENGTH(TRIM(probation_info))>0,'7',''), 
																						IF(LENGTH(TRIM(L.sent_consec))>0,'39',''), 
																						IF(LENGTH(TRIM(L.traffic_ticket_number))>0,'CI',''), 
																						IF(LENGTH(TRIM(agency_info)) > 0,'AG',''), 																						
																						// IF(L.court_disp_desc_1 + L.court_disp_desc_2 + L.court_disp_code <> '','83',''), 																						
		                                        IF(LENGTH(TRIM(L.restitution))>0,'RE',''),
																						IF(LENGTH(TRIM(L.community_service))>0,'CM',''),
																						IF(LENGTH(TRIM(L.parole))>0,'42',''),
																						IF(LENGTH(TRIM(L.addl_sent_dates))>0,'32','')	,
																						IF(_validate.date.fIsValid(l.pros_act_filed)=true,'67','')		
																						);     
																						
// Sentence type cd and sentence type desc																						
// 14 	Fine and Court Costs
// 2  	Court Costs
// 32 	Sentence
// 33 	Suspended Fine
// 39 	Sentence Consecutive/Concurrent
// 40 	Sentence Suspended
// 42 	Parole
// 51 	Sentence Date
// 7  	Probation
// AG 	Agency
// CI 	Citation Number
// CM 	Community Service
// RE 	Restitution
// 67 	Indictment date
																					

  SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
  SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C; 
end;																			
		 

ds_NormSentences := NORMALIZE(File_Court_Offenses_ECL_Cade_id,15,tr_Normalize_Sentences(LEFT,COUNTER));

Layout_CriminalSentences_Offender_key := Layout_criminal_sentences_cp;

Layout_CriminalSentences_Offender_key  tr_CourtOffensesToCrimSentences(ds_NormSentences L) 
                                                    := TRANSFORM, SKIP(L.SENTENCE_COMMENT_C = '')
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := L.ECL_CHARGE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
//SELF.CRSE_ID := '';
SELF.SENTENCE_AMT_C := '';
SELF.SENTENCE_COMMENT_C := TRIM(L.SENTENCE_COMMENT_C);
SELF.CRCH_CRCH_ID := '';
SELF.SETY_SENTENCE_TYPE_CD_C := TRIM(L.SETY_SENTENCE_TYPE_CD_C);
SELF.CREATED_BY := 'HPCCLOAD';
SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := ''; 
SELF.LAST_UPDATE_DT := '';
SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C; 
SELF.BATCH_NUMBER := '';
SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
SELF := [];
END;	

ds_CriminalSentences := PROJECT(ds_NormSentences,tr_CourtOffensesToCrimSentences(LEFT));

export MapCourtOffensesToCriminalSentences := //SORT(ds_CriminalSentences,ecl_cade_id,ecl_charge_id);
                                                                                        ds_CriminalSentences
																						: persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapCourtOffensesToCriminalSentences');   
                                                                    																						 
