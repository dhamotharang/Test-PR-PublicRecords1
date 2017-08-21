

import crim_common;
import crim_cp_ln;

// Layout_CriminalSentences_Offender_key := RECORD
// INTEGER ecl_cade_id;
// INTEGER ecl_charge_id;
// crim_common.Layout_Moxie_Court_Offenses.offender_key;
// Crim_CP_LN.layout_cross_criminal_sentences;
// end;

Layout_Normalize_Sentences := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
crim_common.Layout_Moxie_Court_Offenses.offender_key;
Crim_CP_LN.layout_cross_criminal_sentences.SENTENCE_COMMENT_C;
Crim_CP_LN.layout_cross_criminal_sentences.SETY_SENTENCE_TYPE_CD_C;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
end;

Layout_Normalize_Sentences tr_Normalize_Sentences(File_Court_Offenses_ECL_Cade_id L, INTEGER C) := TRANSFORM 
  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.ecl_charge_id := L.ecl_charge_id;
	SELF.offender_key := L.offender_key;
	SELF.SENTENCE_COMMENT_C := CHOOSE(C,IF(LENGTH(TRIM(L.sent_date))>0,TRIM(L.sent_date,LEFT,RIGHT) + ' (YYYYMMDD)',''),
	                                    IF(LENGTH(TRIM(L.sent_jail))>0,TRIM(L.sent_jail,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_susp_time))>0,'Sent Susp Time :' + TRIM(L.sent_susp_time,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_court_cost))>0,TRIM(L.sent_court_cost,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_court_fine))>0 and TRIM(L.sent_court_fine,LEFT,RIGHT) <> '0',TRIM(L.sent_court_fine,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_susp_court_fine))>0 and TRIM(L.sent_susp_court_fine,LEFT,RIGHT) <> '0',TRIM(L.sent_susp_court_fine,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_probation))>0,TRIM(L.sent_probation,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.sent_consec))>0,TRIM(L.sent_consec,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.traffic_ticket_number))>0,TRIM(L.traffic_ticket_number,LEFT,RIGHT),''),
																			TRIM(MAP(L.le_agency_desc <> '' and L.le_agency_cd <> '' 
													              => TRIM(L.le_agency_desc) + ' - ' + TRIM(L.le_agency_cd),
																             L.le_agency_desc <> ''
																          => TRIM(L.le_agency_desc),
																			        L.le_agency_cd <> ''
																				       => TRIM(L.le_agency_cd),'')),																							 
																 
																			 if(TRIM(L.source_file) = 'TX-Midland',
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
																																							 => TRIM(L.court_disp_code),''))
																																							 ,'')
																							 
																							 );
																							 
	SELF.SETY_SENTENCE_TYPE_CD_C := CHOOSE(C,IF(LENGTH(TRIM(L.sent_date))>0,'51',''),              //Sety Code for L.sent_date,
																						IF(LENGTH(TRIM(L.sent_jail))>0,'1',''),              //Sety Code for L.sent_jail,
																						IF(LENGTH(TRIM(L.sent_susp_time))>0,'13',''),        //Sety Code for L.sent_susp_time,
																						IF(LENGTH(TRIM(L.sent_court_cost))>0,'2',''),        //Sety Code for L.sent_court_cost,
																						IF(LENGTH(TRIM(L.sent_court_fine))>0,'14',''),       //Sety Code for L.sent_court_fine,
																						IF(LENGTH(TRIM(L.sent_susp_court_fine))>0,'33',''),  //Sety Code for L.sent_susp_court_fine,
																						IF(LENGTH(TRIM(L.sent_probation))>0,'7',''),         //Sety Code for L.sent_probation,
																						IF(LENGTH(TRIM(L.sent_consec))>0,'39',''),           //Sety Code for L.sent_consec);
																						IF(LENGTH(TRIM(L.traffic_ticket_number))>0,'CI',''),  //Sety Code for L.traffic_ticket_number,
																						IF(L.le_agency_desc + L.le_agency_cd <> '','AG',''),            //Sety Code for L.sent_consec,
																						
																						IF(L.court_disp_desc_1 + L.court_disp_desc_2 + L.court_disp_code <> '','83','')            //Sety Code for disposition,
																						
																						);          																		

  SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
  SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C; 
end;																			
		 

//ds_NormSentences := NORMALIZE(File_Court_Offenses_ECL_Cade_id,8,tr_Normalize_Sentences(LEFT,COUNTER));
ds_NormSentences := NORMALIZE(File_Court_Offenses_ECL_Cade_id,11,tr_Normalize_Sentences(LEFT,COUNTER));


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

export MapCourtOffensesToCriminalSentences := SORT(ds_CriminalSentences,ecl_cade_id,ecl_charge_id);