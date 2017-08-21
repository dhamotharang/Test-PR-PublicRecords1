


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

Layout_Normalize_Sentences tr_Normalize_Sentences(File_Crim_Offenses_ECL_Cade_id L, INTEGER C) := TRANSFORM 

  sentence_desc := TRIM(
										 IF(LENGTH(TRIM(L.stc_cd))> 0,TRIM(L.stc_cd) +'; ','')
										+ IF(LENGTH(TRIM(L.stc_desc_1))> 0,TRIM(L.stc_desc_1) +'; ','')
										 + IF(LENGTH(TRIM(L.stc_desc_2))> 0,TRIM(L.stc_desc_2) +'; ','')
											+ IF(LENGTH(TRIM(L.stc_desc_3))> 0,TRIM(L.stc_desc_3) +'; ','')
												+ IF(LENGTH(TRIM(L.stc_desc_4))> 0,TRIM(L.stc_desc_4) +'; ','')
																)
												 [1..LENGTH(TRIM(
													 IF(LENGTH(TRIM(L.stc_cd))> 0,TRIM(L.stc_cd) +'; ','')
													+ IF(LENGTH(TRIM(L.stc_desc_1))> 0,TRIM(L.stc_desc_1) +'; ','')
													 + IF(LENGTH(TRIM(L.stc_desc_2))> 0,TRIM(L.stc_desc_2) +'; ','')
														+ IF(LENGTH(TRIM(L.stc_desc_3))> 0,TRIM(L.stc_desc_3) +'; ','')
															+ IF(LENGTH(TRIM(L.stc_desc_4))> 0,TRIM(L.stc_desc_4) +'; ','')
															))-1];
															
	cty_conv := TRIM(
										 IF(LENGTH(TRIM(L.cty_conv_cd))> 0,TRIM(L.cty_conv_cd) +'; ','')
										+ IF(LENGTH(TRIM(L.cty_conv))> 0,TRIM(L.cty_conv) +'; ','')
																)
												 [1..LENGTH(TRIM(
													 IF(LENGTH(TRIM(L.cty_conv_cd))> 0,TRIM(L.cty_conv_cd) +'; ','')
													+ IF(LENGTH(TRIM(L.cty_conv))> 0,TRIM(L.cty_conv) +'; ','')													 
															))-1];
	
	stc_lgth_clean := IF(L.stc_lgth<>'',
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
													REGEXREPLACE('XXX',TRIM(L.stc_lgth),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
													'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'');  				              
		
	stc_lgth := TRIM(
										 IF(LENGTH(TRIM(stc_lgth_clean))> 0,TRIM(stc_lgth_clean) +'; ','')
										+ IF(LENGTH(TRIM(L.stc_lgth_desc))> 0,TRIM(L.stc_lgth_desc) +'; ','')
																)
												 [1..LENGTH(TRIM(
													 IF(LENGTH(TRIM(stc_lgth_clean))> 0,TRIM(stc_lgth_clean) +'; ','')
													+ IF(LENGTH(TRIM(L.stc_lgth_desc))> 0,TRIM(L.stc_lgth_desc) +'; ','')													 
															))-1];		
	 
	min_term_clean := IF(L.min_term<>'',
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
													REGEXREPLACE('XXX',TRIM(L.min_term),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
													'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),''); 
						 
	max_term_clean := IF(L.max_term<>'',
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
													REGEXREPLACE('XXX',TRIM(L.max_term),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),
													'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'', NOCASE),'');  
						 

  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.ecl_charge_id := L.ecl_charge_id;
	SELF.offender_key := L.offender_key;
	SELF.SENTENCE_COMMENT_C := CHOOSE(C,IF(LENGTH(TRIM(L.stc_dt))>0,TRIM(L.stc_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
	                                    IF(LENGTH(TRIM(sentence_desc))>0,TRIM(sentence_desc,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(cty_conv))>0, TRIM(L.cty_conv,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(stc_lgth))>0,TRIM(stc_lgth,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.inc_adm_dt))>0,TRIM(L.inc_adm_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(L.min_term_desc))>0,TRIM(L.min_term_desc,LEFT,RIGHT),''),   
																			IF(LENGTH(TRIM(L.max_term_desc))>0,TRIM(L.max_term_desc,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.adj_wthd))>0,TRIM(L.adj_wthd,LEFT,RIGHT),'')
																				 );
	SELF.SETY_SENTENCE_TYPE_CD_C := CHOOSE(C,IF(LENGTH(TRIM(L.stc_dt))>0,'51',''),              //Sety Code for L.stc_dt,
																						IF(LENGTH(TRIM(sentence_desc))>0,'32',''),        //Sety Code for sentence_desc,
																						IF(LENGTH(TRIM(cty_conv))>0,'57',''),             //Sety Code for cty_conv,
																						IF(LENGTH(TRIM(stc_lgth))>0,'32',''),             //Sety Code for stc_lgth,
																						IF(LENGTH(TRIM(L.inc_adm_dt))>0,'93',''),         //Sety Code for L.inc_adm_dt,
																						IF(LENGTH(TRIM(L.min_term_desc))>0,'20',''),      //Sety Code for L.min_term_desc,
																						IF(LENGTH(TRIM(L.max_term_desc))>0,'19',''),      //Sety Code for L.max_term_desc,
																						IF(LENGTH(TRIM(L.adj_wthd))>0,'97','')            //Sety Code for L.adj_wthd,
																						); 
         																		
	// 19 Maximum Jail Time
	// 20 Minimum Jail Time
	// 32 Sentence
	// 51 Sentence Date
	// 57 Sentence County
	// 93 Original Admit Date
	// 97 Adjudication Withheld Flag
																					

  SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
  SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C; 
end;																			
		 

ds_NormSentences := NORMALIZE(File_Crim_Offenses_ECL_Cade_id,8,tr_Normalize_Sentences(LEFT,COUNTER));


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