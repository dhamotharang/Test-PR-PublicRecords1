import crim_common;
import crim_cp_ln;
import hygenics_crim;


Layout_Normalize_Sentences := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
hygenics_crim.Layout_In_Court_Offenses.offender_key;
Crim_CP_LN.layout_cross_criminal_sentences.SENTENCE_COMMENT_C;
Crim_CP_LN.layout_cross_criminal_sentences.SETY_SENTENCE_TYPE_CD_C;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
end;


Layout_criminal_sentences_cp tr_Normalize_Sentences(File_Court_Offenses_ECL_Cade_id L, INTEGER C) := TRANSFORM, 
																																																 SKIP(L.registration_type+
																																																			L.offender_status+
																																																			L.offender_category+
																																																			L.risk_level_code+
																																																			L.risk_description +
																																																			L.reg_date_1+
																																																			L.reg_date_1_type+
																																																			L.reg_date_2+
																																																			L.reg_date_2_type+
																																																			L.reg_date_3+
																																																			L.reg_date_3_type+
																																																			L.victim_minor+
																																																			L.victim_age+
																																																			L.victim_gender+
																																																			L.victim_relationship+
																																																			L.sentence_description+
																																																			L.sentence_description_2+
																																																			L.registration_county +
																																																			//L.police_agency+
																																																			L.court= '')  																																																	
																					                                                   							
		RiskLevel    := trim(L.risk_level_code)+' '+trim(L.risk_description);
    Reg_date     := MAP (L.reg_date_1_type <> '' and L.reg_date_1 <> '' =>trim(L.reg_date_1_type)+': '+ trim(L.reg_date_1)+ ' (YYYYMMDD)',
		                     L.reg_date_1_type =  '' and L.reg_date_1 <> '' =>'Registration Date: '+ trim(L.reg_date_1)+ ' (YYYYMMDD)',
		                     '');
    Reg_exp_date := MAP (L.reg_date_2_type <> '' and L.reg_date_2 <> '' =>trim(L.reg_date_2_type)+': '+ trim(L.reg_date_2)+ ' (YYYYMMDD)',
		                     L.reg_date_2_type =  '' and L.reg_date_2 <> '' => 'Registration Expiration Date: ' + trim(L.reg_date_2)+ ' (YYYYMMDD)',
		                     '');
		Reg_dt_oth   := MAP (L.reg_date_3_type <> '' and L.reg_date_3 <> '' =>trim(L.reg_date_3_type)+': '+ trim(L.reg_date_3)+ ' (YYYYMMDD)',
		                     '');
    Victim			 := trim(trim(trim(
		                IF (L.victim_minor        <> '' , 'Victim Minor: '        + trim(L.victim_minor) ,'')+ 
		                IF (L.victim_age          <> '' , ' Victim Age: '         + trim(L.victim_age)   ,''),left,right)+
										IF (L.victim_gender       <> '' , ' Victim Gender: '      + trim(L.victim_gender),''),left,right)+
										IF (L.victim_relationship <> '' , ' Victim Relationship: '+ trim(L.victim_relationship),''),left,right);
																	
		sentence_expires := MAP(regexfind('(SENTENCE_END_DATE: )(.*)(;)(.*)',trim(L.sentence_description_2)	)    => 	regexreplace('(SENTENCE_END_DATE: )(.*)(;)(.*)',trim(L.sentence_description_2),'$2'),	
		                        regexfind('(.*)(;) (SENTENCE_END_DATE: )(.*)$',trim(L.sentence_description_2)	)  => 	regexreplace('(.*)(;) (SENTENCE_END_DATE: )(.*)$',trim(L.sentence_description_2),'$4'),	
									          regexfind('(SENTENCE_END_DATE: )(.*)$',trim(L.sentence_description_2)	)          => 	regexreplace('(SENTENCE_END_DATE: )(.*)$'  ,trim(L.sentence_description_2),'$2'),	
                            '');

	SELF.SENTENCE_COMMENT_C := CHOOSE(C,IF(RiskLevel              <> '',RiskLevel,''),
	                                    IF(Reg_date               <> '',Reg_date,''),
																			IF(Reg_exp_date           <> '',Reg_exp_date,''),
																			IF(Reg_dt_oth             <> '',Reg_dt_oth,''),
																			IF(L.registration_type    <> '','Type: '+ trim(L.registration_type),''),
																			IF(L.registration_county  <> '','County: '+ trim(L.registration_county),''),
																			IF(L.offender_status      <> '',L.offender_status,''),
																			IF(L.offender_category    <> '','Category: '+ trim(L.offender_category),''),
																			IF(Victim                 <> '',Victim,''),
																			IF(sentence_expires       <> '',sentence_expires,''),
																			IF(L.sentence_description <> '',trim(L.sentence_description),''),
																			//IF(L.police_agency        <> '',trim(L.police_agency),''),
																			IF(L.court                <> '','COURT: '+trim(L.court),'')
																	 );
																							 
	SELF.SETY_SENTENCE_TYPE_CD_C := CHOOSE(C,IF(RiskLevel              <> '','LV',''),
	                                         IF(Reg_date               <> '','RG',''),
																			     IF(Reg_exp_date           <> '','RG',''),
																			     IF(Reg_dt_oth             <> '','RG',''),
																					 IF(L.registration_type    <> '','RG',''),
																					 IF(L.registration_county  <> '','57',''),
																			     IF(L.offender_status      <> '','CU',''),
																			     IF(L.offender_category    <> '','13',''),
																			     IF(Victim                 <> '','72',''),	
																					 IF(sentence_expires       <> '','71',''),
																			     IF(L.sentence_description <> '','32',''),
																					 //IF(L.police_agency        <> '','AG',''),
																			     IF(L.court                <> '','31','')
																				);
																				
																		
