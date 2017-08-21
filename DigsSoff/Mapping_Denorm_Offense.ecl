/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes the records in Offense file. 
***********************************************************************************
*/   

// Populate the ID's in the denormalized layout
// temp_file_soff_address := dataset([
// {'1' ,'ID','CHARGE5','DEGREE5','TIER_LEVEL5','OFFENSE_DATE5','STATUTE5','STATUTE_DESCRIPTION5','CONVICTION_DATE5','RELEASE_DATE5','COURT_COUNTY5','LOCATION5','DOCKET5','SENTENCE5','SENTENCE_EXPIRES5','AGENCY5','SUPER_AGENCY5','VICTIM5','DESCRIPTION5','CLASS5','CATEGORY5','WEOPONS_USED5','REL_TO_VICTIM5','MAX_EXP_DATE5','COUNTS5','REG_COUNTY5','REG_DATE5','HAB5','AGG5','DISPOSITION_DATE5','DISPOSITION5','ARREST_DATE_5','ARREST_WARRENT_5','VICTIM_MINOR5','VICTIM_AGE5','VICTIM_GENDER5','REFINDKEY'},
// {'21','ID','CHARGE1','DEGREE1','TIER_LEVEL1','OFFENSE_DATE1','STATUTE1','STATUTE_DESCRIPTION1','CONVICTION_DATE1','RELEASE_DATE1','COURT_COUNTY1','LOCATION1','DOCKET1','SENTENCE1','SENTENCE_EXPIRES1','AGENCY1','SUPER_AGENCY1','VICTIM1','DESCRIPTION1','CLASS1','CATEGORY1','WEOPONS_USED1','REL_TO_VICTIM1','MAX_EXP_DATE1','COUNTS1','REG_COUNTY1','REG_DATE1','HAB1','AGG1','DISPOSITION_DATE1','DISPOSITION1','ARREST_DATE_1','ARREST_WARRENT_1','VICTIM_MINOR1','VICTIM_AGE1','VICTIM_GENDER1','REFINDKEY'},
// {'23','ID','CHARGE3','DEGREE3','TIER_LEVEL3','OFFENSE_DATE3','STATUTE3','STATUTE_DESCRIPTION3','CONVICTION_DATE3','RELEASE_DATE3','COURT_COUNTY3','LOCATION3','DOCKET3','SENTENCE3','SENTENCE_EXPIRES3','AGENCY3','SUPER_AGENCY3','VICTIM3','DESCRIPTION3','CLASS3','CATEGORY3','WEOPONS_USED3','REL_TO_VICTIM3','MAX_EXP_DATE3','COUNTS3','REG_COUNTY3','REG_DATE3','HAB3','AGG3','DISPOSITION_DATE3','DISPOSITION3','ARREST_DATE_3','ARREST_WARRENT_3','VICTIM_MINOR3','VICTIM_AGE3','VICTIM_GENDER3','REFINDKEY'},
// {'22','ID','CHARGE2','DEGREE2','TIER_LEVEL2','OFFENSE_DATE2','STATUTE2','STATUTE_DESCRIPTION2','CONVICTION_DATE2','RELEASE_DATE2','COURT_COUNTY2','LOCATION2','DOCKET2','SENTENCE2','SENTENCE_EXPIRES2','AGENCY2','SUPER_AGENCY2','VICTIM2','DESCRIPTION2','CLASS2','CATEGORY2','WEOPONS_USED2','REL_TO_VICTIM2','MAX_EXP_DATE2','COUNTS2','REG_COUNTY2','REG_DATE2','HAB2','AGG2','DISPOSITION_DATE2','DISPOSITION2','ARREST_DATE_2','ARREST_WARRENT_2','VICTIM_MINOR2','VICTIM_AGE2','VICTIM_GENDER2','REFINDKEY'},
// {'24','ID','CHARGE4','DEGREE4','TIER_LEVEL4','OFFENSE_DATE4','STATUTE4','STATUTE_DESCRIPTION4','CONVICTION_DATE4','RELEASE_DATE4','COURT_COUNTY4','LOCATION4','DOCKET4','SENTENCE4','SENTENCE_EXPIRES4','AGENCY4','SUPER_AGENCY4','VICTIM4','DESCRIPTION4','CLASS4','CATEGORY4','WEOPONS_USED4','REL_TO_VICTIM4','MAX_EXP_DATE4','COUNTS4','REG_COUNTY4','REG_DATE4','HAB4','AGG4','DISPOSITION_DATE4','DISPOSITION4','ARREST_DATE_4','ARREST_WARRENT_4','VICTIM_MINOR4','VICTIM_AGE4','VICTIM_GENDER4','REFINDKEY'}],Layout_soff_Offense);
 
