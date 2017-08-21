


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

Layout_Normalize_Sentences tr_Normalize_Sentences(File_Crim_Offenses_ECL_Cade_id L, INTEGER C) := TRANSFORM ,
                                              SKIP(L.stc_dt +
																										L.stc_desc_1 +
																										L.stc_desc_2 +
																										L.stc_desc_3 +
																										L.stc_desc_4 +
																										L.cty_conv_cd +
																										L.cty_conv +
																										L.stc_lgth_desc +
																										L.stc_lgth +
																										L.inc_adm_dt +
																										L.min_term_desc +
																										L.max_term_desc +
																										L.adj_wthd +
																										L.Parole +
																										L.Probation = '')

														
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
	 
	
  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.ecl_charge_id := L.ecl_charge_id;
	SELF.offender_key := L.offender_key;
	SELF.SENTENCE_COMMENT_C :=
	                     CHOOSE(C,IF(LENGTH(TRIM(L.stc_dt))>0,TRIM(L.stc_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),	                                 																	  
																			IF(LENGTH(TRIM(L.stc_desc_1))>0, TRIM(L.stc_desc_1,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.stc_desc_2))>0, TRIM(L.stc_desc_2,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.stc_desc_3))>0, TRIM(L.stc_desc_3,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.stc_desc_4))>0, TRIM(L.stc_desc_4,LEFT,RIGHT),''),		
																			IF(LENGTH(TRIM(cty_conv))>0 and L.OLD_RECORD_SUPPLIER_CD_C = 'AZDO', TRIM(cty_conv,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(stc_lgth))>0,TRIM(stc_lgth,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.inc_adm_dt))>0 and L.OLD_RECORD_SUPPLIER_CD_C IN ['ILDO','KYDO'],TRIM(L.inc_adm_dt,LEFT,RIGHT) + ' (YYYYMMDD)',''),
																			IF(LENGTH(TRIM(L.min_term_desc))>0,TRIM(L.min_term_desc,LEFT,RIGHT),''),   
																			IF(LENGTH(TRIM(L.max_term_desc))>0,TRIM(L.max_term_desc,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(L.adj_wthd))>0,TRIM(L.adj_wthd,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(l.Parole))>0,TRIM(l.Parole,LEFT,RIGHT),''),
																			IF(LENGTH(TRIM(l.Probation))>0,TRIM(l.Probation,LEFT,RIGHT),'')																			
																				 );
	SELF.SETY_SENTENCE_TYPE_CD_C := 
	                      CHOOSE(C,IF(LENGTH(TRIM(L.stc_dt))>0,'51',''),              //Sety Code for L.stc_dt,
	                                     IF(LENGTH(TRIM(L.stc_desc_1))>0,'91',''),             //Sety Code for L.stc_desc_1,
																			 IF(LENGTH(TRIM(L.stc_desc_2))>0,'61',''),             //Sety Code for L.stc_desc_2,
																			 IF(LENGTH(TRIM(L.stc_desc_3))>0,'18',''),             //Sety Code for L.stc_desc_3,
																			 IF(LENGTH(TRIM(L.stc_desc_4))>0,'68',''),             //Sety Code for L.stc_desc_4,
																			 IF(LENGTH(TRIM(cty_conv))>0 and L.OLD_RECORD_SUPPLIER_CD_C = 'AZDO','57',''),             //Sety Code for cty_conv,  ///only for azdo.
																				IF(LENGTH(TRIM(stc_lgth))>0,'32',''),             //Sety Code for stc_lgth,
																				IF(LENGTH(TRIM(L.inc_adm_dt))>0 and L.OLD_RECORD_SUPPLIER_CD_C IN ['ILDO','KYDO'],'93',''),         //Sety Code for L.inc_adm_dt,  //map for IL and KY
																				IF(LENGTH(TRIM(L.min_term_desc))>0,'20',''),      //Sety Code for L.min_term_desc,
																				IF(LENGTH(TRIM(L.max_term_desc))>0,'19',''),      //Sety Code for L.max_term_desc,
																				IF(LENGTH(TRIM(L.adj_wthd))>0,'97',''),           //Sety Code for L.adj_wthd,
																				IF(LENGTH(TRIM(l.Parole))>0,'42',''),            //Sety Code for L.Parole,
																				IF(LENGTH(TRIM(l.Probation))>0,'7','')            //Sety Code for L.Probation,
         																		);
	// 19 Maximum Jail Time
	// 20 Minimum Jail Time
	// 32 Sentence
	// 51 Sentence Date
	// 57 Sentence County
	// 93 Original Admit Date
	// 97 Adjudication Withheld Flag		
	//91 Sentence Type for L.stc_desc_1
  //61 Minimum Sentence Date for L.stc_desc_2
	//18 Community Control  for L.stc_desc_3
	//68 Facility  for L.stc_desc_4	
	//42 Parole
	//7 Probation
																					

  SELF.OLD_RECORD_SUPPLIER_CD_C :=   
	                                                               Map(l.source_file = 'NJ_DOC' and l.case_type =  'ADM' => 'NJAD',
																											                l.source_file = 'NJ_DOC' and l.case_type =  'REL' => 'NJRL',
																															        l.source_file = 'NJ_DOC' and l.case_type =  'RES' => 'NJRS',	
                                                                      L.OLD_RECORD_SUPPLIER_CD_C);
                                                      
  SELF.RECORD_SUPPLIER_CD_C := 
	
	                                                Map(l.source_file = 'NJ_DOC' and l.case_type =  'ADM' => '9041',
																											        l.source_file = 'NJ_DOC' and l.case_type =  'REL' => '9041',
																															l.source_file = 'NJ_DOC' and l.case_type =  'RES' => '9040',	
                                                              l.RECORD_SUPPLIER_CD_C);
	

end;																			
		 

ds_NormSentences := NORMALIZE(File_Crim_Offenses_ECL_Cade_id,13,tr_Normalize_Sentences(LEFT,COUNTER));


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

dist_distribute_offense :=  DISTRIBUTE(ds_CriminalSentences,HASH32(offender_key));

ds_sort_CriminalSentences := SORT(dist_distribute_offense,ecl_cade_id,ecl_charge_id,offender_key,crse_id,sentence_amt_c,sentence_comment_c,sety_sentence_type_cd_c,local);

ds_dedup_CriminalSentences := dedup(ds_sort_CriminalSentences,ecl_cade_id,ecl_charge_id,offender_key,crse_id,sentence_amt_c,sentence_comment_c,sety_sentence_type_cd_c,local);

export MapCourtOffensesToCriminalSentences := SORT(ds_dedup_CriminalSentences,ecl_cade_id,ecl_charge_id);