SELF.ECL_CADE_ID             := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID           := L.ECL_CHARGE_ID;
SELF.OFFENDER_KEY            := L.seisint_primary_key;
SELF.SENTENCE_AMT_C          := '';
//SELF.SENTENCE_COMMENT_C  := TRIM(L.SENTENCE_COMMENT_C);
SELF.CRCH_CRCH_ID            := '';

SELF.CREATED_BY              := 'HPCCLOAD';
SELF.CREATION_DT             := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY         := ''; 
SELF.LAST_UPDATE_DT          := '';
SELF.RECORD_SUPPLIER_CD      := L.RECORD_SUPPLIER_CD_C; 
SELF.BATCH_NUMBER            := '';
SELF.OLD_RECORD_SUPPLIER_CD  := L.OLD_RECORD_SUPPLIER_CD_C;
SELF := [];																				
    																						
// Sentence type cd and sentence type desc		
// registration_type := 'RG ';
// offender_status   := 'CU - Current status';
// offender_category := '13 - Category';
// risk_level_code   := 'LV';
// risk_description  := 'LV';
// reg_date_1        := 'RG';
// reg_date_2        := 'RG';
// reg_date_3        := 'RG';
// victim_minor+ victim_age+victim_gender+victim_relationship    := '72';
// sentence_description := '32';

end;																			
		 
ds_NormSentences := NORMALIZE(File_Court_Offenses_ECL_Cade_id,12,tr_Normalize_Sentences(LEFT,COUNTER));
sorted_NormSentences := SORT(ds_NormSentences,ECL_CADE_ID,OFFENDER_KEY,SENTENCE_COMMENT_C,SETY_SENTENCE_TYPE_CD_C,ECL_CHARGE_ID);
ds_CriminalSentences := DEDUP(sorted_NormSentences(SETY_SENTENCE_TYPE_CD_C IN ['LV','RG','CU','13','57'] and SENTENCE_COMMENT_C <> ''),
                              ECL_CADE_ID,OFFENDER_KEY,SENTENCE_COMMENT_C,SETY_SENTENCE_TYPE_CD_C,LEFT);

export MapCourtOffensesToCriminalSentences :=  ds_CriminalSentences + 
                 sorted_NormSentences(SETY_SENTENCE_TYPE_CD_C NOT IN ['LV','RG','CU','13','57'] and SENTENCE_COMMENT_C <> ''): persist ('~thor_data400::persist::out::crim::cross_SOFF::MapCourtOffensesToCriminalSentences');   
                                                                    																						 