// DSortedOffense  := SORT(temp_file_soff_address,id);
// IdTable         := table(File_soff_Offense,Layout_Denorm_Offense,id); 

DOffense       := DISTRIBUTE(File_soff_Offense,  HASH32(File_soff_Offense.id));
DSortedOffense := SORT(DOffense,id,conviction_date,LOCAL);
IdTable        := table(DSortedOffense,Layout_Denorm_Offense,id,LOCAL);
//output(count(IdTable));
//output(IdTable);
//output(File_soff_vehicle);

 
Layout_Denorm_Offense DeNormOffense(Layout_Denorm_Offense L, Layout_soff_Offense R, INTEGER C) := TRANSFORM
      //combine the charge and statute desc fields to come up with the charge information. 
			//If charge overflows put it in offense_description_1_2
			//Othere things that could get mapped to offense_description_1_2 are degree, category, weapons info and counts. 
      string v_charge_temp           := trim(trim(R.statute_description,LEFT,RIGHT) +
			                                                IF(R.charge<> '',' '+ trim(R.charge,LEFT,RIGHT),''),LEFT);
			
			string v_charge                := IF(REGEXFIND('DEGREE', stringlib.StringToUpperCase(v_charge_temp)) ,v_charge_temp,
			                                                v_charge_temp+ IF (R.degree <> '' and trim(R.degree) <> '0','; DEGREE - '+trim(R.degree),''));
																											
			varstring v_Offense_desc_1     := IF (v_charge[1..2]='; ',v_charge[3..], v_charge) ;

			// Concatinate Additional information regarding the offense to populate v_Offense_desc_2							
			varstring v_Offense_deg_cat    := trim(trim(trim(trim(trim(trim(
			                                      IF(R.class   <> '' ,'CLASS - '+trim(R.class),'')+
                                            IF(R.victim <> '' ,'; VICTIM - '+trim(R.victim),''),LEFT,RIGHT)+
																						IF(R.weopons_used <> '' ,'; WEAPONS - '+trim(R.weopons_used),''),LEFT,RIGHT)+		
																						IF(R.disposition_date <> '' ,'; DISPOSITION DATE - '+trim(R.disposition_date),''),LEFT,RIGHT)+
																						IF(R.disposition <> '' ,'; DISPOSITION - '+trim(R.disposition),''),LEFT,RIGHT)+
																						IF(R.category <> '' ,'; CATEGORY - '+trim(R.category),''),LEFT,RIGHT)+
                                            IF(R.counts <> '' ,'; COUNTS - '+trim(R.counts),''),LEFT,RIGHT);
																						
			Varstring V_Offense_deg_cat_1  :=  IF(v_Offense_deg_cat[1..2]='; ',v_Offense_deg_cat[3..],v_Offense_deg_cat);
			
			varstring v_Offense_desc_2_1   :=  IF (trim(v_Offense_desc_1)<> trim(R.description),trim(R.description),'');
	    
			varstring v_Offense_desc_2_2   :=  IF(v_Offense_desc_2_1 <>'', 
			                                                 IF(V_Offense_deg_cat_1 <>'' , V_Offense_deg_cat_1 +'; '+trim(v_Offense_desc_2_1),
																											                             v_Offense_desc_2_1),
			                                                  V_Offense_deg_cat_1);   
      																											
			
			varstring v_victim_gender      :=  IF(R.victim_gender<>'',trim(R.victim_gender,LEFT,RIGHT),'');
			varstring v_sentense_1_2_temp  :=  trim(IF(R.sentence_expires <> '',' SENTENCE EXPIRES: '+trim(R.sentence_expires),'') + 
			                                        IF(R.Release_date     <> '','; RELEASE DATE: '+R.Release_date,''),LEFT,RIGHT);
																					 
			varstring v_sentense_1_2       :=  IF ( v_sentense_1_2_temp[1..2] = '; ', v_sentense_1_2_temp[3..]	,v_sentense_1_2_temp);
			
			
			SELF.arrest_date_1             :=	 IF(C=1, trim(R.arrest_date,LEFT,RIGHT), L.arrest_date_1);
			SELF.arrest_warrant_1          :=  IF(C=1, trim(R.arrest_warrant,LEFT,RIGHT), L.arrest_warrant_1);
			SELF.conviction_jurisdiction_1 :=  IF(C=1, trim(R.location,LEFT,RIGHT), L.conviction_jurisdiction_1);
			SELF.conviction_date_1         :=  IF(C=1, trim(R.conviction_date,LEFT,RIGHT), L.conviction_date_1);
			SELF.court_1 									 :=  IF(C=1, trim(R.court_county,LEFT,RIGHT), L.court_1);
			SELF.court_case_number_1			 :=  IF(C=1, trim(R.docket,LEFT,RIGHT), L.court_case_number_1);
			SELF.offense_date_1						 :=  IF(C=1, trim(R.offense_date,LEFT,RIGHT), L.offense_date_1);
			SELF.offense_code_or_statute_1 :=  IF(C=1, trim(R.statute,LEFT,RIGHT), L.offense_code_or_statute_1);			
			SELF.offense_description_1     :=  IF(C=1, v_Offense_desc_1,L.offense_description_1);
			SELF.offense_description_1_2   :=  IF(C=1, v_Offense_desc_2_2[1..320], L.offense_description_1_2);
			SELF.victim_minor_1      			 :=  IF(C=1, MAP(R.victim_minor <> '' => trim(R.victim_minor),
                                                     REGEXFIND('MINOR', R.victim) => 'Y',
																										 REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) and 
                                                     REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) =false => 'Y',
                                                     regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(r.victim_age)) => 'Y',
																										 ''
																										), 
                                                  L.victim_minor_1
                                            );
			SELF.victim_age_1								:=  IF(C=1, trim(R.victim_age,LEFT,RIGHT), L.victim_age_1);
			SELF.victim_gender_1						:=  IF(C=1, v_victim_gender, L.victim_gender_1);	
			SELF.victim_relationship_1			:=  IF(C=1, trim(R.relation_to_victim,LEFT,RIGHT), L.victim_relationship_1);
			SELF.sentence_description_1			:=  IF(C=1, trim(R.sentence,LEFT,RIGHT), L.sentence_description_1	);
			SELF.sentence_description_1_2		:=  IF(C=1, v_sentense_1_2,
			                                            L.sentence_description_1_2); 
			
			
			SELF.arrest_date_2						  :=	IF(C=2, trim(R.arrest_date,LEFT,RIGHT), L.arrest_date_2);
			SELF.arrest_warrant_2					  :=  IF(C=2, trim(R.arrest_warrant,LEFT,RIGHT), L.arrest_warrant_2);
			SELF.conviction_jurisdiction_2  :=  IF(C=2, trim(R.location,LEFT,RIGHT), L.conviction_jurisdiction_2);
			SELF.conviction_date_2          :=  IF(C=2, trim(R.conviction_date,LEFT,RIGHT), L.conviction_date_2);
			SELF.court_2 										:=  IF(C=2, trim(R.court_county,LEFT,RIGHT), L.court_2);
			SELF.court_case_number_2				:=  IF(C=2, trim(R.docket,LEFT,RIGHT), L.court_case_number_2);
			SELF.offense_date_2							:=  IF(C=2, trim(R.offense_date,LEFT,RIGHT), L.offense_date_2);
			SELF.offense_code_or_statute_2  :=  IF(C=2, trim(R.statute,LEFT,RIGHT), L.offense_code_or_statute_2);			
			SELF.offense_description_2      :=  IF(C=2, v_Offense_desc_1,L.offense_description_2);
			SELF.offense_description_2_2    :=  IF(C=2, v_Offense_desc_2_2[1..320], L.offense_description_2_2);
		  SELF.victim_minor_2      				:=  IF(C=2, MAP(R.victim_minor <> '' => trim(R.victim_minor),
                                                      REGEXFIND('MINOR', R.victim) => 'Y',
																										  REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) and 
                                                      REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) =false => 'Y',
                                                      regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(r.victim_age)) => 'Y',
                                                      ''
																										 ), 
                                                  L.victim_minor_2
                                            );
			SELF.victim_age_2								:=  IF(C=2, trim(R.victim_age,LEFT,RIGHT), L.victim_age_2);
			SELF.victim_gender_2						:=  IF(C=2, v_victim_gender, L.victim_gender_2);
			SELF.victim_relationship_2			:=  IF(C=2, trim(R.relation_to_victim,LEFT,RIGHT), L.victim_relationship_2);
			SELF.sentence_description_2			:=  IF(C=2, trim(R.sentence,LEFT,RIGHT), L.sentence_description_2	);
			SELF.sentence_description_2_2		:=  IF(C=2, v_sentense_1_2,
			                                            L.sentence_description_2_2); 
			
			
			SELF.arrest_date_3						  :=	IF(C=3, trim(R.arrest_date,LEFT,RIGHT), L.arrest_date_3);
			SELF.arrest_warrant_3					  :=  IF(C=3, trim(R.arrest_warrant,LEFT,RIGHT), L.arrest_warrant_3);
			SELF.conviction_jurisdiction_3  :=  IF(C=3, trim(R.location,LEFT,RIGHT), L.conviction_jurisdiction_3);
			SELF.conviction_date_3          :=  IF(C=3, trim(R.conviction_date,LEFT,RIGHT), L.conviction_date_3);
			SELF.court_3 										:=  IF(C=3, trim(R.court_county,LEFT,RIGHT), L.court_3);
			SELF.court_case_number_3				:=  IF(C=3, trim(R.docket,LEFT,RIGHT), L.court_case_number_3);
			SELF.offense_date_3							:=  IF(C=3, trim(R.offense_date,LEFT,RIGHT), L.offense_date_3);
			SELF.offense_code_or_statute_3  :=  IF(C=3, trim(R.statute,LEFT,RIGHT), L.offense_code_or_statute_3);			
			SELF.offense_description_3      :=  IF(C=3, v_Offense_desc_1,L.offense_description_3);
			SELF.offense_description_3_2    :=  IF(C=3, v_Offense_desc_2_2[1..320], L.offense_description_3_2);
		  SELF.victim_minor_3      				:=  IF(C=3, MAP(R.victim_minor <> '' => trim(R.victim_minor),
                                                      REGEXFIND('MINOR', R.victim) => 'Y',
																										  REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) and 
                                                      REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) =false => 'Y',
                                                      regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(r.victim_age)) => 'Y',
																											''
																										 ), 
                                                  L.victim_minor_3
                                            );
			SELF.victim_age_3								:=  IF(C=3, trim(R.victim_age,LEFT,RIGHT), L.victim_age_3);
			SELF.victim_gender_3  					:=  IF(C=3, v_victim_gender, L.victim_gender_3);	
  		SELF.victim_relationship_3			:=  IF(C=3, trim(R.relation_to_victim,LEFT,RIGHT), L.victim_relationship_3);
			SELF.sentence_description_3			:=  IF(C=3, trim(R.sentence,LEFT,RIGHT), L.sentence_description_3	);
			SELF.sentence_description_3_2		:=  IF(C=3, v_sentense_1_2,
			                                            L.sentence_description_3_2); 
			
			SELF.arrest_date_4						  :=	IF(C=4, trim(R.arrest_date,LEFT,RIGHT), L.arrest_date_4);
			SELF.arrest_warrant_4					  :=  IF(C=4, trim(R.arrest_warrant,LEFT,RIGHT), L.arrest_warrant_4);
			SELF.conviction_jurisdiction_4  :=  IF(C=4, trim(R.location,LEFT,RIGHT), L.conviction_jurisdiction_4);
			SELF.conviction_date_4          :=  IF(C=4, trim(R.conviction_date,LEFT,RIGHT), L.conviction_date_4);
			SELF.court_4 										:=  IF(C=4, trim(R.court_county,LEFT,RIGHT), L.court_4);
			SELF.court_case_number_4				:=  IF(C=4, trim(R.docket,LEFT,RIGHT), L.court_case_number_4);
			SELF.offense_date_4							:=  IF(C=4, trim(R.offense_date,LEFT,RIGHT), L.offense_date_4);
			SELF.offense_code_or_statute_4  :=  IF(C=4, trim(R.statute,LEFT,RIGHT), L.offense_code_or_statute_4);			
			SELF.offense_description_4      :=  IF(C=4, v_Offense_desc_1,L.offense_description_4);
			SELF.offense_description_4_2    :=  IF(C=4, v_Offense_desc_2_2[1..320], L.offense_description_4_2);
  		SELF.victim_minor_4      				:=  IF(C=4, MAP(R.victim_minor <> '' => trim(R.victim_minor),
                                                      REGEXFIND('MINOR', R.victim) => 'Y',
																										  REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) and 
                                                      REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) =false => 'Y',
                                                      regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(r.victim_age)) => 'Y',
					                                            ''
																										 ), 
                                                  L.victim_minor_4
                                            );
			SELF.victim_age_4								:=  IF(C=4, trim(R.victim_age,LEFT,RIGHT), L.victim_age_4);
			SELF.victim_gender_4  					:=  IF(C=4, v_victim_gender, L.victim_gender_4);	
  		SELF.victim_relationship_4			:=  IF(C=4, trim(R.relation_to_victim,LEFT,RIGHT), L.victim_relationship_4);
			SELF.sentence_description_4			:=  IF(C=4, trim(R.sentence,LEFT,RIGHT), L.sentence_description_4	);
			SELF.sentence_description_4_2		:=  IF(C=4, v_sentense_1_2,
			                                            L.sentence_description_4_2); 
			
		  SELF.arrest_date_5						  :=	IF(C=5, trim(R.arrest_date,LEFT,RIGHT), L.arrest_date_5);
			SELF.arrest_warrant_5					  :=  IF(C=5, trim(R.arrest_warrant,LEFT,RIGHT), L.arrest_warrant_5);
			SELF.conviction_jurisdiction_5  :=  IF(C=5, trim(R.location,LEFT,RIGHT), L.conviction_jurisdiction_5);
			SELF.conviction_date_5          :=  IF(C=5, trim(R.conviction_date,LEFT,RIGHT), L.conviction_date_5);
			SELF.court_5 										:=  IF(C=5, trim(R.court_county,LEFT,RIGHT), L.court_5);
			SELF.court_case_number_5				:=  IF(C=5, trim(R.docket,LEFT,RIGHT), L.court_case_number_5);
			SELF.offense_date_5							:=  IF(C=5, trim(R.offense_date,LEFT,RIGHT), L.offense_date_5);
			SELF.offense_code_or_statute_5  :=  IF(C=5, trim(R.statute,LEFT,RIGHT), L.offense_code_or_statute_5);			
			SELF.offense_description_5      :=  IF(C=5, v_Offense_desc_1,L.offense_description_5);
			SELF.offense_description_5_2    :=  IF(C=5, v_Offense_desc_2_2[1..320], L.offense_description_5_2);
		  SELF.victim_minor_5      				:=  IF(C=5, MAP(R.victim_minor <> '' => trim(R.victim_minor),
                                                     REGEXFIND('MINOR', R.victim) => 'Y',
																										 REGEXFIND('ADOLESCENT|PRE[-]*PUBESCENT|PRE[-]*TEEN|(AGE|VICTIM)*.*(WAS|A|AN|TO)[ ](ONE|TWO|THREE|FOUR|FIVE|SIX|SEVEN|EIGHT|NINE|TEN|ELEVEN|TWELVE|THIRTEEN|FOURTEEN|FIFTEEN|SIXTEEN|SEVENTEEN|EIGHTEEN)[ -](YEAR[S]*[- ]*O[L]*D)|([1][01234567]|[ ][0123456789])[- ](YEAR[S]*|YR[S.]*)[- ]OLD|AGE.*[01][01234567]|AGE.*[ ][123456789][). ]|(VICTIM|FEMALE|MALE).*[ ][0123456789][) ]|STAT[. ](RAPE|SODOMY)|STATUTORY|CUSTODIAL|GUARDIAN|SUPERVISORY|UNDERAGE|W/MNR|W/MINR|MINOR|W/JUV|[( ]JUV[). ]|JUVENILE|PUPIL|CHI[LDS][LDS]+|CH[ILD][ILD]+|CHLID|CGILD|CH[U]*LD|(FEMALE|MALE|V[ICTIMS]+[ ].*|VCTM[ ].*|PERSON[ ].*|V[ICTIM]*)1[01234567]([ -]1[01234567])*(YEARS OF AGE)*|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*1[012345678]|(W/|U[/]*|UND[ER]*(AGE OF)*|LESS THAN|<)[ _]*[123456789][ ]',stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) and 
                                                     REGEXFIND ('OVER 18|JUVENILE PROBATION' ,stringlib.stringtouppercase(v_Offense_desc_1+' '+v_Offense_desc_2_2)) =false => 'Y',
                                                     regexfind('MINOR|<18|UNDER 18|^[0]*[0123456789]([,; ]|$)|[10][01234567]([,; ]|$)|([10][01234567]|[0123456789])[ ]*-[ ]*([0123456789]([ ]|$)|[01][01234567])',stringlib.stringtouppercase(r.victim_age)) => 'Y',
					                                           ''
																										), 
                                                  L.victim_minor_5
                                            );
			SELF.victim_age_5								:=  IF(C=5, trim(R.victim_age,LEFT,RIGHT), L.victim_age_5);
			SELF.victim_gender_5						:=  IF(C=5, v_victim_gender, L.victim_gender_5);	
  		SELF.victim_relationship_5			:=  IF(C=5, trim(R.relation_to_victim,LEFT,RIGHT), L.victim_relationship_5);
			SELF.sentence_description_5			:=  IF(C=5, trim(R.sentence,LEFT,RIGHT), L.sentence_description_5	);
			SELF.sentence_description_5_2		:=  IF(C=5, v_sentense_1_2,
			                                            L.sentence_description_5_2);
 
			
		  SELF := L;
end;
	 
export Mapping_Denorm_Offense := DENORMALIZE(IdTable,DSortedOffense,
                                             LEFT.id = RIGHT.id,
																             DeNormOffense(LEFT,RIGHT,COUNTER),LOCAL );
																	
														
														
