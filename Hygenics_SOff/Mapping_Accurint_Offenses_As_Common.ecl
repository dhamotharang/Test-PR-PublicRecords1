import sexoffender;

df := File_Accurint_In; 

/*
newLayout := record
	layout_common_offense;
	df.dt_last_reported;
	df.offense_persistent_id;
end;
*/

layout_out_offense_cross normIt(df L, integer C) := transform
	self.seisint_primary_key 			:= L.seisint_primary_key;
	self.source_file							:= l.source_file;
	self.offense_date 						:= choose(C,L.Offense_date_1,L.offense_date_2,L.offense_date_3,L.offense_date_4,L.offense_date_5);
	self.offense_description 			:= choose(C,L.offense_description_1,L.offense_description_2,L.offense_description_3,L.offense_description_4,L.offense_description_5);
	self.offense_description_2 		:= choose(C,L.offense_description_1_2,L.offense_description_2_2,L.offense_description_3_2,L.offense_description_4_2,L.offense_description_5_2);
	self.conviction_jurisdiction 	:= choose(C,L.conviction_jurisdiction_1,L.conviction_jurisdiction_2,L.conviction_jurisdiction_3,L.conviction_jurisdiction_4,L.conviction_jurisdiction_5);
	self.conviction_date 					:= choose(C,L.conviction_date_1,L.conviction_date_2,L.conviction_date_3,L.conviction_date_4,L.conviction_date_5);
	self.court 										:= choose(C,L.court_1,L.court_2,L.court_3,L.court_4,L.court_5);
	self.court_case_number 				:= choose(C,L.court_case_number_1,L.court_case_number_2,L.court_case_number_3,L.court_case_number_4,L.court_case_number_5);
	self.offense_code_or_statute 	:= choose(C,L.offense_code_or_statute_1,L.offense_code_or_statute_2,L.offense_code_or_statute_3,L.offense_code_or_statute_4,L.offense_code_or_statute_5);
	self.victim_minor 						:= choose(C,L.victim_minor_1,L.victim_minor_2,L.victim_minor_3,L.victim_minor_4,L.victim_minor_5);
	self.victim_age 							:= choose(C,L.victim_age_1,L.victim_age_2,L.victim_age_3,L.victim_age_4,L.victim_age_5);
	self.victim_gender 						:= choose(C,L.victim_gender_1,L.victim_gender_2,L.victim_gender_3,L.victim_gender_4,L.victim_gender_5);
	self.victim_relationship 			:= choose(C,L.victim_relationship_1,L.victim_relationship_2,L.victim_relationship_3,L.victim_relationship_4,L.victim_relationship_5);
	self.sentence_description 		:= choose(C,L.sentence_description_1,L.sentence_description_2,L.sentence_description_3,L.sentence_description_4,L.sentence_description_5);
	self.sentence_description_2 	:= choose(C,L.sentence_description_1_2,L.sentence_description_2_2,L.sentence_description_3_2,L.sentence_description_4_2,L.sentence_description_5_2);	
	self.arrest_date 							:= choose(C,L.arrest_date_1,L.arrest_date_2,L.arrest_date_3,L.arrest_date_4,L.arrest_date_5);						//new field added
	self.arrest_warrant 					:= choose(C,L.arrest_warrant_1,L.arrest_warrant_2,L.arrest_warrant_3,L.arrest_warrant_4,L.arrest_warrant_5);		//new field added
	self.offense_category					:= '';
	self.offense_location 				:= choose(C,L.offense_location_1,L.offense_location_2,L.offense_location_3,L.offense_location_4,L.offense_location_5);				//new field added
	self.offense_level 						:= choose(C,L.offense_level_1,L.offense_level_2,L.offense_level_3,L.offense_level_4,L.offense_level_5);				//new field added
	self.disposition_dt 					:= choose(C,L.disposition_dt_1,L.disposition_dt_2,L.disposition_dt_3,L.disposition_dt_4,L.disposition_dt_5);		//new field added
	self.dt_last_reported					:= l.dt_last_reported;
	self := l;
end;

o1 					:= normalize(df,5,normIt(LEFT,COUNTER));

// Add offense_persistent_id
// output(o1(seisint_primary_key ='C2COSOR6270924709894374124' ));
	o1 addOPID(o1 l):= transform
			
		String 	filterField(String s) := FUNCTION
			return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		END;
	
		Vconviction_date 						:= filterField(l.conviction_date);
		Voffense_date 							:= filterField(l.offense_date);
		Voffense_code_or_statute		:= filterField(l.offense_code_or_statute);
		Vcourt_case_number 					:= filterField(l.court_case_number);
		Vvictim_gender							:= filterField(l.victim_gender);
		Vvictim_age 								:= filterField(l.victim_age);
		Voffense_description 				:= filterField(l.offense_description);
		Vsentence_description 			:= filterField(l.sentence_description);
		
		Vconviction_jurisdiction    := filterField(l.conviction_jurisdiction);
		VCourt                			:= filterField(l.Court);
		VOffense_category           := filterField(l.Offense_category);
		VArrest_date                := filterField(l.Arrest_date);
		
		self.offense_persistent_id 	:= hash64(
		                                      trim(l.seisint_primary_key, left, right) + Vconviction_date + Voffense_date + Voffense_code_or_statute + Vcourt_case_number +'X'+ Vvictim_gender + Vvictim_age + Voffense_description + Vsentence_description +
		                                      Vconviction_jurisdiction + VCourt + VOffense_category + VArrest_date
		                                     ); 
		// self.offense_persistent_id 	:= hash64(trim(l.seisint_primary_key, left, right) + Vconviction_date + Voffense_date + Voffense_code_or_statute + Vcourt_case_number + Vvictim_gender + Vvictim_age + Voffense_description + Vsentence_description);	
		
		self := l;
	end;

oPId_Added := project(o1, addOPID(left));

// output(oPId_Added(seisint_primary_key ='C2COSOR6270924709894374124' ));
/*
// Add offense_persistent_id

	o1 addOPID(o1 l):= transform
		self.offense_persistent_id := hash64(trim(trim(trim(trim(trim(trim(trim(l.seisint_primary_key, left, right) + trim(l.conviction_date, left, right), left, right) + trim(l.offense_date, left, right), left, right) + trim(l.offense_code_or_statute, left, right), left, right) + trim(l.court_case_number, left, right), left, right) + trim(l.victim_gender, left, right), left, right) + trim(l.victim_age, left, right), left, right));
		self := l;
	end;

oPId_Added := project(o1, addOPID(left));
*/
// Added dedup to the enture record to get rid of duplicate records
// output(count(oPId_Added),named('Before'));
o2 := dedup(oPId_Added(offense_description != ''),hash):persist('~thor40_241::persist::sex_offender_offenses_dedup');
// output(count(o2),named('after'));
// Classify offense categories
//Find First Offense
o2 defCategory(o2 l):= transform
		category_1 := (map(regexfind('BREAK AND ENTER|'+ 
						'BREAKING AND ENTERING|'+ 
						'BUGLARY|'+
						'BURG|'+ 
						'BURGLARY|'+
						'BURLARY|'+                                                                                                                                                                                                                                                                                                      
						'ENTER PRIVATE PROPERTY|'+ 
						'ENTER DWELLING WITHOUT CONSENT TO COMMIT ANNOYANCE|'+ 
						'HOME INVASION|'+ 
						'HOUSEBREAKING|'+ 
						'MALICIOUS ENTRY OF FINANCIAL INSTITUTION|'+
						'SERREPTITIOUS INTRUSTION|'+
						'SURREPTITIOUS INTRUSION|'+
						'UNLAWFUL ENTRY|'+
						'UNLAWFUL INTRUSION|'+						
						'750.356A3 - BREAKING & ENTERING - A VEHICLE WITH DAMAGE TO VEHICLE|'+
						'ENTRY INTO/ONTO BLDG/CONSTRUC.SITE/ROOM|'+
            'TRESSPASS 1-AUTO-W/INTENT TO COMMIT CRIME|'+
						'CRIMINAL TRESSPASS'


						,
						trim(l.offense_description, left, right),
						0)<>'' => 'BUR',//BURGLARY

					regexfind('CNT SX DLNQ MNR-MISD|'+                                                                                                                                                                                                                                                                                                            
						'CONT DELINQUENCY|'+
						//'CONT SEX|'+
						'CONT TO DELINQUENCY|'+
						'CONT TO THE DELINQUENCEY|'+
						'CONTRB|'+
						'CONTRIB|'+ 
						'CONTRIBUTING|'+ 
						'CONT. DEL.'
						,

						trim(l.offense_description, left, right),
						0)<>'' => 'CON',//CONTRIBUTING
					
					regexfind('CORRUPT|'+ 
						'CORRUPTING|'+
						'CRRUPTIN F MINRS|'+
            'ATTEMPTED CRRUPTIN F A MINR|'+

						'CORRUPTION',
						trim(l.offense_description, left, right),
						0)<>'' => 'COR',//CORRUPTION

					regexfind('ACTS IN THE PRESENCE OF A CHILD|'+
						'ALCOHOL TO MINOR|'+
						'CHILD ENDANG|'+
						'CHILD TO ENGAGE|'+
						'CHILDS PRESENCE|'+
						'CHILDREN - DISTRIBUTE OBSCENE MATTER|'+
						'CONSP TO COMMIT ABUSE|'+
						'CREULTY TO CHILD|'+
						'CRUELTY TO CHILD|'+
						'CRUELTY TO JUVENILE|'+ 
						'DEBAUCH A MINOR|'+ 
						'DEBAUCHING A MINOR|'+
						'DEBAUCHING MINOR|'+
						'DEPICTING MINORS|'+
						'DEPRAVE THE MORALS OF A CHILD|'+
						'DEPRIVE THE MORALS OF A CHILD|'+
						'DISP_TO_CHILD|'+
						'DISPLAY TO A MINOR|'+
						'DISPLAY TO MINOR|'+
						'DISPLAY_TO_CHILD|'+
						'DISSEM INDECENT MATERIAL TO MI|'+
						'DISTRIBUTE TO MINOR|'+
						'DISTRIBUTION TO A MINOR|'+
						'DOMESTIC VIOLENCE IN PRESENCE OF CHILD|'+
						'DRUG TO MINOR|'+ 			
						'ENDANG|'+
						'ENDANGER WELFARE OF CHILD/MINOR|'+
						'ENDANGERING WELFARE OF CHILDREN/MINOR|'+
						'ENGAGING A CHILD|'+
						'ENTICE A MINOR|'+
						'EXPLICIT MATERIAL TO MINOR|'+ 
						//'EXPLOIT OF A MINOR|'+
						//'EXPLOIT MINOR|'+
						//'EXPLOIT MNR|'+
						//'EXPLOITAT MINOR|'+
						'EXPOSED A CHILD|'+
						'EXPOSING A CHILD|'+
						'FIREARM TO MINOR|'+
						'FURN PORNO/ATMPT MINORS|'+
						'FURNISH TO MINORS|'+
						'FURNISH/TRANSMIT/TRANSPORT ALCOHOL/LIQUOR/DRUG/PORN/OBSCENE MATERIAL/FIREARM TO MINOR|'+ 
						'FURNISHING/TRANSMIT/TRANSPORT ALCOHOL/LIQUOR/DRUG/PORN/OBSCENE MATERIAL/FIREARM TO MINOR|'+
						'GIVE TO PERSON <21|'+	
						'HABORING A RUNAWAY|'+ 
						'HARBORING A RUNAWAY|'+                                                                                                                                                                                                                                                                                                             
						'HARMFUL INFORMATION TO MINORS|'+
						'HARMFUL MATERIAL TO SEDUCE MINOR|'+
						'HARMFUL MATERIAL TO MINOR|'+
						'HARMFUL MATERIALS TO MINORS|'+
						'HARMFUL MINOR|'+
						'HARMFUL TO A JUVENILE|'+
						'HARMFUL TO JUVENILE|'+
						'HARMFUL TO MINOR|'+
						'HARMFUL/MINORS|'+
						'IMMORAL ACTS BEFORE CHILD|'+
						'IMPAIR MORALS OF MINOR|'+ 
						'IMPAIRING MORALS|'+
						'IMPAIRING MORALS OF CHILDREN|'+
						'IMPAIRING MORALS OF MINOR|'+
						'IN PRESENCE OF C|'+
						'INDECENT MATERIAL TO MINOR|'+
						'INFORMATION ABOUT A MINOR|'+
						'INJURY OF MINOR|'+
						'INJURY OR RISK OF INJURY TO MINOR|'+
						'INJURY TO A CHILD|'+
						'INJURY TO A MINOR|'+
						'INJURY TO MINOR|'+
						'INJURY TO CHILD|'+
						'INJURY/RISK CHILD|'+
						'INVOL MINOR|'+
						'LIQUOR FOR MINOR|'+
						'LIQUOR TO MINOR|'+ 
						'MAT TO MINOR|'+
						'MATERIAL TO CHI|'+
						'MATERIAL TO A MINOR|'+
						'MATERIAL TO MINOR|'+
						'MATERIALS TO MINOR|'+
						'MATTER:MINOR|'+
						'MATTER TO A MINOR|'+
						'MINOR HARM|'+
						'MNRS ENG|'+
						'MORALS OF A CHILD|'+
						'MORALS OF CHI|'+
						'MORALS OF, CHILDREN|'+
						'MORALS OF MINORS|'+
						'OBS MTR/MNR|'+
						'OBSC ITEMS MINOR|'+
						'OBSC ITEMS TO MINORS|'+
						'OBSCENE MAT.MINOR|'+
						'OBSCENE MATERIAL MINOR|'+
						'OBSCENE MATERIAL TO A MINOR|'+
						'OBSCENE MATERIAL TO MINOR|'+
						'OBSCENITY TO CHILD|'+
						'OBSCENITY TO A MINOR|'+
						'PORN TO MINOR|'+
						'PRESENCE OF A CHI|'+
						'PRESENCE OF A MINOR|'+
						'PROMOTION TO MINOR|'+
						'PUNISHMENT OF CHILD|'+
						'SEDUCE A MINOR|'+
						'SEDUCE MINOR|'+
						'TRANSMI MATERIAL HARMFUL TO MI|'+
						'TRANSMIT/MINOR|'+
						'TRANSMITTING INFO ABOUT A MINOR|'+
						'UNLAWFUL DISPOSITION OF MATERIALS TO MINORS|'+
						'VIDEO TO MINOR|'+
						'WELLBEING OF A|'+
						'WELFARE OF A CH|'+	
						'WELFARE OF CHILD|'+
						'WILLFUL CRUELTY TO CHILD|'+
						'WELFARE OF A CHI|'+
						'WLFARE OF A CHILD|'+
						'USING CMPUTER T SEND INAPPRPRIATE MATERIAL T A MINR|'+
            'TRANFER F BSCENE MATERIAL T MINRS|'+
            'DISSEMINATE BSCENE MATERIAL T MINR|'+
            'BSCENE CMMUNICATIN/DISTRIBUTIN T MINR|'+
            'IMPARING MRALS|'+
            'DISTRIBUTIN F BSCENE MATTER T MINIRS|'+
            'DISTRIBUTIN F BSCENE MATTER T A MINR|'+
            'DISTRIBUTIN F BSENITY MATERIAL T A MINR|'+
						'WELFARE FRAUD|'+


						'WLFR CHILD',
						trim(l.offense_description, left, right),
						0)<>'' => 'END',//ENDANGERING_THE_WELFARE_OF_MINORS

					regexfind('EXPOLITATION|'+
						'EXPLOIT |'+ 
						'EXPLOITAION|'+
						'EXPLOITATION|'+
						'EXPOITATION|'+                                                                                                                                                                                                                                                                                                              
						'IMPORATATION OF ALIENS FOR IMMORAL PURPOSE|'+
						'SECRET PEEPING|'+
						'SEX EXPL|'+
						'SEXUAL EXPL|' +
						'EXPLITATIN F A MINR BY ELECTRNIC MEANS|'+

						'33V6902-7D - ELDERLY/DISABLED-EXPLOIT-SEXUAL' ,
						trim(l.offense_description, left, right),
						0)<>'' => 'EXP',//'EXPLOITATION'

					regexfind('ARTICLE 134 GENERAL ARTICLE VIOLATION 18 USC 2252A|'+
						'CHANGE OF ADDRESS|'+
					  'COMMUNITY NOTIFICATION ACT VIOL|'+
						'DESIGNATED SEXUAL PREDATOR OUT OF|'+
						'FAIL|'+ 
						'FAILURE|'+
						'FAIL COMPLY REG|'+
						'FAIL REG|'+
						'FAIL RPT|'+
						'FAIL TO COMPLY|'+
						'FAIL TO GIVE NOTIC|'+
						'FAIL TO NOT|'+
						'FAIL TO RE REGISTER|'+
						'FAIL TO REG|'+
						'FAIL TO REPORT|'+
						'FAILED TO REGISTER|'+
						'FAILING TO PAY REGISTRATION FEE|'+
						'FAILURE TO ACT|'+	
						'FAILURE TO CHANGE ADDRESS|'+
						'FAILURE TO COMPLY|'+
						'FAILURE TO NOTIFY|'+
						'FAILURE TO OBTAIN|'+
						'FAILURE TO PROPERLY REGISTER|'+
						'FAILURE TO PROVIDE CHANGE OF ADDRESS|'+
						'FAILURE TO PROVIDE INTERNET INFORMATION|'+
						'FAILURE TO REG|'+
						'FAILURE TO REPORT|'+
						'FAILURE TO VERIFY|'+
						'FAILURE TO VERIFY CURRENT ADDRESS|'+
						'FALSE INFORMATION|'+
						'FALSE/ MISLEADING INFORMATION|'+
						'FALSE/MISLEADING INFORMATION|'+
						'FTR|'+
						'ILLEGAL RESIDENCE|'+
						'LOITER|'+
						'NAME CHANGE|'+
						'NON-COMPLIANCE|'+ 
						'NON-COMPLIANT|'+
						'NONCOMPLIANCE 3RD DEGRE|'+
						'OFNDR LOITER W/I 500FT OF SCHOOL|'+
						'OFNDR PRSNT/LOITR 500FT PARK/POOL|'+
            'PR OFNDR RESIDE-1000 FT-SCHL-1ST|'+
            'PUNISHMENT: PROOF OF RESIDENCE|'+						
						'PAROLE VIOLATION|'+
						'PROBATION VIOLATION|'+
						'PROVIDE FALSE INFO|'+
						'PROVIDE FALSE/MISLEADING INFORMATION|'+
						'PROVIDE MISLEADING INFO|'+
						'PUNISHMENT: FELONY - FELONY PROTOCOLS|'+
						'PUNISHMENT: TRANSIENT|'+
						'REFUSING TO PAY REGISTRATION FEE|'+
						'REFUSING/FAILING TO PAY REGISTRATION FEE|'+
						'REGISTRATION VIOLATION|'+
						'REGISTRY FALSE INFO|'+ 
						'REGISTRY VIO|'+
						'RE-REGISTER VIOLATION|'+
						'RE-REGISTR.VIOL|'+
						'RESIDENCE VIOL|'+
						'SEX OFFENDER ENTERING SCHOOL|'+                                                                                                                                                                                                                                                                    
						'SEX OFFENDER PRESENT AT A PUBLIC PARK|'+
						'SEX OFFENDER REGISTRY VIOLATION|'+
						'SEX OFFENDER REGITRY VIOL|'+
						'SEX OFFENDER VIO REGISTRY LAWS|'+
						'SEX PRED. AROUND CHILDREN|'+
						'SEXUAL PREDATOR PRESENT AT A PUBLIC PARK|'+
						'SOR VIOLATION|'+                                                                                                                                                                                                                                                                                                                   
						'SUPPRESS INFORMATION UPON REQUEST|'+
						'VIOL OF SEX OFFENDER ACT|'+
						'VIOL OF SEXUAL OFFENDER ACT|'+
						'VIOL SEX OFFENDER ACT|'+                                                                                                                                                                                                                                                                                                          
						'VIOLATE SEX OFFENDER|'+
						'VIOLATING CONDITION OF RELEASE|'+
						'VIOLATION OF CONDITIONS OF RELEASE|'+                                                                                                                                                                                                                                                                                              
						'VIOLATION SEX OFFENDER|'+
						'VIOLATION OF PROBATION|'+
						'VIOLATION OF PROTECTIVE ORDER|'+
						'VIOLATION OF REGISTRATION|'+
						'VIOLATION OF RESIDENCY LIMIT|'+
						'VIOLATION OF SEX OFFENDER|'+
						'VOP|'+ 
						'WITHIN 500 FEET|'+ 
						'WITHIN 500 FT|'+  						
            'FEDERAL VIOLATION|'+ 
            'PROVIDING FALSE INFO TO LAW ENFORCEMENT/SEXUAL PREDATOR|'+ 
            'VIOL OF SEXUAL OFFENDER|'+ 
						'PENALTIES|'+
						
            'BAIL JUMPING|'+
						'PERJURY|'+
						'FALSE SWEARING|'+
						'FALSE PRETENSES \\(ATTEMPT\\)|'+
						'RESISTING ARREST|'+
						', FALSE PRETENSES|'+

						
						'WITHIN 500\'',
						trim(l.offense_description, left, right),
						0)<>'' => 'FAI',//'FAILURE_TO_COMPLY'

					regexfind('CRIMAL CONFEMENT|'+
						'CONFINEMENT|'+ 
						'DETENTION|'+
						'FALS.IMP.|'+
						'IMPRIS|'+ 
						'IMPRISONMENT|'+ 
						'MISPRISION|'+
						'MISPRISON|'+
						'CRIMINAL CNFINEMENT|'+

						'PERMANENT DETENTION',
						trim(l.offense_description, left, right),
						0)<>'' and 
						regexfind('MAXIMUM IMPRISON', trim(l.offense_description, left, right), 0)='' 
						=> 'FAL',//'FALSE_IMPRISONMENT'
					
					regexfind('IMPORTUN|'+
						'IMPORTUNING|'+
						'IMPRTUNING - 2907.07D2|'+
            'IMPRTUNING|'+

						'INPORTUNING',
						trim(l.offense_description, left, right),
						0)<>'' => 'IMP',//'IMPORTUNING'

					regexfind('ABUSE OF CHILD BY FAMILY MEMBER|'+
						'ABUSE/FAMILY|'+
						'ASSAULT/FAMILY|'+
						'ASSLT/FAMILY|'+
						'CRIMINAL SEXUAL ASSAULT/FAMILY|'+
						'INCEST|'+ 
						'INTERFAMILIAL SEX|'+ 
						'KIN|'+ 
						'KINDRED|'+
						'RELATIONS WITH FAMILY|'+
						'RELATIONS WITH INFAMIL|'+
						'RELATIONS WITHIN FAMILIES|'+
						'PERSON IN FAMILIAL AUTHORITY|'+
						'PROH SEXUAL CONDUCT OF COUSIN|'+
						'SEX ASLT 3 - KIN|'+ 
						'SEX RELATION WITH FAMILIES|'+ 
						'SEXUAL ABUSE AND INCEST|'+
						'SEXUAL ACTIVITY-PERSON IN FAMILIAL AUTHORITY|'+
						'SEXUAL CONDUCT OF COUSIN|'+ 
						'SEXUAL RELATIONS WITH FAMILIES|'+
						'SEXUAL RELATIONS WITH FAMY|'+
						'SEXUAL RELATIONS WITHIN FAMILIES|'+
						'VICTIM COUSIN|'+
						'VICTIM FAMILY RELATED|'+
						'VICTIM WAS FEMALE FAMILY MEMBER|'+
						'VICTIM WAS STEPDAUGHTER|'+
						'GRANDSON' 
            ,
						trim(l.offense_description, left, right),
						0)<>'' => 'INC',//'INCEST',
						
					//Exact match
					trim(l.offense_description, left, right) = 'CEST' 				=> 'INC',
					trim(l.offense_description, left, right) = 'IEST' 				=> 'INC',
					trim(l.offense_description, left, right) = 'IEST FEL' 		=> 'INC',

					regexfind('HOMICIDE|'+ 
						'MANSLAGHTER|'+                                                                                                                                                                                                                                                                                                              
						'MANSLAUGHTER|'+
						'MUDER|'+
						'MURDER|'+
						'SHOOTING WITH INTENT TO KILL',

						trim(l.offense_description, left, right),
						0)<>'' => 'MUR',//'MURDER',

				regexfind('ABUSE IMAGES|'+
						'ADVERTISE OBSCENE MATERIAL|'+ 
						'CELL PHONE PICTURE|'+
						'CHILD POR|'+
						'CHILD PRON|'+
						'CONTAINED IMAGES|'+
						'DEPICIT MINOR|'+
						'DEPICT MINOR|'+
						'DEPICT OF MINOR|'+
						'DEPICT PERSON|'+
						'DEPICTING EXPLT MINOR|'+
						'DEPICTION MINOR|'+
						'DEPICTION SEX CONDUCT|'+
						'DEPICTION OF MINOR|'+
						'DEPICTIONS OF MINOR|'+
						'DIS. IND. MATERIAL|'+
						'DISPLAY OBSCENITY|'+
						'DECEMINATE MATERIAL|'+
						'DISSEMINATE/PROMOTE OBSCENITY|'+ 
						'DISSEMINATING INDECENT MATERIAL|'+                                                                                                                                                                                                                                                                                     
						'DISSEMINATING OBSCENE MATERIAL|'+ 
						'DISSEMINATING VOYEURISTIC MATERIAL|'+
						'DISTRIBUTING AND EXHIBITING OF MATERIAL|'+
						'DISTRIBUTING MATERIALS WITH NUDITY|'+
						'DISTRIBUTION-POSSESSION OR VIEW SEXUALLY EXPLICIT|'+
						'DISTRIBUTION AND EXHIBITING OF MATERIAL|'+
						'DIST/POSS OR VIEW SEX EXPLICIT CHILD MATERIAL|'+
						'EXPLICATE MATERIAL|'+
						'EXPLICIT SEXUAL MATERIAL|'+
						'EXPLT SEX MATL|'+
						'EXPLOITATIVE MATERIAL|'+	
						'EXPLOITIVE IMAGES|'+
						'FILM/PHOTO|'+
						'FILMS DISPLAYING MINORS|'+
						'FILMING|'+ 
						'GRAPHIC IMAGE|'+
						'GRAPHIC IMAGE SHOWING SEXUAL PERFORMANCE|'+
						'HARMFUL MAT|'+
						'IMAGE OF NUDITY|'+ 
						'IMAGE OF UNCLOTHED PERSON|'+ 
						'IMAGE SHOWING SEXUAL PERFORMANCE|'+
						'INDECENT MOTION PICTURES|'+ 
						'INDECENT OR OBSCENE WRITING|'+
						'INTERSTATE TRANSPORTATION OF OBSCENE MATERIAL|'+
						'KNOWINGLY POSSESSES OR ACCESSES WITH INTENT TO VIEW ANY MATERIAL|'+
						'MAIL OBSCENE OR CRIME INCITING MATTER|'+
						'MAIL SEXUALLY EXPLICIT|'+
						'MAILING OBSCENE OR CRIME-INCITING MATTER|'+
						'MAKE/SELL/SOLICIT CHILD PORNOGRAPHY|'+	
						'MAT INV SEX EXP|'+
						'MATERIAL CONSTITUTING|'+
						'MATERIAL DEPICTING|'+
						'MATERIAL HARMFUL TO MINOR|'+
						'MATERIAL INVOL SEXUAL EXPLOIT|'+
						'MATERIAL INVOLVING SEXUAL EXPLOITATION|'+
						'MATERIALS INVOLVING SEXUAL|'+
						'MATERIAL_SEX_EXPLOIT_|'+                                                                                                                                                                                                                                                                                                 
						'MATRL INVOLV SEX EXPLOIT OF MINORS|'+
						'MATTER DEPICTING|'+		
						'MATTER PORTRAYING SEXUAL PERF|'+
						'MATTERS CONTAINING DEPICTIONS|'+
						'NUDITY ORIENTATED MATERIAL|'+ 
						'NUDITY ORIENTED MATERIAL|'+
						'NUDITY-ORIENTED MATERIAL|'+ 
						'OBS MTR|'+
						'OBSCENE MARTERIAL|'+                                                                                                                                                                                                                                                                                          
						'OBSCENE MAT|'+
						'OBSCENE MATTER DEPICTING MINOR|'+
						'OBSCENE MTR|'+
						'OBSCENEMAT|'+                                                                                                                                                                                                                                                                                                  
						'OBSENCE MAT|'+   
						'OBSENE MAT|'+
						'OBSCENE_MAIL|'+
						'OBSENITY MATERIAL|'+
						'OBSCENITY-- PROMOTION|'+
						'OBSCENITY PROMOTION|'+ 
						'OBSCENE_MATERIAL|'+                                                                                                                                                                                                                                                                                                               
						'OBSENE_MATERIAL|'+                                                                                                                                                                                                                                                                                                                
						'PANDERING OBSCENITY INVOLVING|'+
						'PANDERING SEX MATERIAL|'+
						'PANDERING SEX ORIENT MATERIAL|'+
						'PANDERING SEX ORIENTED MATERIAL|'+
						'PANDERING SEXUAL MATERIAL|'+
						'PANDERING SEXUALLY ORIENTED MATERIAL|'+
						'PANDERING SEXY MATTER|'+
						'PHOTO|'+
						'PICS OF MINORS|'+
						'PONOGRAPHY|'+
						'PORN|'+ 
						'POSING EXHIBIT CHILD IN STATE OF NUDITY|'+
						'POSING OR EXHIBITING A CHILD IN STATE OF NUDITY|'+
						'POSS DEPCT/MINORS|'+
						'POSS DEPICT OF MINOR IN SEX ECPLICIT COND|'+
						'POSS DEPICTION MINOR|'+
						'POSS DPCTNS MINOR|'+
						'POSS INVLVNG SEX EXPLOITATION|'+
						'POSS MAT|'+
						'POSS MINORS EXPLT COND|'+
						'POSS MTERIAL|'+
						'POSS MTRL|'+
						'POSS OBSCENE ITEM|'+
						'POSS OBSCENE MAT|'+
						'POSS OBSCENE MSTRT|'+
						'POSS OF CERTAIN MAT|'+
						'POSS OF MAT|'+
						'POSS OF SEXUALLY EXPL IMAGES|'+ 
						'POSS OF SEXUALLY EXPLICIT IMAGES|'+ 
						'POSS OF SEXUALLY EXPL/EXPLICIT IMAGES|'+ 
						'POSS OF VISUAL MEDIUM OF SEX EXPLOIT|'+
						'POSS ON OBSCENE SEXUAL PERFORM|'+
						'POSS PICS|'+
						'POSS SEX EXPLICIT CONDUCT|'+
						'POSS VISUAL PRESENT DEPICT SEX COND|'+
						'POSS/CONT OBSENE|'+
						'POSS/MATERIAL|'+
						'POS_VIS_PRSNT|'+
						'POSSES MAT OF MINORS ENG IN SEX EXPLICIT COND|'+ 
						'POSSESS MATERIAL|'+
						'POSSESS OR CONTROL OBSCENE|'+
						'POSSESS SEX EXPLOIT MATERIAL|'+
						'POSSESS SEXUAL PERFORMANCE CHILD|'+
						'POSSESS SEXUALLY EXPLICIT PICTURE|'+ 
						'POSSESS SEXUALLY EXPLOITATIVE MATERIAL|'+ 
						'POSSESS PHOTOGRAPH|'+
						'POSSESS/PROMOTE/PRODUCE/DIRECT/DISTRIBUTE SEXUAL PERFORM|'+
						'POSSESSING A SEXUAL PERFORM|'+	
						'POSSSESSING AN OBSCENE|'+
						'POSSESSING AN OBSCENE SEXUAL PERFORMANCE|'+	
						'POSSESSING MATERIAL|'+
						'POSSESSION AND RECEIPT OF MATERIAL|'+
						'POSSESSION OF CERATIN MATERIAL|'+
						'POSSESSION OF CHILD SEXUAL ABUSE IMAGES|'+
						'POSSESSION OF IMAGES|'+
						'POSSESSION OF MATERIAL CONTAINING|'+
						'POSSESSION OF MATERIAL DEPICTING|'+
						'POSSESSION OF MATERIAL INVOLVING|'+
						'POSSESSION OF MATERIALS CONTAINING|'+
						'POSSESSION OF MATERIALS DEPICTING|'+
						'POSSESSION OF MATERIALS VISUALLY|'+
						'POSSESSION OF MATERIALS WHICH INVOLVE|'+
						'POSSESSION OF MATTER PORTRAYING A SEXUAL PERFORMANCE|'+
						'POSSESSION OF SEXUALLY EXPLICITY DEPIC|'+
						'POSSESSION OF SEXUALLY EXPLICITY MAT|'+	
						'POSSESSION OF SEXUALLY EXPLOIT|'+
						'POSSESSION OF SEXUALLY EXPOIT|'+
						'POSSESSION OF OBSCEN MAT|'+
						'POSSESSION OF OBSCENE MATERIAL|'+
						'POSSESSION OF PROHIBITED MATERIAL|'+
						'POSSESSION OF VIS|'+
						'POSSESSION OF VISUAL MEDIUM OF SEXUAL EXPLOITATION|'+  
						'POSSESSION/SEX PERFORMANCE|'+	
						'PREP OBSCENE MATERIAL|'+	
						'PREPARE/DIST/EXHIBIT OBSCENE MATERIAL|'+                                                                                                                                                                                                                                                                                           
						'PROD/PUBL/SALE POSS|'+
						'PRODUCE DIRECT SEXUAL WITH MIN|'+
						'PRODUCE, DIRECT, PROMOTE SEXUAL PERFORM|'+
						'PRODUCING OBSCENE MATERIAL|'+ 
						'PRODUCTION, PUBLICATION, SALE, POSSESSION WITH INTENT TO DISTRIBUTE|'+
						'PROHIBITED MAT|'+
						'PROMOTE SEXUAL RECORD|'+	
						'PROMOTING OBSCENITY|'+	
						'PROMOTION OF A SEXUAL PREFORMANCE|'+ 
						'PROMOT PRON 2ND DEGREE|'+ 
						'REC MATERIAL|'+
						'RECEIVING MAIL SEX|'+
						'RECEIPT OF OBSCENITY|'+                                                                                                                                                                                                                                                                                                            
						'RECIEPT OF OBSCEN|'+
						'RECORDING OF NUDITY|'+
						'RECORD/DIST/TRANSMIT OBSCENITY|'+ 
						'SENDING, DISTRIBUTING, EXHIBITING, POSSESSING, DISPLAYING OR TRANSPORTING MATERIAL BY A PARENT|'+
						'SEX EXPLT MAT|'+
						'SEX PERF OF CHILD|'+
						'SEXUAL EXPLICIT MAT|'+
						'SEXUAL MATERIAL|'+
						'SEXUAL PERFORM|'+
						'SEXUALLY ABUSIVE MATERIAL|'+
						'SEXUALLY EXPL IMAGES|'+
						'SEXUALLY EXPL MATERIAL|'+
						'SEXUALLY EXPLICIT CHILD MATERIAL|'+
						'SEXUALLY EXPLICIT IMAGES|'+
						'SEXUALLY EXPLICIT MATERIAL|'+
						'SEXUALLY EXPLICIT VISUAL|'+
						'SEXUALLY EXPLOITATIVE MATERIAL|'+
						'SEXUALLY EXPLOITIVE MATERIAL|'+                                                                                                                                                                                                                                                                                      
						'SOLICIT/DIRECT/PROMOTE SEXUAL PERFORM|'+
						'SURREPTITIOUS PHTGRPHING|'+
						'SX MAT|'+
						'TRAFFICKING IN MATERIAL INVOLVING SEXUAL|'+ 
						'TRAFFICKING OF OBSCENE MOVIES|'+
						'TRANS DIST REPRO POSSESS VIS|'+
						'TRANSFER OF OBSCENE|'+
						'TRANSMISSION OF INFORMATION ABOUT A MINOR|'+
						'TRANSPORTING MATERIAL SEX|'+	
						'UNLAWFUL FILMING OR PHOTO|'+
						'UNLAWFUL FILMING, VIDEOTAPING, OR PHOTOGRAPHING|'+
						'UNLAWFUL VIEW/TAPE/RECORD PERSON|'+
						'VI DEPICT COMP MIN SEX EXP COND|'+
						'VIDEO|'+
						'VIDEO VOYEURISM|'+ 
						'VIDEOTAPING|'+ 
						'VIEW SEX EXPLICIT CHILD MATERIAL|'+
						'VIS DEPICT|'+
						'VIS DPCTN|'+	
						'VISL DEPICT|'+
						'VISL REP|'+
						'VISUAL DE|'+
						'VISUAL MATERIAL|'+
						'VISUAL MEDIUM|'+
						'VISUAL PRES|'+
						'VISUAL SEX|'+
						'VOYEURISTIC MATERIAL|'+
						'OHIO, DISSEMINATING MATERIAL|'+
						'1ST DEGREE DISTRIBUTION OF INDECENT MATERIAL|'+	
						'FILM SUBJECT|'+	
						'KNOWINGLY DOWNLOAD, POSSESS AND VIEW PRONOGRAPHY|'+	
						'PSSESSIN F CILD PRNGRAPHY|'+
            '3704-BSCENE MATERIAL-PSSESS FEDERAL|'+
            'BSCENE MATERIAL|'+
						'TRANSPRTATIN F BSCENE MATERIAL CMPUTERS|'+
						'PSSESSIN F BSCENE MATERIAL|'+
						'BSCENITY-PSS F PRN MATERIAL MATTER|'+
						'BSCENE MATERIALS F MINR|'+
						'BSCENE MATERIAL - EXHIBIT PRN MATERIAL T MINRS|'+
						'RECEIPT F BSENE CMPUTER IMAGE|'+
						'PSSESSIN F BSCENE MATTER|'+
						'PSSES F BSCENE MATERIAL|'+
						'RECEIPT F PRNGRAPHY|'+
						'FILM|'+


						'KNOWINGLY POSSESS'
						,	

						trim(l.offense_description, left, right),
						0)<>'' => 'POR',//'PORNOGRAPHY',

					regexfind(
						'2907.23 - PROCUR|'+
						'ATTEMPTED TRAFFICKING FOR COMMERCIAL SEX ACT|'+
						'COMPEL PROST|'+
						'FACILITATION OF SEX TOURISM - 18 U.S.C. SECTION 2423(D)|'+
						'HUMAN TRAFFIC|'+
						'PANDER|'+
						'PIMP|'+
						'PROCUREMENT OF A CHILD|'+
						'PROCUREMENT OF PERSON|'+
						'PROCUREMENT OF U-16|'+	
						'PROCURING A PERSON|'+
						'PROM PROS|'+
						'PROMOT PROST|'+
						'PROMOTE PROST|'+                                                                                                                                                                                                                                                                                                               
						'PROMOTING_PROS|'+
						'PROSITITUTION|'+                                                                                                                                                                                                                                                                                            
						'PROSTI|'+
						'PROTITUTION|'+
						'SEX TRAFFIC|'+
						'SEX_TRAFFIC|'+
						'SEXUAL TRAFFICKING|'+
						'TRAFFICING FOR SEXUAL SERV|'+
						'TRAFFICKING OF A PERSON|'+  
						'TRAFFICKING OF PERSON|'+
						'TRAFFICKING PERSON|'+
						'TRAFFICKING FOR A COMMERCIAL SEX|'+
						'TRAFFICKING FOR COMMERCIAL SEX ACT|'+
						'TRAFFICKING FOR SEXUAL SERVITUDE|'+
						'TRAFFICKING IN CHILDREN|'+
						'TRAFFICKING IN SEXUAL SERVITUDE|'+
						'FACILITATION OF SEX TOURISM - 18 U.S.C. SECTION 2423(D)|'+
						'PRCURE FR PRSTITUTE|'+
						'CMPEL PRSTITUTIN MINR|'+
						'PRMTING PRSTITUTIN F A MINR|'+
						'PRCURING PRSTUTIN F A MINR|'+
						'PRSTITUTIN - SLICITATIN 6-4-102|'+
						'PRMTING PRSTITUTIN|'+
						'ATTEMPT T PARTICIPATE IN PRSTITUTIN F A MINR|'+
						'PRCURE FR PRSTIUTE WH IS AN ADULT|'+
						'CMPELLING PRSTITUTIN BY FRCE/THREAT|'+

            'PROCURE'

						,
						trim(l.offense_description, left, right),
						0)<>'' => 'PRO',//'PROSTITUTION'

					regexfind('ADJUDICATED A SEXUAL PREDATOR|'+                                                                                                                                                                                                                                                                                         
						'ANOTHER JURISDICTION|'+
						'ANOTHER STATE|'+
						'BOARD OR COURT ORDERED/INTERSTATE COMPACT REGISTRATION|'+
						'COMMITMENT AS A SEXUALLY VIOLENT PREDATOR|'+
						'CONVICTED SEX OFFENDER|'+
						'COURT DETERMINED IN THE STATE OF|'+
						'COURT/BOARD ORDERED REGISTRATION|'+
						'COURT ORDER MANDATED|'+
						'COURT ORDER - PAROLE BOARD MANDATED|'+
						'COURT ORDERED TO REG|'+
						'DESIGNATED AS |'+
						'FL TO REG SEX OFFNDR-SPC CONDS|'+
						'INTERSTATE COMPACT REGISTRATION|'+
						'OFFENSE COMMITTED IN ANOTHER JURISDICTION|'+
						'OUT OF STATE|'+
						'OUT-OF-STATE|'+
						'REGISTER|'+
						'REGISTRA|'+
						'SEX OFFENDER REGISTRATION|'+
						'SEX OFFENDER REGISTRATRON|'+
						'SEXUAL PREDATOR DESIG|'+
            'DESIGNATED A TIER III BY WA|'+
            'DESIGNATED TIER 3 BY WI|'+
            'INTERSTATE COMPACT|'+
            'LISTED AS HIGH RISK OFFENDER PER CALIF MEGANS LAW|'+
            'PERIOD OF APPROXIMATELY 3 YEARS|'+
						'PERSONS WHO AGREE IN A PLEA AGREEMENT TO A CLASS B DESIGNATION|'+
            'DESIGNATED LEVEL III IN NY|'+
						'UT F STATE FFENSE|'+
            'LISTED AS A TIER 3 IN PENNSYLVANIA|'+

            'DESIGNATED A TIER LEVEL 3 BY NV|'+
						'DESIGNATED TIER III IN MISSISSIPPI|'+
             'DESIGNATED A TIER LEVEL 3 IN NV'

						,
						trim(l.offense_description, left, right),
						0)<>'' => 'REG',//'REGISTRATION',

					regexfind('CRIMINAL RESTRAINT|'+ 
						'FELONIOUS RESTRAINT|'+ 
						'FORCIBLE DETENTION|'+ 
						'ILLEGAL RESTRAINT|'+
						//'RESTRAINT|'+
						'UNLAW RESTRAINT|'+
						'SEX BATTERY BY RESTRAINT|'+
						'SEXUAL BATTERY BY RESTRAINT|'+
						'UNL RESTRAINT|'+
						'UNLAWFUL RESTRAINT|'+
						'UNLAWFUL_RESTRAINT',
						trim(l.offense_description, left, right),
						0)<>'' and
						regexfind('SEXUAL BATTERY INVOLVING RESTRAINED PERSON', trim(l.offense_description, left, right), 0)=''
						=> 'RES',//'RESTRAINT',

					regexfind('ROBBERY|'+ 
						'THEFT',
						trim(l.offense_description, left, right),
						0)<>'' => 'ROB',//'ROBBERY',

					regexfind('COLICITATION|'+
						'SOLIC|'+ 
						'SOLICIATION|'+
						'SOLICITATION|'+ 
						'SOLICITING|'+
						'SOLISITATION|'+
						'SOLIT PERSONS|'+
						'SLICITATIN F MINR BY ELECTRNIC MEANS|'+
						'SLICITATIN T CMMIT SDMY|'+
						'SLICITATIN T CMMIT SLICITATIN F A MINR CLASS B R C FELNY|'+
						'SLICIT A MINR THRUGH ELECTRNIC MEANS|'+
						'SLICITATIN F A MINR MISDEMEANR, CLASS D R E FELNY|'+
						'ATTEMPT SLICITATIN F A MINR - AL|'+
						'SLICITATIN F SDMY|'+
						'SLICITATIN F A MINR CLASS B R C FELNY|'+
						'SLICIT BY CMPUTER/ APPEAR|'+
						'SLICITATIN F A MINR IF MISDEMEANR R D R E FELNY|'+
						'SLICITATIN T CMMIT SLICITATIN F A MINR MISDEMEANR, CLASS D R E FELNY|'+
						'NLINE SLICITATIN F A MINR|'+
						'CRIMINAL SLICITATIN|'+
						'SLICITATIN F A MINR|'+
						'CRIMINAL SLICITATIN F A MINR|'+
						'CRIMINAL RESPNSIBILITY T CMMIT SLICITATIN F A MINR CLASS B R C FELNY|'+

						'SOLITICATION',
						trim(l.offense_description, left, right),
						0)<>'' => 'SOL',//'SOLICITATION',

					regexfind('ARRANGE/GO TO MTG/MEETING W/ MINOR|'+ 
						'COMM SYS CONT MNR|'+
						'COMM SYS CONTACT MINOR|'+
						'COMM TO FACILITATE OFF INVLNG CHILD|'+
						'COMM W/ MINOR|'+
						'COMM W/MINOR|'+
						'COMM W/MNR|'+
						'COMM W-SEX OFFENSES INVOLV CHILDREN|'+
						'COMM/COMMUNICATE W/ MINOR|'+
						'COMMUN W/MINOR|'+
						'COMMUNICATION IN WRITING|'+
						'COMMUNICATE W MINOR|'+
						'COMMUNICATE W/ MINOR|'+
						'COMMUNICATE W/MINOR|'+
						'COMMUNICATE W/MNR|'+
						'COMMUNICATE WITH A MINOR|'+
						'COMMUNICATE WITH MINOR|'+
						'COMMUNITCATE_W__MINOR|'+
						'COMMUNICATING W/ A MINOR|'+
						'COMMUNICATING WITH A MINOR|'+
						'COMMUNICATION MINOR|'+
						'COMMUNICATION SYSTEMS|'+
						'COMMUNICATIONS SYSTEM|'+
						'COMMUNICATION W/ A MINOR|'+
						'COMMUNICATION W/ MINOR|'+ 
						'COMMUNICATION W/MINOR|'+ 
						'COMMUNICATION WITH A MINOR|'+
						'COMMUNICATION WITH MINOR|'+
						'COMMUNICATION/COMMUNICATE W/ MINOR|'+  
						'CONTACT MINOR|'+ 
						'CONTACTING MINOR|'+
						'CRIM CONTACT W/ MINOR|'+
						'INDECENT COMMUNICATION|'+
						'INDECENT LANG|'+
						'INDECENT LANGUAGE TO CHILD|'+
						'INDECENT LANGUAGE TO A MIN|'+
						'INDECENT LANGUAGE TO MIN|'+
						'INDECENT LANGUAGE WITH A MINOR|'+
						'INDECENT LANGUAGE/COMM|'+
						'INDECENT LANGUAGE/COMMUNICATION|'+
						'INDECENT TELEPHONE|'+
						'INTERSTATE COMMUNIC|'+ 
						'MEETING W/ MINOR|'+
						'OBSCENE COMM|'+
						'OBSCENE MESSAGE|'+
						'OBSCENE MESSAGE/COMM|'+
						'OBSCENE COMMUNICATION|'+
						'OBSCENE MESSAGE|'+ 
						'OBSCENE MESSAGE/COMMUNICATION|'+ 
						'OBSCENE PHONE CALLS|'+  
						'SEDUCTION OF MINOR VIA PHONE|'+ 
						'TELECOMMUNICATIONS SERVICE|'+ 
						'TELEPHONE DISEM OBC MAT|'+
						'TELEPHONE DISSEMINATION OF OBSCENE MATERIAL|'+
						'TELEPHONE LINES TO CORECE A MINOR|'+
						'UNLAWFUL COMM W/ MINOR|'+ 
						'UNLAWFUL COMMUNICATION W/ MINOR|'+
						'UNLAWFUL CONTACT|'+
						'UNLAWFUL CONTACT W/ MINOR|'+
						'UNLAWFUL CONTACT WITH A MINOR|'+
						'UNLAWFUL CONTACT/COMM/TRANSACTION W/ MINOR|'+	
						'UNLAWFUL CONTACT/COMMUNICATION/TRANSACTION W/ MINOR|'+
						'UNLAWFUL TRANSACTION|'+
						'UNLAWFUL TRANSACTION OF MINOR|'+
						'UNLAWFUL TRANSACTION W/ MINOR|'+
						'UNLAWFUL TRANSACTION W/MINOR|'+
						'UNLAWFUL TRANSACTION WITH A MINOR|'+						
						'USE COMM SYS CONTACT MINOR|'+ 
						'USE COMMUNICATION SYSTEM CONTACT MINOR|'+
						'USE OF INTERNET/PHONE TO COERCE AND ENTICE A MINOR|'+
						'USE OF INTERNET/PHONE TO COERCE MINOR|'+
						'USE OF INTERSTATE COMM|'+
						'USING A COMMUNICATIONS FACILITY TO ATTEMPT TO ENTI|'+						
						'USE OF COMMUNICATION FACILITIES FOR PURPOSES OF COMMITTING A COMMERCIAL SEX ACT WITH PERSONS UNDER T|'+
            'VA023 - PROPOSE SEX BY COMP ETC. 15+Y, OFFENDER 7+YR|'+  
						'WRITING OBSCENE MATERIAL TO CHILD|'+
						'WRITING TO COMMUNICATE|'+
						'TO HIM THROUGH THE DEQUEEN POST OFFICE|'+
						'USE F CMMUNICATINS SYSTEM T CNTACT MINR|'+
            'USE F CMMUNICATIN SYSTEM T CNTACT MINR|'+
						'18USC2422B-USE F CMPUTER/TELEPHNE SYSTEM FR PURPSE F PERSUADING MINR T ENGAGE IN|'+


            'USE OF MAIL'

						,
						trim(l.offense_description, left, right),
						0)<>'' => 'UNL',//'UNLAWFUL_COMMUNICATION_MINOR',
									
					regexfind(
						'&LT;16|'+
						'&LT;18|'+
						'<2|'+
						'<3|'+
						'<4|'+
						'<5|'+
						'<6|'+
						'<7|'+
						'<8|'+
						'<9|'+
						'<10|'+
						'<11|'+
						'<12|'+
						'<13|'+
						'<14|'+
						'<15|'+
						'<16|'+
						'<17|'+
						'<18|'+
						'<_18|'+
						'12-16|'+
						'13-15|'+
						'13-16|'+
						'13-17|'+
						'13-18|'+
						'16-17|'+
						'1 YEAR OLD|'+
						'2 YEAR OLD|'+
						'3 YEAR OLD|'+
						'4 YEAR OLD|'+	
						'5 YEAR OLD|'+
						'6 YEAR OLD|'+
						'7 YEAR OLD|'+
						'8 YEAR OLD|'+
						'9 YEAR OLD|'+	
						'10 YEAR OLD|'+	
						'11 YEAR OLD|'+
						'12 YEAR OLD|'+
						'13 YEAR OLD|'+
						'14 YEAR OLD|'+
						'15 YEAR OLD|'+	
						'16 YEAR OLD|'+	
						'17 YEAR OLD|'+
						'1-YEAR-OLD|'+
						'2-YEAR-OLD|'+
						'3-YEAR-OLD|'+
						'4-YEAR-OLD|'+	
						'5-YEAR-OLD|'+
						'6-YEAR-OLD|'+
						'7-YEAR-OLD|'+
						'8-YEAR-OLD|'+
						'9-YEAR-OLD|'+	
						'10-YEAR-OLD|'+	
						'11-YEAR-OLD|'+
						'12-YEAR-OLD|'+
						'13-YEAR-OLD|'+
						'14-YEAR-OLD|'+
						'15-YEAR-OLD|'+	
						'16-YEAR-OLD|'+	
						'17-YEAR-OLD|'+
						'2 YEARS OF AGE|'+
						'3 YEARS OF AGE|'+
						'4 YEARS OF AGE|'+	
						'5 YEARS OF AGE|'+
						'6 YEARS OF AGE|'+
						'7 YEARS OF AGE|'+
						'8 YEARS OF AGE|'+
						'9 YEARS OF AGE|'+	
						'10 YEARS OF AGE|'+	
						'11 YEARS OF AGE|'+
						'12 YEARS OF AGE|'+
						'13 YEARS OF AGE|'+
						'14 YEARS OF AGE|'+
						'15 YEARS OF AGE|'+	
						'16 YEARS OF AGE|'+	
						'17 YEARS OF AGE|'+
						'2 YEARS OLD|'+
						'3 YEARS OLD|'+
						'4 YEARS OLD|'+	
						'5 YEARS OLD|'+
						'6 YEARS OLD|'+
						'7 YEARS OLD|'+
						'8 YEARS OLD|'+
						'9 YEARS OLD|'+	
						'10 YEARS OLD|'+	
						'11 YEARS OLD|'+
						'12 YEARS OLD|'+
						'13 YEARS OLD|'+
						'14 YEARS OLD|'+
						'15 YEARS OLD|'+	
						'16 YEARS OLD|'+	
						'17 YEARS OLD|'+
						'17 AND 18 YEARS OLD|'+
						'10 YR OLD|'+	
						'11 YR OLD|'+	
						'12 YR OLD|'+
						'13 YR OLD|'+
						'14 YR OLD|'+
						'15 YR OLD|'+
						'16 YR OLD|'+
						'17 YR OLD|'+	
						'ADOLESCENT|'+ 
						'AGE 1|'+
						'AGE 2|'+
						'AGE 3|'+
						'AGE 4|'+
						'AGE 5|'+
						'AGE 6|'+
						'AGE 7|'+
						'AGE 8|'+
						'AGE 9|'+
						'AGE 10|'+	
						'AGE 11|'+
						'AGE 12|'+
						'AGE 12|'+
						'AGE 13|'+
						'AGE 14|'+
						'AGE 15|'+
						'AGE 16|'+
						'AGE 17|'+
						'ANNOY MOLEST VICTIM U/18|'+
						'ANNOY__MOL_VIC_<_18|'+
						'ANNOY__MOL_VIC_&LT;18|'+
						'ANNOY__MOL_VIC_&LT;_18|'+
						'BOY|'+ 
						'CAR KNOW JUV|'+
						'CARETAKER/SEXUAL ACT ON DEPENDENT ADULT W/FORCE|'+                                                                                                                                                                                                                                                                                 
						'CARNAL KNOWLEDGE OF A JUVENILE|'+
						'CARNAL KNOWLEDGE OF JUVENILE|'+ 
						'CARNEL KNOWLEDGE|'+
						'CHID|'+
						'CHIL|'+
						'CHLD|'+
						'CHILDREN|'+ 
						'CRIMES AGAINST CHILDREN|'+
						'ELEVEN YEAR OLD|'+ 
						'ENGAGING CHILD UNDER 18 FOR SEXUAL PERFORMANCE|'+
						'ENCTICE A CHILD|'+
						'ENTICE AWAY A MIN|'+
						'ENTICE AWAY MIN|'+
						'ENTICEMENT OF CHILD|'+
						'ENTICING A CHILD FOR IMMORAL/INDECENT PURPOSES|'+ 
						'GIRL|'+ 
						'GOODWINS VICTIMS WERE A MALE AND A FEMALE BOTH UNDER THE AGE OF TWELVE|'+
						'IND BEHAVIOR W JUV|'+
						'IND BEHAVIOR W/JUV|'+
						'INDEC BEHAV W JUV|'+
						'INDEC BEHAV W/JUV|'+
						'INDECENCY W CHD CONTACT|'+
						'INDECENT BEHAVIOR W JUV|'+
						'INDECENT ACTS WITH A MINOR|'+ 
						'INDECENT ASSAULT AND BATTERY WITH A CH|'+
						'INDECENT BEAHVIOR WITH JUV|'+
						'INDECENT LIBERTIES - CHILDREN|'+ 
						'INDECENT LIBERTIES STUDENT|'+ 
						'INDECENT LIBERTY MINOR|'+ 
						'INDIVIDUAL LESS THAN 11YEARS OLD|'+
						'JEVENILE|'+
						'JUVENILE|'+ 
						'KNOWLEDGE OF JUV|'+
						'KNOWLWDGE OF JUV|'+
						'LESS THAN|'+ 
						'MIN ENG IN EXP CONDUCT|'+
						'MINOE|'+ 
						'MINOR|'+ 
						'MNR|'+
						'MONIR|'+
						'MOLEST V12/15/|'+
						'MONOR|'+
						'ON PERSON 14|'+
						'ORAL BY 15YR ON ADULT|'+
						'SEX_<_16|'+
						'SEX CONTCT W/STU BY EMPL-SCH PROP|'+
						'PARENTAL ROLE|'+
						'PEDOPHILIA|'+
						'PENETRATION ON VICTIM <|'+
						'PENETRATION ON VICTIM &LT;|'+                                                                                                                                                                                                                                                                                         
						'PERSON 12 TO 15|'+
						'PERSON OVER 14|'+
						'PERSON OVER 12|'+
						'PERSON OVER 16|'+
						'PROMOTING CLD ABUSE|'+
						'PUPIL|'+ 
						'SEX ABUSE BY CUSTOD|'+	
						'SEX ABUSE BY GUARDIAN|'+	
						'SEX ABUSE BY PARENT|'+	
						'SEX ABUSE BY PARENT/GUARDIAN/CUSTODIAN/CUSTODIAL/POSITION OF TRUST|'+
						'SEX_PEN_W_FOREIGN_OBJ_<16|'+
						'SEX WITH 14 YR OLD|'+
						'SEX_<_16|'+
						'SEX_&LT;_16|'+
						'SEXUAL ABUSE BY CUSTOD|'+	
						'SEXUAL ABUSE BY GUARDIAN|'+	
						'SEXUAL ABUSE BY PARENT|'+
						'SEXUAL ABUSE BY PARENT/GUARDIAN/CUSTODIAN/CUSTODIAL/POSITION OF TRUST|'+ 
						'SEXUAL ACTIVITY BY SUBSTITUTE BY PARENT|'+                                                                                                                                                                                                                                                                                         
						'SEXUAL ACTIVITY BY SUBSTITUTE PARENT|'+ 
						'SEXUAL BATTERY BY FAMILIAL|'+  
						'SEXUAL TERCOURSE WITH MOR|'+
						'STUDENT|'+ 
						'SUBJECT SEXUALLY ABUSED FOUR FEMALE VICTIMS, AGES 4, 6, 8, AND 10. SUBJECT ALSO CONVICTED ON 12/28/2|'+                                                                                                                                                                                                                            
            'SUBJECT SEXUALLY ABUSED TWO FEMALE VICTIMS, AGES 6 AND 7.|'+                                                                                                                                                                                                                                                                       
            'SUBJECT SEXUALLY ABUSED TWO FEMALE VICTIMS, AGES 7 AND 13.|'+                                                                                                                                                                                                                                                                        
            'SUBJECT SEXUALLY ABUSED TWO FEMALE VICTIMS, AGES 8 AND 9.|'+ 
						'TEEN|'+
						'TOUCHED VAGINA OF FRIEND\'S DAUGHTER|'+	
						'U 2|'+	
						'U 3|'+
						'U 4|'+
						'U 5|'+
						'U 6|'+
						'U 7|'+
						'U 8|'+
						'U 9|'+
						'U 10|'+
						'U 11|'+ 
						'U 12|'+	
						'U 13|'+
						'U 14|'+
						'U 15|'+
						'U 16|'+
						'U 17|'+
						'U 18|'+
						'U2|'+	
						'U3|'+
						'U4|'+
						'U5|'+
						'U6|'+
						'U7|'+
						'U8|'+
						'U9|'+
						'U10|'+
						'U11|'+ 
						'U12|'+	
						'U13|'+
						'U14|'+
						'U15|'+
						'U16|'+
						'U17|'+
						'U18|'+
						'U-2|'+	
						'U-3|'+
						'U-4|'+
						'U-5|'+
						'U-6|'+
						'U-7|'+
						'U-8|'+
						'U-9|'+
						'U-10|'+
						'U-11|'+ 
						'U-12|'+	
						'U-13|'+
						'U-14|'+
						'U-15|'+
						'U-16|'+
						'U-17|'+
						'U-18|'+
						'UND 16|'+
						'UNDER 1|'+ 
						'UNDER 2|'+	
						'UNDER 3|'+
						'UNDER 4|'+
						'UNDER 5|'+
						'UNDER 6|'+
						'UNDER 7|'+
						'UNDER 8|'+
						'UNDER 9|'+
						'UNDER 10|'+
						'UNDER 11|'+ 
						'UNDER 12|'+	
						'UNDER 13|'+
						'UNDER 14|'+
						'UNDER 15|'+
						'UNDER 16|'+
						'UNDER 17|'+
						'UNDER 18|'+
						'UNDER AGE|'+ 
						'UNDER THIRTEEN|'+
						'UNDER_1|'+ 
						'UNDER_2|'+	
						'UNDER_3|'+
						'UNDER_4|'+
						'UNDER_5|'+
						'UNDER_6|'+
						'UNDER_7|'+
						'UNDER_8|'+
						'UNDER_9|'+
						'UNDER_10|'+
						'UNDER_11|'+ 
						'UNDER_12|'+	
						'UNDER_13|'+
						'UNDER_14|'+
						'UNDER_15|'+
						'UNDER_16|'+
						'UNDER_17|'+
						'UNDER_18|'+
						'UNDER/14|'+ 
						'UNDERAGE|'+ 
						'UNLAW SEX COND/16 OR 17YO|'+
						//VIC |'+#-#|'+ OR VIC|'+#-#|'+ [WHERE SECOND NUMBER IS LESS THAN 18]|'+ 
						'VIC1|'+
						'VIC2|'+
						'VIC3|'+
						'VIC4|'+
						'VIC5|'+
						'VIC6|'+
						'VIC7|'+
						'VIC8|'+
						'VIC9|'+
						'VIC10|'+	
						'VIC11|'+
						'VIC12|'+
						'VIC13|'+
						'VIC14|'+
						'VIC15|'+
						'VIC16|'+
						'VIC17|'+						
						'VIC 1|'+
						'VIC 2|'+
						'VIC 3|'+
						'VIC 4|'+
						'VIC 5|'+
						'VIC 6|'+
						'VIC 7|'+
						'VIC 8|'+
						'VIC 9|'+
						'VIC 10|'+	
						'VIC 11|'+
						'VIC 12|'+
						'VIC 13|'+
						'VIC 14|'+
						'VIC 15|'+
						'VIC 16|'+
						'VIC 17|'+
						'VIC>1|'+
						'VIC>2|'+
						'VIC>3|'+
						'VIC>4|'+
						'VIC>5|'+
						'VIC>6|'+
						'VIC>7|'+
						'VIC>8|'+
						'VIC>9|'+
						'VIC>10|'+	
						'VIC>11|'+
						'VIC>12|'+
						'VIC>13|'+
						'VIC>14|'+
						'VIC>15|'+
						'VIC>16|'+
						'VIC>17|'+
						'VICIM 10|'+
						'VICTIM <1|'+
						'VICTIM <2|'+
						'VICTIM <3|'+
						'VICTIM <4|'+
						'VICTIM <5|'+
						'VICTIM <6|'+
						'VICTIM <7|'+
						'VICTIM <8|'+
						'VICTIM <9|'+
						'VICTIM <10|'+
						'VICTIM <11|'+
						'VICTIM <12|'+
						'VICTIM <13|'+
						'VICTIM <14|'+
						'VICTIM <15|'+
						'VICTIM <16|'+
						'VICTIM <17|'+
						'VICTIM 1|'+
						'VICTIM 2|'+
						'VICTIM 3|'+
						'VICTIM 4|'+
						'VICTIM 5|'+
						'VICTIM 6|'+
						'VICTIM 7|'+
						'VICTIM 8|'+
						'VICTIM 9|'+
						'VICTIM 10|'+
						'VICTIM 11|'+
						'VICTIM 12|'+
						'VICTIM 13|'+
						'VICTIM 14|'+
						'VICTIM 15|'+
						'VICTIM 16|'+
						'VICTIM 17|'+
						'VICTIM LESS THAN 12|'+
						'VICTIM LESS THAN 17|'+
						'VICTIM OVER 12|'+
						'VICTIM OVER 13|'+
						'VICTIM FEMALE , FL794.011|'+						
            'VCITIM WAS A NINE YEAR OLD FEMALE|'+
						'VCITIM WAS A TWELVE YEAR OLD FEMALE|'+
						'VCTIM WAS A SEVEN YEAR OLD FEMALE|'+
						'VCTIM WAS A SIX YEAR OLD FEMALE|'+
						'VCTIM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICITIM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICITM WAS A FEMALE UNDER THE AGE OF TWELVE|'+
						'VICITM WAS A NINE YEAR OLD FEMALE|'+
						'VICITM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICITM WAS AN EIGHT YEAR OLD FEMALE|'+
						'VICTIIM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICTIM AS A NINE YEAR OLD FEMALE|'+
						'VICTIM AS A SIX YEAR OLD FEMALE|'+
						'VICTIM IS A SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A 6 YR OLD FEMALE.|'+
						'VICTIM WAS A AN EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS A EIGHT OLD FEMALE|'+
						'VICTIM WAS A EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS A EIGHT YEAR OLD FEMALE.|'+
						'VICTIM WAS A EIGHT YEAR OLD MALE|'+
						'VICTIM WAS A EIGHT YEAR OLD MALE.|'+
						'VICTIM WAS A EIGHTYEAR OLD FEMALE|'+
						'VICTIM WAS A FEMALE AGE SIX|'+
						'VICTIM WAS A FEMALE BETWEEN THE AGE OF TEN AND TWELVE|'+
						'VICTIM WAS A FEMALE BETWEEN THE AGES OF EIGHT AND TEN|'+
						'VICTIM WAS A FEMALE FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A FEMALE LESS THEN TWELVE|'+
						'VICTIM WAS A FEMALE UNDER THE AGE OF 13|'+
						'VICTIM WAS A FEMALE UNDER THE AGE OF SIX|'+
						'VICTIM WAS A FEMALE UNDER THE AGE OF TWELVE|'+
						'VICTIM WAS A FEMALE UNDER TWELVE|'+
						'VICTIM WAS A FIFTEEEN YEAR OLD FEMALE|'+
						'VICTIM WAS A FIFTEEEN YEAR OLD MALE|'+
						'VICTIM WAS A FIVE AND TEN YEAR OLD FEMALE|'+
						'VICTIM WAS A FIVE YEAR FEMALE|'+
						'VICTIM WAS A FIVE YEAR OLD|'+
						'VICTIM WAS A FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A FIVE YEAR OLD FEMALE.|'+
						'VICTIM WAS A FIVE YEAR OLD FEMMALE|'+
						'VICTIM WAS A FIVE YEAR OLD MALE|'+
						'VICTIM WAS A FOUR AND SIX OLD FEMALE.|'+
						'VICTIM WAS A FOUR YEAR FEMALE|'+
						'VICTIM WAS A FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A FOUR YEAR OLD FEMALE.|'+
						'VICTIM WAS A FOUR YEAR OLD MALE|'+
						'VICTIM WAS A FOUR YEAR OLD MALE.|'+
						'VICTIM WAS A FOUREEN YEAR OLD FEMALE|'+
						'VICTIM WAS A MALE UNDER THE AGE OF 14.|'+
						'VICTIM WAS A MALE UNDER THE AGE OF TWELVE|'+
						'VICTIM WAS A NINE YEAR OLD|'+
						'VICTIM WAS A NINE YEAR OLD FEMALE|'+
						'VICTIM WAS A NINE YEAR OLD FEMALE AND A TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A NINE YEAR OLD FEMALE.|'+
						'VICTIM WAS A NINE YEAR OLD MALE|'+
						'VICTIM WAS A NINE YER OLD FEMALE|'+
						'VICTIM WAS A ONE YEAR OLD FEMALE|'+
						'VICTIM WAS A ONE YEAR OLD FEMALE.|'+
						'VICTIM WAS A SEVEN YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVEN YEAR OLD FEMALE AND A NINE YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVEN YEAR OLD FEMALE.|'+
						'VICTIM WAS A SEVEN YEAR OLD FEMLAE|'+
						'VICTIM WAS A SEVEN YEAR OLD MALE|'+
						'VICTIM WAS A SEVEN YEAR OLD MALE AND NINE YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVEN YEAR OLD MALE.|'+
						'VICTIM WAS A SIX MONTH OLD FEMALE|'+
						'VICTIM WAS A SIX MONTH OLD MALE|'+
						'VICTIM WAS A SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A SIX YEAR OLD FEMALE, AND AN EIGHT YEAR OLD MALE   |'+                                                                                                                                                                                                                                                                 
						'VICTIM WAS A SIX YEAR OLD FEMALE.|'+
						'VICTIM WAS A SIX YEAR OLD MALE|'+
						'VICTIM WAS A TEN YEAR OLD|'+
						'VICTIM WAS A TEN YEAR OLD FEMALE|'+
						'VICTIM WAS A TEN YEAR OLD FEMALE.|'+
						'VICTIM WAS A TEN YEAR OLD MALE|'+
						'VICTIM WAS A TEN YEAR OLD WHITE FEMALE|'+
						'VICTIM WAS A THREE YEAR OLD AND A FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A THREE YEAR OLD FEMALE|'+
						'VICTIM WAS A THREE YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A THREE YEAR OLD FEMALE AND FIVE YEAR OLD MALE|'+
						'VICTIM WAS A THREE YEAR OLD FEMALE.|'+
						'VICTIM WAS A THREE YEAR OLD MALE|'+
						'VICTIM WAS A THREE YEAR OLD MALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A THREE YEAR OLD MALE.|'+
						'VICTIM WAS A TWELVE YEAR MALE|'+
						'VICTIM WAS A TWELVE YEAR OLD|'+
						'VICTIM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWELVE YEAR OLD FEMALE.|'+
						'VICTIM WAS A TWELVE YEAR OLD MALE|'+
						'VICTIM WAS A TWELVE YEAR OLD MALE AND FEMALE|'+
						'VICTIM WAS A TWELVE YEAR OLD MALE.|'+
						'VICTIM WAS A TWELVE YEAR OR OLDER FEMALE|'+
						'VICTIM WAS A TWELVE YEAR YEAR OLD FEMALE|'+
						'VICTIM WAS A TWELVE YR OLD FEMALE|'+
						'VICTIM WAS A TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A TWO YEAR OLD MALE|'+
						'VICTIM WAS AN EIGHT AND TEN YEAR OLD FEMALE|'+
						'VICTIM WAS AN EIGHT YEAR FEMALE|'+
						'VICTIM WAS AN EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS AN EIGHT YEAR OLD FEMALE.|'+
						'VICTIM WAS AN EIGHT YEAR OLD MALE|'+
						'VICTIM WAS AN EIGHT YEAR OLD MALE.|'+
						'VICTIM WAS AN EIGHT YEAR OLE FEMALE|'+
						'VICTIM WAS AN ELEVEN|'+
						'VICTIM WAS AN ELEVEN YEAR FEMALE|'+
						'VICTIM WAS AN ELEVEN YEAR MALE|'+
						'VICTIM WAS AN NINE YEAR OLD FEMALE|'+
						'VICTIM WAS AN NINE YEAR OLD MALE|'+
						'VICTIM WAS AN SEVEN YEAR OLD FEMALE|'+
						'VICTIM WAS AN SIX YEAR OLD FEMALE|'+
						'VICTIM WAS AN TEN YEAR OLD FEMALE|'+
						'VICTIM WAS AN TEN YEAR OLD MALE|'+
						'VICTIM WAS AN TWELVE YEAR OLD FEMALE|'+
						'VICTIM WAS EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS FEMALE AGE TWELVE|'+
						'VICTIM WAS FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS FOUR YEAR OLD MALE|'+
						'VICTIM WAS NINE YEARS OLD.|'+
						'VICTIM WAS S FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS SEVEN YEAR OLD FEMALE|'+
						'VICTIM WAS SIX YEAR OLD FEMALE|'+
						'VICTIM WAS TEN YEAR OLD FEMALE|'+
						'VICTIM WAS TWELVE YEAR OLD FEMALE|'+
						'VICTIM WAS UNDER THE AGE OF TWELVE|'+
						'VICTIM WAS WAS A SIX YEAR OLD FEMALE|'+
						'VICTIM WERE A TEN YEAR OLD MALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIM WERE A THREE YEAR OLD MALE, A FIVE YEAR OLD MALE AND A FEMALE|'+                                                                                                                                                                                                                                                        
						'VICTIM WERE TWO FEMALES, AGED NINE AND TEN.|'+                                                                                                                                                                                                                                                                                     
						'VICTIM WERE TWO, SEVEN AND NINE YEAR OLD FEMALES|'+                                                                                                                                                                                                                                                                              
						'VICTIMS WAS A FOUR YEAR OLD FEMALE|'+
						'VICTIMS WAS A SIX YEAR OLD FEMALE|'+
						'VICTIMS WAS A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WAS A TWELVE YEAR OLD MALE|'+
						'VICTIMS WERE A FEMALE UNDER THE AGE OF TWELVE AND AN ADULT FEMALE.|'+
						'VICTIMS WERE A FIVE AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE AND A TEN YEAR OLD MALE|'+
						'VICTIMS WERE A FIVE AND SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE AND TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD FEMALE AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD FEMALE AND A THREE YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND A FOUR YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND A NINE YEAR OLD MALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND A SEVEN YEAR OLD MALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND A THREE YEAR OLD FEMALE|'+
						'VICTIMS WERE A FIVE YEAR OLD MALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR AND A SIX YEAR OLD MALE|'+
						'VICTIMS WERE A FOUR AND EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR AND FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR YEAR OLD AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR YEAR OLD FEMALE AND A SIX YEAR OLD MALE|'+
						'VICTIMS WERE A FOUR YEAR OLD FEMALE AND A TWO YEAR OLD MALE.|'+
						'VICTIMS WERE A FOUR YEAR OLD MALE AND A FIVE YEAR OLD MALE|'+
						'VICTIMS WERE A FOUR YEAR OLD MALE AND A ONE YEAR OLD FEMALE.|'+
						'VICTIMS WERE A FOUR YEAR OLD MALE AND A SEVEN YEAR OLD MALE|'+
						'VICTIMS WERE A FOUR YEAR OLD MALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A FOUR YEAR OLD MALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE AND TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE AND TEN YEAR OLD FEMALE.|'+
						'VICTIMS WERE A NINE YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE YEAR OLD FEMALE AND A TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE YEAR OLD FEMALE AND AN FEMALE YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE YEAR OLD MALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A NINE YEAR OLD MALE AND A TEN YEAR OLD MALE|'+
						'VICTIMS WERE A ONE YEAR OLD FEMALE AND A THREE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN AND A TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE A SEVEN AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN AND FIVE YEAR OLD MALE AND FEMALE|'+
						'VICTIMS WERE A SEVEN AND TEN YEAR OLD MALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD & A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND A FOUR YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND A NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND A NINE YEAR OLD MALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND A TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE AND THREE EIGHT YEAR OLD FEMALES|'+
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE, A FOUR YEAR OLD MALE AND A FOUR YEAR OLD FEMALE|'+                                                                                                                                                                                                                                           
						'VICTIMS WERE A SEVEN YEAR OLD FEMALE, A NINE YEAR OLD MALE, A FOUR YEAR OLD FEMALE, A NINE YEAR OLD|'+                                                                                                                                                                                                                            
						'VICTIMS WERE A SEVEN YEAR OLD MALE AND A NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD MALE AND A NINE YEAR OLD FEMALE.|'+
						'VICTIMS WERE A SEVEN YEAR OLD MALE AND A NINE YEAR OLD MALE|'+
						'VICTIMS WERE A SEVEN YEAR OLD MALE AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX AND A THREE YEAR OLD FEMALES|'+
						'VICTIMS WERE A SIX AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX AND AN EIGHT YEAR OLD MALE|'+
						'VICTIMS WERE A SIX AND EIGHT YEAR OLD FEMALES|'+
						'VICTIMS WERE A SIX AND NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX AND SEVEN YEAR OLD MALE|'+
						'VICTIMS WERE A SIX AND TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE A SIX YEAR FEMALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE AND A NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE AND A SEVEN YEAR OLD MALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE AND A TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD FEMALE, AN EIGHT YEAR OLD FEMALE, AND A TEN YEAR OLD FEMALE|'+                                                                                                                                                                                                                                        
						'VICTIMS WERE A SIX YEAR OLD MALE AND A NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A SIX YEAR OLD MALE AND A SEVEN YEAR OLD FEMALE.|'+
						'VICTIMS WERE A SIX YEAR OLD MALE AND A TWELVE YEAR OLD MALE|'+
						'VICTIMS WERE A SIX YEAR OLD MALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN AND AND TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN AND NINE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN AND TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN YEAR OLD FEMALE AND A THREE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN YEAR OLD FEMALE AND A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN YEAR OLD FEMALE AND AN EIGHT YEAR OLD MALE|'+
						'VICTIMS WERE A TEN YEAR OLD FEMALE, NINE YEAR OLD FEMALE AND A SEVEN YEAR OLD FEMALE|'+                                                                                                                                                                                                                                            
						'VICTIMS WERE A TEN YEAR OLD MALE & THREE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TEN YEAR OLD MALE AND A TWELVE YEAR OLD MALE|'+
						'VICTIMS WERE A TEN YEAR OLD MALE, NINE YEAR OLD MALE, EIGHT YEAR OLD MALE, AND A FIVE YEAR OLD FEMAL|'+                                                                                                                                                                                                                            
						'VICTIMS WERE A THREE AND FIVE YEAR OLD FEMALES|'+
						'VICTIMS WERE A THREE AND FIVE YEAR OLD MALE|'+
						'VICTIMS WERE A THREE YEAR OLD FEMALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A THREE YEAR OLD FEMALE AND A FIVE YEAR OLD MALE|'+
						'VICTIMS WERE A THREE YEAR OLD FEMALE AND A SIX YEAR OLD FEMALE|'+
						'VICTIMS WERE A THREE YEAR OLD FEMALE AND FOUR YEAR OLD MALE|'+
						'VICTIMS WERE A THREE YEAR OLD FEMALE, A FOUR YEAR OLD FEMALE, AND A SEVEN YEAR OLD MALE|'+                                                                                                                                                                                                                                         
						'VICTIMS WERE A THREE YEAR OLD MALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE A THREE,SEVEN AND TEN YEAR OLD FEMALES|'+                                                                                                                                                                                                                                                                             
						'VICTIMS WERE A TWELVE AND TWENTY YEAR OLD FEMALES|'+
						'VICTIMS WERE A TWELVE YEAR OLD MALE AND A FIVE YEAR OLD MALE|'+
						'VICTIMS WERE A TWELVE YEAR OLD MALE AND TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE A TWO AND A THREE YEAR OLD MALE|'+
						'VICTIMS WERE A TWO YEAR OLD FEMALE AND A FOUR YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT AND A TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT AND TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A FOUR YEAR OLD MALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A NINE YEAR OLD MALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A TEN YEAR OLD MALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD FEMALE AND A TWO YEAR OLD FEMALE|'+
						'VICTIMS WERE AN EIGHT YEAR OLD MALE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE AN ELEVEN & A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE AN ELEVEN AND A TWELVE YEAR OLD FEMALE|'+
						'VICTIMS WERE AN ELEVEN AND TWELVE YEAR OLD MALE|'+
						'VICTIMS WERE EIGHT AND TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE ELEVEN & TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE ELEVEN AND THREE YEAR OLD FEMALES|'+
						'VICTIMS WERE ELEVEN AND TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE ELEVEN AND TWELVE YEAR OLD FEMALES.|'+
						'VICTIMS WERE FEMALE AGE SEVEN AND A TEN|'+
						'VICTIMS WERE FEMALE AGES FIVE AND SEVEN|'+
						'VICTIMS WERE FEMALES AGED EIGHT YEARS OLD AND TWELVE YEARS OLD|'+
						'VICTIMS WERE FEMALES AGED TEN AND ELEVEN YEARS OLD|'+
						'VICTIMS WERE FEMALES AGES EIGHT AND ELEVEN|'+
						'VICTIMS WERE FEMALES AGES FIVE AND ELEVEN|'+
						'VICTIMS WERE FEMALES AGES FOUR, FIVE AND SEVEN|'+                                                                                                                                                                                                                                                                                  
						'VICTIMS WERE FEMALES AGES NINE AND TEN AND ELEVEN|'+
						'VICTIMS WERE FEMALES AGES SEVEN AND TEN|'+
						'VICTIMS WERE FEMALES AGES SEVEN AND TWELVE YEARS OLD|'+
						'VICTIMS WERE FEMALES AGES SIX AND EIGHT|'+
						'VICTIMS WERE FEMALES AGES SIX AND SEVEN YEARS OLD|'+
						'VICTIMS WERE FEMALES AGES SIX AND TEN|'+
						'VICTIMS WERE FEMALES AND MALES, AGES THREE AND SEVEN|'+                                                                                                                                                                                                                                                                            
						'VICTIMS WERE FEMALES RANGING IN AGE FROM SEVEN TO TWELVE YEARS OLD|'+
						'VICTIMS WERE FEMALES UNDER THE AGE OF ELEVEN|'+
						'VICTIMS WERE FEMALES UNDER THE AGE OF TWELVE|'+
						'VICTIMS WERE FIVE AND EIGHT YEAR OLD FEMALES|'+
						'VICTIMS WERE FIVE AND SEVEN YEAR OLD FEMALES|'+
						'VICTIMS WERE FIVE AND SIX YEAR OLD FEMALES|'+
						'VICTIMS WERE FIVE AND SIX YEAR OLD MALES|'+
						'VICTIMS WERE FIVE MALES UNDER THE AGE OF TWELVE|'+
						'VICTIMS WERE FIVE YEAR OLD AND A SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE FOUR AND FIVE YEAR OLD FEMALES|'+
						'VICTIMS WERE FOUR AND NINE YEAR OLD MALES|'+
						'VICTIMS WERE FOUR FEMALES AGES FOUR, SEVEN,EIGHT, AND ELEVEN YEARS OLD|'+                                                                                                                                                                                                                                                          
						'VICTIMS WERE FOUR YEAR OLD FEMALES|'+
						'VICTIMS WERE MALE AGES SEVEN AND EIGHT|'+
						'VICTIMS WERE MALE AND FEMALE UNDER THE AGE OF TEN|'+
						'VICTIMS WERE MALES AGES FIVE AND SIX|'+
						'VICTIMS WERE MALES AGES SEVEN AND EIGHT|'+
						'VICTIMS WERE MALES UNDER THE AGE OF TWELVE|'+
						'VICTIMS WERE MALES, AGES SEVEN THROUGH ELEVEN|'+                                                                                                                                                                                                                                                                                   
						'VICTIMS WERE MALES, AGES THREE, FIVE, SIX AND NINE|'+                                                                                                                                                                                                                                                                              
						'VICTIMS WERE NINE AND FOUR YEAR OLD FEMALES.|'+
						'VICTIMS WERE NINE AND SIX YEAR OLD MALES|'+
						'VICTIMS WERE NINE AND TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE NINE AND TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE NINE AND TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE NINE, TEN AND TWELVE YEAR OLD FEMALES|'+                                                                                                                                                                                                                                                                              
						'VICTIMS WERE NINE,TEN,ELEVEN AND TWELVE YEAR OLD FEMALES|'+                                                                                                                                                                                                                                                                        
						'VICTIMS WERE SEVEN AND EIGHT YEAR OLD FEMALES|'+
						'VICTIMS WERE SEVEN AND NINE YEAR OLD FEMALES.|'+
						'VICTIMS WERE SEVEN AND TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE SEVEN YEAR OLD FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIMS WERE SEVEN, ELEVEN AND TWELVE YEAR OLD MALES|'+                                                                                                                                                                                                                                                                            
						'VICTIMS WERE SIX & SEVEN YEAR OLD MALES|'+
						'VICTIMS WERE SIX AND EIGHT YEAR OLD FEMALES|'+
						'VICTIMS WERE SIX AND NINE YEAR OLD FEMALES|'+
						'VICTIMS WERE SIX AND SEVEN YEAR OLD FEMALES|'+
						'VICTIMS WERE SIX AND TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE SIX, EIGHT AND TEN YEAR OLD FEMALES|'+                                                                                                                                                                                                                                                                                
						'VICTIMS WERE TEN AND NINE YEAR OLD FEMALES|'+
						'VICTIMS WERE TEN AND TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE TEN AND TWELVE YEAR OLD FEMALES.|'+
						'VICTIMS WERE TEN YEAR OLD FEMALES|'+
						'VICTIMS WERE THREE AND FOUR YEAR OLD FEMALES|'+
						'VICTIMS WERE THREE AND SIX YEAR OLD FEMALES|'+
						'VICTIMS WERE TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE TWO EIGHT YEAR OLD FEMALES AND ONE TEN YEAR OLD FEMALE|'+
						'VICTIMS WERE TWO FEMALES AGED NINE AND TEN YEARS OLD|'+
						'VICTIMS WERE TWO FEMALES AGED NINE AND TWELVE YEARS OLD|'+
						'VICTIMS WERE TWO FEMALES AGED SIX AND SEVEN YEARS OLD|'+
						'VICTIMS WERE TWO FEMALES AGED TEN AND ELEVEN YEARS OLD|'+
						'VICTIMS WERE TWO FEMALES AGES SEVEN AND NINE|'+
						'VICTIMS WERE TWO FEMALES UNDER THE AGE OF TEN|'+
						'VICTIMS WERE TWO FEMALES UNDER THE AGE OF TWELVE|'+
						'VICTIMS WERE TWO FEMALES UNDER THE AGE OF TWELVE.|'+
						'VICTIMS WERE TWO FEMALES, AGES 9 AND 10|'+                                                                                                                                                                                                                                                                                     
						'VICTIMS WERE TWO FOUR YEAR OLD FEMALES|'+
						'VICTIMS WERE TWO MALES AGES TEN AND TWELVE YEARS OLD|'+
						'VICTIMS WERE TWO MALES AGES THREE AND FIVE YEARS OLD|'+
						'VICTIMS WERE TWO MALES AND TWO FEMALES AGES THREE,FOUR,NINE AND TEN|'+                                                                                                                                                                                                                                                             
						'VICTIMS WERE TWO MALES UNDER THE AGE OF TWELVE|'+
						'VICTIMS WERE TWO MALES, AGES FOUR AND FIVE|'+                                                                                                                                                                                                                                                                                
						'VICTIMS WERE TWO SEVEN YEAR OLD MALES AND AN EIGHT YEAR OLD MALE|'+
						'VICTIMS WERE TWO SIX YEAR OLD FEMALES|'+
						'VICTIMS WERE TWO TEN YEAR OLDS AND ONE SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE TWO TWELVE YEAR OLD FEMALES|'+
						'VICTIMS WERE TWO TWELVE YEAR OLD MALES.|'+
						'VICTIMS WERE TWO YEAR OLD FEMALE AND A FIVE YEAR OLD FEMALE.|'+
						'VICTIMS WERE UNDER THE AGE OF TWELVE|'+
						'VICTM WAS A FIVE YEAR OLD MALE|'+
						'VICTM WAS A SEVEN YEAR OLD FEMALE|'+
						'VICTM WAS A TWELVE YEAR OLD FEMALE|'+
						'VICTRIM WAS AN EIGHT YEAR OLD FEMALE|'+
						'VICTIM, OVER 12|'+
						'W/MIN|'+
						'W/MNR|'+
						'WARD|'+ 
						'YEARS OF AGE|'+ 
						'YOA|'+ 
						'YOUNGER THAN|'+ 
						'YOUTH|'+ 
						'>14 BUT <|'+ 
						'CALIFORNIA CONVICTION INVOLVING A 5 YR OLD FEMALE|'+ 
						'CONVICTED IN THE STATE OF IOWA FOR SEXUALLY ABUSING THREE MALE VICTIMS, AGES 5, 11, AND 15. SUBJECT|'+ 
						'GUARDIAN|'+ 
						'L/L MOLEST V12-15- OFF 18+|'+ 
						'FNDLING F MINR|'+
						'USE F MINR FR BSCENE PURPSES|'+
						'USE F A MINR IN PRDUCING PRNAGRAPHY|'+
						'2907.323A3/ILLEGAL USE F A MINR IN NUDITY RIENTED MATERIAL R PERFRMANCE|'+
						'USE F MINRS FR BSCENE MATERIAL R EXHIBITIN|'+
						'USE F MINRS FR BSCENE PURPSES|'+
						'INDECENCY WITH A MNIR|'+
						'INDECENCY WITH A MINR|'+
						'INDECENT A&B N PERSN 14 R VER|'+
						'LUID ACTS N MINR|'+
						'RISK F INJURY T A MINR - 53-212|'+
						'L/L MLEST V12-15- FF 18+|'+
						'CARNAL KNWLEDGE F A MINR|'+
						'IDECENT ACTS N A MINR|'+
						'ATTEMPTING T LURE A MINR BY ELECTRNIC MEANS|'+
						'INTICING A MINR FR IMMRAL PURPSES UNDER THE AGE F 18|'+
						'IND. LIBERTIES WITH A MINR|'+
						'PERMITTING ABUSE F MINR|'+
						'USE F A MINR FR BSCENE PURPSES|'+
						'RISK F INJURY T A MINR|'+
						'2005 MLESTATIN F A MINR|'+
						'MLESTATIN F A MINR|'+
						'ATTEMPTED USE F MINRS FR BSENE PURPSES|'+
						'INDESCENT LIBERTIES WITH A MINR|'+
						'UNDER/16 MIAMI DADE FL;|'+

						'WITH A 10, 13 AND 14 Y/O FEMALE' 											
						,
						
						
						trim(l.offense_description, left, right),
						0)<>'' => 'SAM',//'SEXUAL_ASSAULT_MINOR',
					
					regexfind('2ND DEGREE KIDNPPING|'+
						'ABDUCT|'+
						'ABDUCTED|'+ 
						'ABDUCTION|'+ 
						'ABDUTION|'+
						'CHILD LURING|'+ 
						'CHILD STEALING|'+ 
						'COERCING OR ENTICING TRAVEL|'+
						'FOREIGN TRAVEL-TO ILLICIT SEX ACTS|'+
						'INTER COMM|'+
						'INTER TRAVEL ENGAGE IN SEX W M|'+
						'INTERSATE TRAVEL|'+
						'INTERSTATE COMMERCE|'+
						'INTERSTATE TRANSPORT|'+ 
						'INTERSTATE TRANSPORTATION|'+ 
						'INTERSTATE TRAVEL|'+
						'KIDDNAPP|'+                                                                                                                                                                                                                                                                                                             
						'KIDNAP|'+ 
						'KIDNAPPING|'+
						'KIPNAP|'+
						'LURE CHILD|'+
						'LURING A CHILD|'+ 
						'LURING MINOR|'+
						'MEANS OF INTERSTATE|'+
						'OBTAIN A PERSON|'+
						'OFFENDER AND AN ACCOMPLICE HELD TWO VICTIMS \\(ADULT MALE AND 8 YEAR-OLD MALE\\) AGAINST THEIR WILL, FOR|'+
						'SELLING OR BUYING OF CHILD|'+
						'SELLING OR BUYING OF CHILDREN|'+ 
						'TRANSPORT MINOR|'+
						'TRANS MINOR|'+
						'TRANS. MINOR|'+
						'TRANS OF MINOR|'+
						'TRANSP OF MINOR|'+
						'TRANSP PERSON|'+
						'TRANSPORT FEMALE INTERSTATE FOR IMMORAL PURP|'+
						'TRANSPORT HIM TO ANOTHER LOCATION|'+
						'TRANSPORT INTER FOR SEX ACTIVITY|'+
						'TRANSPORT OF A MINOR|'+
						'TRANSPORT OF MINOR|'+ 
						'TRANSPORT FOR SEXUAL ACTS|'+
						'TRANSPORTATION FOR ENTICEMENT OF SEXUAL ACTIVITY|'+
						'TRANSPORTATION FOR ILLEGAL SEXUAL ACTIVITY|'+
						'TRANSPORTATION GENERALLY|'+
						'TRANSPORTATION OF A JUVENILE|'+
						'TRANSPORATION OF A PERSON|'+	
						'TRANSPORTATION OF A MINOR|'+
						'TRANSPORTATION OF ILLICIT SEXUAL PURPOSES|'+
						'TRANSPORTATION OF MINOR|'+
						'TRANSPORTATION W/INTENT|'+
						'TRANSPORTING A MINOR|'+ 
						'TRANSPORTING FOR PURPOSE OF SEXUAL GRATIFICATION|'+
						'TRANSPORTING MINOR|'+
						'TRAVEL W/I/ENGAGE/ILLICIT SEXUAL|'+
						'TRAV W INT|'+
						'TRAV W/INT|'+
						'TRAVEL ACROSS STATE|'+
						'TRAVEL FOR PURPOSE|'+	
						'TRAVEL IN INTERSTATE COMMERCE|'+
						'TRAVEL INTER COMM|'+
						'TRAVEL W I ENGAGE ILLICIT SEXUAL COND|'+
						'TRAVEL W INT|'+
						'TRAVEL W/ INTENT|'+
						'TRAVEL W/INTENT|'+	
						'TRAVEL WITH INTENT|'+
						'TRAVEL WITH THE INTENT|'+
						'TRAVEL/INTENT|'+
						'TRAVELING IN INTERSTATE|'+
						'TRAVELING INTERSTATE|'+
						'TRAVELING TO MEET MINOR|'+
						'TRAVELING WITH INTENT|'+
						'TRAVELLING INTERSTATE|'+
						'TRVL W/INTENT|'+			
						'MEANS OF INTER. COMM. TO PERSUADE|'+
						'TRAVELING T MEET MINR T CMMIT|'+
            'ATTEMPT T TRANSPRT MINR ACRSS STATE LINES|'+
            'TRAVELING T MEET A MINR|'+

            'OFFENDER AND ACCOMPLICES HELD VICTIMS (TWO ADULT MALES) AGAINST THEIR WILL AND TRANSPORTED THEM TO A',

						trim(l.offense_description, left, right),
						0)<>'' => 'ABD',//ABDUCTION

					regexfind('CHAT SOCIAL NETWORK USE|'+
						'COMM SYSTEM|'+ 
						'COMMUNICATION SYSTEM|'+
						'COMP - NET - COMM|'+
						'COMP. - NET - COMM.|'+                                                                                                                                                                                                                                                                           
						'COMP-NET-COMM|'+
						'COMP/NET/COMM|'+
						'COMP - USE TO DO CRIME|'+ 
						'COMP. TALK W/ANOT|'+                                                                                                                                                                                                                                                                                    
						'COMP. USE TO DO CRIME|'+                                                                                                                                                                                                                                                                                     
						'COMP CHLD PRN|'+
						'COMPUTER|'+
						'COMPUTR|'+
						'ELEC_ENTICE|'+
						'ELEC_TRANS_OBS_MAT|'+
						'ELECTRONIC|'+
						'ELEC/ELECT/ELECTRONIC|'+
						'FLOPPY DISKETTE|'+
						'INTERNET|'+ 
						'LURING MINORS BY COMPUTER|'+
						'ONLINE|'+ 
						'TECHNOLOGY|'+ 
						'TELECOMM|'+
						'TELECOMMUNICATION|'+ 
						'USE INTER.FAC.|'+
						'WIRE COMM|'+ 
						'WIRE COMMUNICATION|'+ 
						'14:91.5 - UNLAWFUL USE OF A SOCIAL NETWORKING WEBSITE|'+ 
						'USE F CMPUTER T SLICIT MINR|'+
            'CMPUTER AIDED SLICITATIN F A MINR LA|'+
            'PRHIBITED USE F ELECTRNIC CMMUNICATIN SYSTEM|'+
            'CMPUTER PRNGRAPHY|'+
            'UNLAWFUL USE F ELECTRNIC MEANS T INCUDE MINR|'+
            '18USC2422B-USE F CMPUTER/TELEPHNE SYSTEM FR PURPSE F PERSUADING MINR T ENGAGE IN|'+

						'VA023 - PROPOSE SEX BY COMP ETC. 15+Y, OFFENDER 7+YR'

						,
						trim(l.offense_description, left, right),
						0)<>'' => 'COM',//COMPUTER_CRIME
						
					regexfind(                                                                                                                                                                                                                                                                                                       
						'CRIMINAL EXPOSURE|'+
						'CRIMINAL TRANS AIDS VIRUS|'+
						'CRIMINAL TRANSMISSION OF HIV|'+	
						'CRIMINAL TRANSMIT HIV|'+
						'DISORDERLY EXPOSURE|'+
						//'EXHIBIT|'+
						//'EXHIBITION|'+
						'EXHIBITIONIST|'+
						'EXHIBITIONISTIC|'+ 
						'EXP OF ONES SXL GENITAL|'+
						'EXPOSE GENITIAL|'+
						'EXPOSE SELF|'+ 
						'EXPOSING GENITIALS|'+
						'EXPOSING HIMSELF|'+
						'EXPOSING GENITALS|'+
						'EXPOSURE|'+
						'EXPOSURE CHARGES|'+
						'EXPOSURE OF PRIVATE PART|'+
						'EXPOSURE OF SEX ORGAN|'+
						'EXPOSURE TO HIV|'+
						'IND EXPO|'+
						'IND/ EXPOSURE|'+
						'INDCNT EXP|'+
						'INDEC EXPO|'+                                                                                                                                                                                                                                                                                                      
						'INDECENT BEHAVIOR|'+ 
						'INDECENT EXHIBITION|'+
						'INDECENT EXP|'+
						'INDECENT EXPOSE|'+
						'INDECENT EXPOSURE|'+
						'INDECENY WITH A CHILD|'+
						'INDECEXPOSURE|'+
						'INDECNT EXP|'+
						'INTENTIONAL EXPOSURE|'+
						'KNOWING/WILL EXPOSE|'+
						'LACIVIOUS SEXUAL ACTS|'+
						'LASCIV_ACTS_UNDER14|'+
						'LASIDOUS ACTS|'+
						'LEUD LASIC|'+
						'LEW AND LACCIVIOUS|'+  
						'LEWD & LASCIVIOUS EXHIBIT|'+
						'LEWS & LACIVIOUS CONDUCT|'+ 
						'LEWD OR LASCIVIOUS CONDUCT|'+
						'LEWD CONDUCT IN PUBLIC|'+
						'LEWD CONTACT IN PUBLIC|'+ 
						'LEWD AND LASCIVIOUS EXHIBIT|'+
						'LEWD LASCIVIOUS EXHIB|'+                                                                                                                                                                                                                                                                                                      
						'LEWD OR LASCIVIOUS EXH|'+ 
						'LEWD/LASCIVIOUS EXH|'+
						'LUDE AND LASIVIOUS|'+
						'LUDE/LUCIVICES|'+
						'MAKE OBSCENE DISPLAY|'+
						'MASTURBATION IN VIEW OF VICTIM|'+
						'OBSCENE CONDUCT|'+
						'OBSCENE EXPOSE|'+ 
						'OBSCENE EXPOSURE|'+
						'OBSCENE DISPLAY|'+
						'OPEN & GROSS LEWDNESS|'+
						'OPEN OR GROSS LEWDNESS|'+
						'OPEN AND GROSS LEWDNESS|'+
						'OPEN AND GROSS LEWNDESS|'+
						'OPEN/GROSS LEWDNESS|'+
						'PUB INDEC|'+
						'PUB SEX IND|'+
						'PUB SEX INDECENCY|'+
						'PUBLIC IDENC|'+
						'PUBLIC INDCENCY|'+ 
						'PUBLIC INDEC|' +
						'PUBLIC INDECENY|'+
						'PUBLIC INDECENCY|'+ 
						'PUBLIC INDENCENCY|'+ 
						'PUBLIC INDENCEY|'+                                                                                                                                                                                                                                                                                                            
						'PUBLIC SEX INDEC|'+
						'PUBLIC SEX INDECENCY|'+
						'PUBLIC SEXUAL INDECENCY|'+
						'PUBLIC SEXUAL INDESONCY|'+ 
						'PUBLIC SEXUAL INDECENT ORAL CONTACT|'+
						'SEX INDEC|'+
            'OPEN/GROSS|'+
            'SUBJECT EXPOSED HIMSELF TO A 30 YEAR OLD FEMALE.|'+
            'SUBJECT EXPOSED HIMSELF TO A 40 YEAR OLD FEMALE.|'+
            'SUBJECT EXPOSED HIMSELF TO A FEMALE.|'+
            'SUBJECT EXPOSED HIMSELF TO A VICTIM, GENDER UNKNOWN.|'+                                                                                                                                                                                                                                                                            
            'SUBJECT EXPOSED HIMSELF TO THREE FEMALES.|'+
            'SUBJECT EXPOSED HIMSELF TO TWO FEMALE VICTIMS.|'+
            'SUBJECT EXPOSED HIMSELF TO TWO FEMALES, AGES 17 AND 18.|'+                                                                                                                                                                                                                                                                         
            'SUBJECT INTENTIONALLY EXPOSED A MAN IN HIS 30 YRS TO HIV.|'+	
						'VISUALLY EXP.MINOR|'+
						'DEFENDANT WAS ARRESTED FOR URINATING IN A RIVER|'+
            'EXPOSING SELF IN PUBLIC PLACE; EXPOSING SELF IN PUBLIC PLACE|'+
						'INDESCENT EXPSURE|'+
            'INDICENT EXPSURE|'+
            'CRIMINAL EXPSURE T HIV NLY SUBSECTIN A1 F 39-13-109|'+
            'CRIMINAL EXPSURE T HIV|'+

            'PUBLIC SEXUAL INDEC-CONTACT|'+
						
						'RITUAL AB INGEST/APPLY URINE/2'


						
						,
						trim(l.offense_description, left, right),
						0)<>'' => 'EXS',//'EXPOSURE'
												
					regexfind('AGG RAP|'+
						'AGGRAVATED RAP|'+
						'ATTEMPT INTERC|'+
					  'ATTEMPTED RAP|'+
						'BUGGERY|'+
						'COERC W/FORCE OR THREAT OF FORCE, E/SEX|'+
						'CONCERT WITH FORCE|'+
						'CRIMES AGAINST NATURE (SODOMY)|'+
						'CRIMINAL_SEXUAL_PENETRATION_4|'+
						'DEV/DEVIANT SEXUAL INTERCOURSE|'+
						'DEV SEXUAL INTERCOURSE|'+
						'DEVIANT SEXUAL INTERCOURSE|'+
						'DEVIATE/DEVIANT SEXUAL INTERCOURSE|'+
						'DEVIATE SEXUAL INTERCOURSE|'+
						'DEVIATE SEXUAL UNTERCOURSE|'+
						'DEVIANT SEXUAL INTERCOURSE|'+ 
						'DRUGGING PERSONS FOR SEXUAL INTERCOURSE|'+ 
						'ELHADJ SODOMIZED A 35 Y/O FEMALE.|'+ 
						'FALSE REPRESENTATION|'+
						'FELLATIO ALLEG|'+
						'FELONIOUS SEXUAL PENETRATION|'+
						'FORCE TO COMMIT SEXUAL INTERCO|'+
						'FORCED PENIS INTO VICTIMS MOUTH|'+ 
						'FORCED INTERCO|'+
						'FORCED PENETRATION|'+ 
						'FORCED VICTIM TO PERFORM ORAL SEX|'+
						'FORCIBLE COMPULSION|'+
						'FORCIBLE ORAL|'+
						'FORCIBLE ORAL COPULATION|'+
						'FORCIBLE SEXUAL INTERCOURSE|'+ 
						'FORCIBLE SOD|'+
						'INDUCE INTERCOURSE OR SEX ACTS BY|'+
						'INDUCE INTERCOURSE OR SEX ACTS BY FALSE REPRESENTATION/INTIMIDATION/FEAR|'+ 		
						'INTCRSE W/RES NUR FAC-1ST OFF|'+ 
						'INTERCOURSE WITH VICTIM|'+	
						'INTERCOURSE W/O CONSENT|'+
						'INTERCOURSE WITHOUT CONSENT|'+ 
						'INVOL DEVIATE SEX INTERC|'+
						'INVOLUNTARY DEVIATE SEX|'+
						'IVOL DEVIATE SEX INTERCOURSE M|'+
						'NONCONSEN SEX|'+
						'NONCONSENSUAL SEX|'+
						'OFFENSE DESCRIPTION: RAP|'+
						'ORAL COMP|'+
						'ORAL COP|'+
						'ORAL COP W/PERSON U/|'+
						'ORAL COPULATION <|'+
						'ORAL COPULATION BY FORCE|'+
						'ORAL COPULATION W PERSON <|'+
						'ORAL COPULATION W/ PERSON <|'+
						'ORAL COPULATION W/PERSON U/|'+
						'ORAL COPULATION WITH CHILD|'+
						'ORAL COPULATION WITH PERSON <|'+
						'ORAL COPULATION WITH PERSON U/|'+
						'ORAL COPULATION/ U/|'+
						'ORAL COPULATION W-JUVENILE|'+
						'ORAL COPULATION WITH A MINOR|'+
						'ORAL COPULATION WITH A PERSON UNDER|'+
						'ORAL COPULATION WITH FORCE|'+
						'ORAL COPULATION BY FORCE|'+
						'ORAL_COP|'+
						'ORAL/ANAL SEX WITHOUT CONSENT|'+ 
						'PENETRATION WITHOUT CONSENT|'+
						'RAPY BY INSTRUMENTATION|'+ 
						'RAP/1129/F9|'+	
						'RAEP|'+
						'RAPDE 3RD DEGREE|'+
						'RAPE|'+ 
						'RUSH SODOMIZED A NINE YEAR OLD MALE.|'+ 
						'SEX NTACT NO NSENT|'+
						'SEX PENETRATION W/ FORCE|'+
						'SEX PENETRATION W/FORCE|'+
						'SEXUAL PENETRATION/KIDNAPPING|'+
						'SEXUAL PENETRATION-FORCIBLE|'+
						'SEX_PEN_OF_INTOX_PERSON|'+
						'SEX INTERCOURS WO CONSENT|'+                                                                                                                                                                                                                                                                                                       
						'SEX INTERCOURSE W/O CONSENT|'+                                                                                                                                                                                                                                                                                                     
						'SEX INTERCOURSE W/OUT CONSENT|'+ 
						'SEX WITHOUT CONSENT|'+ 
						'SEXUAL INTERCOURSE W/O CONSENT|'+ 
						'SEXUAL INTERCOURSE W/OUT CONSENT|'+ 
						'SEXUAL INTERCOURSE WITH OUT CONSENT|'+                                                                                                                                                                                                                                                                                            
						'SEXUAL INTERCOURSE WITHOUT CONSENT|'+
						'SEXUAL INTERCOURSE WITHOUT INFORMED CONSENT|'+ 
						'SEXUAL INTERCOUSE W/O CONSENT|'+ 
						'SEXUAL NTACT NO NSENT|'+
						'SEXUAL WITH THREAT FORCE|'+
						'SINGLETON SEXUALLY ABUSED AND SODOMIZED A FIVE YEAR OLD MALE.|'+ 
						'STATUATORY_SEXUAL_SED|'+
						'STATUTORY INTERCOURSE W/O CONSENT|'+
						'STATUTORY R|'+
						'STATUTORY SEX SED|'+
						'STATUTORY SEXUAL SED|'+
						'STATUTORYAPE|'+
						'STATUTORY_SEXUAL_SED|'+                                                                                                                                                                                                                                                                                                  
						'STATUTORY_SEX_SED|'+
						'SOCOMY|'+
						'SODAMY|'+
						'SODEMY|'+
						'SODMY|'+
						'SODOMY|'+
						'SUBJECT SODOMIZED A 40 YEAR OLD FEMALE.|'+ 
						'UNL.SEX.INTER.|'+
						'UNLAW. SEX. INT.|'+
						'UNLAW SEX INTERCOURSE|'+                                                                                                                                                                                                                                                                                                           
						'UNLAW SEXUAL INTERCOURSE|'+
						'UNLAW_SEXUAL_INTERCOURSE|'+
						'UNLAWFUL INTERCOURSE|'+    
						'UNLAWFUL SECUAL PENETRATION|'+
						'UNLAWFUL SEX|'+
						'UNLAWFUL_INTERCOURSE|'+                                                                                                                                                                                                                                                                                                           
						'VICTIM INCAPABLE OF GIVING CONSENT|'+  
            'AGGRAVATED S0D0MY|'+  
            'FORCE ENGAGE IN CUNNILINGUS|'+  
            'INDUCE SEX/ACT: FALSE REP/ETC:INT:FEAR|'+  
						'SDMY X 2|'+
						'FRCIBLE SDMY|'+
						'SDMY PHYSICAL INJURY W/WEAPN|'+
						'SDMY 2|'+
						'RAL CPULATIN|'+
						'RAL SDMY F MINR|'+
						'SDMY-M|'+
						'RAL CPULATIN F A MINR|'+
						'FRCED SDMY|'+
						'SDMY 1ST DEG|'+
						'RAL CP WITH FRCE|'+
						'RAL CPULATIN BY FRCE|'+
						'ATTEMPTED SDMY 2ND|'+
						'SDMY|'+
						'FRCE ENGAGE IN CUNNILINGUS|'+
						'ANAL SDMY|'+
						'SDMY II|'+
						'FRCIBILE SDMY|'+
						'SDAMY|'+
						'ATTEMPTED SDMY|'+
						'ANAL AND GENITAL PENETRATIN BY FREIGN BJECT|'+
						'SDMY 1ST|'+
						'RAL CP-14/R BY FRCE|'+
						'SDMY 2ND|'+
						'SDMY I|'+
						'AGG. SDMY|'+
						'SDMY-K|'+

            'RAPR|'+


            'RAP-1129-F9'  
						
						,
						trim(l.offense_description, left, right),
						0)<>'' => 'RAP',//'RAPE',
								
					regexfind('00466 - 207.190 (F) - COERCION|'+
						'014-027.050 - ATTEMPT 2ND DEG. SEX OFF.-BY FORCE|'+
						'2ND DEGREE OFFENSE, INDECENT|'+						
						'2ND DEGREE SEXUAL|'+	
						'35-42-4-2 - CRIMINAL DEVIATE CONDUCT|'+
						'36010001-F2-INDECENCY W|'+
						'4TH DEGREE S/A|'+
						'A AND B W/DEADLY WEAPON|'+
						'ABSV SXL CONTACT|'+
						'ABUSE OF A VULNERABLE ADULT|'+
						'ABUSE OF VULNERABLE ADULT|'+
						'ABUSIVE SEXUAL CNTCT|'+
						'ABUSIVE SEXUAL CONAT|'+ 
						'ADULTERY|'+ 
						'ADULTERY & FORNICATION BY PERSON FORBIDDEN TO MARRY|'+
						'AGG SEX|'+
						'AGG. IND. ASS|'+
						'AGGGRAVATED CRIMINAL ASS|'+
						'AGGRAVATED S/A|'+						
						'AGGRAVATED ASS|'+ 
						'AGGRAVATED ASSAULT WITH INTENT TO RAPE|'+
						'AGGRAVATED BATT|'+
						'AGGRAVATED CRIMINASL SEXUAL CO|'+
						'AGGRAVATED SEX|'+  
						'ANAL_OR_GENITAL_PEN|'+
						'ANIMATE OBJECT SEXUAL PENETRATION|'+ 
						'ANNOY OR MOLEST|'+                                                                                                                                                                                                                                                                                                                 
						'ANNOY/MOLEST|'+                                                                                                                                                                                                                                                                                                                    
						'ANNOYS OR MOLESTS|'+  
						'ASLT|'+
						'ASSA/W/INT TO COMM SEXU PENET|'+	
						'ASSAULT|'+
						'ASSL W INTENT TO COMMIT FELONY ATTEMPT|'+
						'ASSL W/INTENT TO COMMIT FELONY/ATTEMPT|'+ 
						'ASSLT|'+
						'ASSULT RESULTING IN SERIOUS BODILY INJURY|'+
						'AT SEX PEN|'+
						'ATT SEXU ABUSE|'+
						'ATTEMPT TO COMMIT|'+
						'ATTEMPT TO COMMIT SODOMY|'+
						'ATTEMPTED 1ST DEGREE SEX|'+
						'ATTEMPTED SEX REL|'+
						'ATTEMPTED SEXU ABUSE|'+
						'ATTEMPTED SEXUAL STATUTORY SEDUCTION|'+
						'BATT W I TO COMMIT SERIOUS FEL|'+
						'BATT W/INTENT TO COMM|'+                                                                                                                                                                                                                                                                                                  
						'BATTERY|'+
						'CARNAL KNOW|'+
						'CARNAL KNOWLEDGE/ABUSE|'+ 
						'CARNAL ABUSE|'+
						'CARNAL_ABUSE|'+
						'CARNAL_KNOWLEDGE|'+
						'CARNAL INTERCOURSE|'+
						'CNAL ABUSE|'+
						'COERC W/FORCE OR THREAT OF FORCE|'+
						'COERCION|'+
						'COERCION AND ENTICEMENT|'+ 
						'COERCION SEXUALLY MOTIVATED|'+
						'COMMIT SPECIFIED SEX FELONY|'+
						'CONSPIRE COMMIT SEX ACT|'+
						'CORRECTIONAL STAFF ENGAGING IN SEX WITH AN INMATE OR OFFENDER|'+
						'CRIM DEVIATE CONDUCT|'+	
						'CRIM SEX|'+	
						'CRIM SEX 1ST DEG/PENETAT|'+	
						'CRIM SEX COND|'+	
						'CRIM. SEX. COND|'+
						'CRIM SEX PENETRATION|'+ 
						'CRIM SEXUAL PENETRATION|'+
						'CRIM. ATT. TO COMM. ENTIC|'+
						'CRIM. SEX. CONTACT|'+
						'CRIM_SEX_CONDUCT|'+ 
						'CRIM_SEXUAL_CONDUCT|'+
						'CRIME SEX|'+
						'CRIMIANL SEX|'+
						'CRIMINAL ABUSE|'+
						'CRIMINAL ATTEMPT TO COMMIT RAPE|'+ 
						'CRIMINAL ATTEMPT TO ENTICE|'+
						'CRIMINAL DEVIANT CONDUCT|'+
						'CRIMINAL DEVIATE CONDUCT|'+
						'CRIMINAL PENETRATION|'+
						'CRIMINAL SECUAL COND|'+
						'CRIMINAL SEX|'+
						'CRIMINAL SEX CONDUCT|'+
						'CRIMINAL SEXUAL ACT|'+
						'CRIMINAL SEXUAL CONDUCT|'+ 
						'CRIMINAL SEXUAL CONTACT|'+
						'CRIMINAL SEXUAL PENETRATION|'+ 
						'CRIMINAL THREAT|'+
						'CRIMINAL, DEVIATE, CONDUCT|'+
						'CRIMINAL_SEX_|'+
						'CRIMINAL_SEX_COND|'+                                                                                                                                                                                                                                                                                                         
						'CRIMINAL_SEXUAL_CONDUCT|'+ 
						'CRINAL SEX|'+
						'DEVIATE CONDUCT|'+
						'DIGITAL PENETRATION|'+ 
						'DOMESTIC ABUSE PREVENTION AND INTERVENTION ACT|'+
						'DOMESTIC ASSAULT|'+
						'DOMESTIC BATTERY|'+
						'DOMESTIC VIOLENCE|'+
						'DOMESTIC VIOLENCE/BATTERY/VICTIM/ASSAULT/DOMESTIC|'+
						'EMPLOYEE SEX|'+	
						'ENGAGE IN SEXUAL ACT BY THREAT OR PLACE IN FEAR|'+	
						'ENGAGE SEXL ACTIVITY|'+
						'ENGAGED IN SEXUAL CONTACT WITH VICTIM|'+
						'ENGAGING_IN_ILLICIT_SEXUAL_CON|'+
						'ENGAING IN A SEX ACT|'+
						'ENTICEMENT/ELECT COMMIT DEV|'+
						'ENTICEMNET|'+
						'ENTICING FOR INDECENT|'+
						'FACILITATION FOR SEXUAL SERVITUDE|'+
						'FEDERAL ASSUALT RESULTING IN SERIOUS BODILY INJURY|'+
						'FEDERAL CONVICTION|'+
						'FEDERAL - OBSCENITY|'+
						'FELONIOUS ABUSE|'+
						'FELONIOUS ACT|'+
						'FELONIOUS ASLT|'+
						'FELONIOUS ASSAULT|'+
						'FELONIOUS CONDUCT|'+
						'FELONIOUS CONTACT|'+
						'FELONIOUS SEDUCTION|'+
						'FELONY CONVICTION AFTER|'+
						'FL794.011 (8B) 3RD DEG STATUTORY OFFENSE|'+
						'FONDLING|'+
						'FORC SEX PENETRATION FORN OBJ|'+                                                                                                                                                                                                                                                                                                  
						'FORCE OBJECT|'+
						'FORCED VIEWING OF SEXUAL ACTIVITY|'+
						'FORCIBLE TOUCHING|'+ 
						'FOREIGN OBJ|'+
						'FOREIGN OBJECT|'+
						'FORIGN OBJECT|'+
						'FORGN OBJ|'+
						'FORIEGN OBJ|'+
						'FORN OJB|'+                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
						'FORNICATION|'+ 
						'GESTURE OF SEXUAL NATURE|'+
						'GRATIFICATION OF LUST|'+
						'GRATIFYING LUST|'+
						'GOSS SEXUAL IMPOSTITION|'+                                                                                                                                                                                                                                                                                                        
						'GROSS SEXUAL IMOPSITION|'+                                                                                                                                                                                                                                                                                                         
						'GROSS SEX IMP|'+
						'GROSS SEX. IMP.|'+
						'GROSS SEX UMPOSITION|'+ 
						'GROSS SEX. IMPOS.|'+ 
						'GROSS SEX.IMPOS.|'+
						'GROSS SEXL IMPOSITION|'+
						'GROSS SEXUAL IMP|'+                                                                                                                                                                                                                                                                                                               
						'GROSS SEXUAL IMPOSITION|'+
						'GROSS SEXUAL IMPOSTION|'+
						'GROSS SEXUAL INPOSITION|'+ 
						'GROSS SEXUAL MISDCONDUCT|'+
						'GROSS_SEX_IMP|'+
						'HARASS|'+
						'HARASSMENT|'+
						'HARRASS|'+                                                                                                                                                                                                                                                                                                                    
						'IMPOSITION|'+
						'IMPOSTION|'+
						'IMPARING MORALS|'+
						'INANIMATE OBJECT PEN|'+
						'INCENT LIBERTIES|'+                                                                                                                                                                                                                                                                                                                
						'IND LIBERTIES|'+
						'INDECENCY BY CONTACT|'+
						'INDECENT ACT|'+
						'INDECENT ASLT|'+
						'INDECENT ASS|'+
						'INDECENT CONDUCT|'+
						'INDECENT CONTACT|'+
						'INDECENT LIABERTIES|'+ 
						'INDECENT LIB|'+ 
						'INDECENT SEDUCTION|'+
						'INDECENT_ACT|'+
						'INDECENT_LIB|'+
						'INDECEY BY CONTACT|'+
						'INDECNET LIB|'+
						'INDENCENT_LIB|'+
						'INDESCENT ACT|'+
						'INSTITUTIONAL SEXUAL ASSAULT AND INDECENT ASSAULT|'+
						'INTENTIONAL SUBJECT AN INDIVIDUAL AT RISK TO ABUSE|'+
						'INTENTIONALL SUBJECT AN INDIVIDUAL AT RISK TO ABUSE|'+
						'INTERCOURSE AND SEX OFF|'+
						'INTERCOURSE AND SEXUAL OFFENSE|'+ 
						'INTERCOURSE_W_|'+	
						'INTIMIDATE VICTIM|'+
						'INTRUDE/PRIVACY|'+
						'THREATEN FORCE|'+ 
						'INFLICT CORPORAL INJURY|'+
						'INTERCOURSE AND SEX OFF W CERTAIN VICTIM|'+
						'INVOLUNTARY SERVITUDE|'+
						'IMPROPER CONTACT|'+
						'LASCIVIOUS|'+
						'LASCIVIOUS ACT|'+ 
						'LASCIVIOUS BATT|'+
						'LASCIVIOUS BEHAVIOR|'+
						'LEWD|'+
						'LEWD ACT|'+ 
						'LUDE AND LACIVIOUS BEHAVIOR|'+
						'MISC SEXUAL OFF|'+
						'MISCELLANEOUS SEX OFF|'+
						'MISSOURI UNLAWFUL USE OF A WEAPON|'+ 
						'MOLESTATION|'+ 
						'MOLESTING|'+
						'OBJECT SEXUAL PENETRATION|'+
						'OFFENSE DESCRIPTION: SEX|'+
						'PENETRATE WITH FOREIGN OBJECT|'+
						'PENETRATE WITH INANIMATE OBJECT|'+
						'PENETRATE WITH INANIMATE/FOREIGN OBJECT|'+
						'PENETRATION BY FOREIG|'+
						'PENETRATION FOR OBJ|'+
						'PENETRATION OR CONTACT|'+
						'PENETRATE_FOREIGN_OBJECT|'+
						'PLACED FINGERS UP VAG|'+
						'PRECURSOR TO ILLEGAL SUBSTANCE|'+
						'PREDATORY CRIM|'+
						'PREDATORY CRIMINAL SEXUAL|'+
						'PROHIBITED SEX|'+
						'PROM OBSCENE SEX PERF|'+
						'RETALIATION AGAINST WITNESS/VICTIM - SEXUAL FACTUAL BASIS (2006).|'+
						'S/A|'+
						'SEAUAL ABUSE|'+
						'SEDUCTION OF ADULT|'+
						'SEVERAL SEXUAL CONVICT|'+
						'SEX ABUS|'+
						'SEX ABUSE|'+
						'SEX ASAULT|'+
						'SEX ASLT|'+
						'SEX ASS|'+
						'SEX ASSAULT|'+
						'SEX ASSLT-OTHER/OTHER STATE|'+ 
						'SEX ASSLT-OTHER|'+
						'SEX ASSLT OTHER STATE|'+
						'SEX ASSULT|'+
						'SEX AUBSE|'+
						'SEX BAT|'+
						'SEX COND |'+ 
						'SEX CONDUCT|'+
						'SEX CONT W/INMATE-EMP OF COR FAC|'+
						'SEX CONT-VICT INCAPABLE-APPRAISING|'+
						'SEX CONTACT|'+
						'SEX CONTCT W/STU BY EMPL/VLNTR|'+                                                                                                                                                                                                                                                                                                  
						'SEX CRIME|'+
						'SEX IN PENIAL INSTITUTE|'+
						'SEX INTERFERENCE|'+
						'SEX MISC|'+
						'SEX MISCONDUCT/BAT/IMPOSITION/TOUCHING/FONDLING|'+
						'SEX NT VICT|'+
						'SEX NTACT VICT|'+
						'SEX OFF 2ND DEG|'+
						'SEX OFF. 3RD DEGREE|'+
						'SEX OFFENDER 3RD DEGREE|'+
						'SEX OFFENSE|'+
						'SEX OFFENSE - 2ND DEGREE BY FORCE AGAINST WILL|'+
						'SEX OFFENSE, OTHER STATE|'+ 
						'SEX PEN|'+
						'SEX RELATIONS|'+
						'SEX UAL ABUSE|'+
						'SEX. OFFENSE |'+
						'SEX_ABUSE|'+
						'SEX_ASAULT|'+                                                                                                                                                                                                                                                                                                             
						'SEX_ASS|'+
						'SEX.BAT/VICT O/12 INCAP|'+                                                                                                                                                                                                                                                              
						'SEX_BAT|'+
						'SEX_CONDUCT|'+
						'SEX_CONTACT|'+
						'SEX_INTERC|'+
						'SEX_W|'+
						'SEX/CRIMINAL/FELONIOUS/INDECENT ASSAULT/ASLT/ABUSE/CONDUCT/CONTACT/SEDUCTION/ACT|'+
						'SEX_OFFENSE|'+	
						'SEX_PENETRATION_FOREIGN_OBJECT|'+ 
						'SEX_PENETRATION|'+
						'SEXAL ABUSE|'+
						'SEXAUL ABUSE|'+ 
						'SEXU ABUSE|'+
						'SEXU CONTACT COMP|'+
						'SEXU MISCON|'+
						'SEXUA ABUSE|'+
						'SEXUAL A|'+
						'SEXUAL ABAUSE|'+
						'SEXUAL ABBUSE|'+
						'SEXUAL ABISE|'+
						'SEXUAL ABUESE|'+                                                                                                                                                                                                                                                                                                      
						'SEXUAL ABUSE|'+
						'SEXUAL ABUST|'+
						'SEXUAL ACTIVITY BY A CAREGIVER|'+                                                                                                                                                                                                                                                                                                 
						'SEXUAL AGG|'+
						'SEXUAL ASAULT|'+ 
						'SEXUAL ASL|'+
						'SEXUAL ASS|'+
						'SEXUAL ASSAULT|'+
						'SEXUAL ASLT|'+
						'SEXUAL ASUALT|'+
						'SEXUAL ASSAULT W/ ATTEMPT/INTENT RAPE/SODOMY|'+ 
						'SEXUAL BAT|'+
						'SEXUAL BATTERY|'+
						'SEXUAL BAUSE|'+                                                                                                                                                                                                                                                                                                      
						'SEXUAL BEHAVIOR|'+
						'SEXUAL CONDUCT|'+
						'SEXUAL CONTACT|'+
						'SEXUAL DEVIATE ACTS|'+
						'SEXUAL IMPOSITION|'+
						'SEXUAL INTENT|'+
						'SEXUAL INTERC|'+
						'SEXUAL INTERCOURSE WITH A PATIENT OR TRAINEE|'+
						'SEXUAL INTERCOURSE WITH VICTIM|'+
						'SEXUAL INTERFERENCE|'+
						'SEXUAL INTRUSION|'+
						'SEXUAL MOTIVATION|'+
						'SEXUAL MISCOND|'+
						'SEXUAL MISCONDUCT|'+
						'SEXUAL MISCONDUCT/BATTERY/IMPOSITION/TOUCHING/FONDLING|'+  
						'SEXUAL NTACT|'+
						'SEXUAL OFFENSE|'+
						'SEXUAL PEN|'+
						'SEXUAL SBUSE|'+
						'SEXUAL TORTURE|'+
						'SEXUL PEN|'+
						'SEXUAL AGGRESSION|'+
						'SEXUAL SEDUCTION|'+
						'SEXUUAL ASSULT|'+                                                                                                                                                                                                                                                                                                           
						'SEXUAL_ABUSE|'+
						'SEXUAL_ASS|'+
						'SEXUAL_BATT|'+
						'SEXUAL_BTRY|'+
						'SEXUAL_CONT|'+
						'SEXUAL_INTER|'+
						'SEXUALABUSE|'+                                                                                                                                                                                                                                                                                                      
						'SEXUALBATT|'+
						'SEXUAL/CRIMINAL/FELONIOUS/INDECENT ASSAULT/ASLT/ABUSE/CONDUCT/CONTACT/SEDUCTION/ACT|'+ 
						'SEXUAL/LASCIVIOUS BEHAVIOR|'+                                                                                                                                                                                                                                                                                               
						'SEXULA ABUSE|'+
						'SEXUAL DELINQUENT PERSON|'+
						'SEXUALLY DANGEROUS/VIOLENT PERSON|'+ 
						'SEXUALLY DANGEROUS PERSON|'+
						'SEXUALLY DELINQUENT PERSON|'+
						'SEXUALLY MOTIVATED|'+
						'SEXUALLY VIOLENT|'+
						'SWX OFFENSE|'+
						'STAT SEX SEDUCT|'+
						'STATUTORY SEXUAL OFFENSE|'+
						'STATUTORY SEXUAL SEDUCTION|'+
						'SUBMISION AGAINST THE VICTIM|'+
						'SECOND DEGREE BY FORCE AGAINST THE WILL OF|'+
						'SUBJECT SEXUALLY ABUSED A 30 YEAR OLD FEMALE.|'+
						'THE VICTIMS WERE TWO ADULT FEMALES|'+
						'TOUCH INTIMATE PART|'+
						'TOUCH INTIMATELY AGAINST WILL|'+
						'TOUCH PERSON INTIMATELY AGAINST WILL|'+  
						'TOUCHED FEMALE STRANGER|'+
						'TOUCHED PEN|'+	
						'TOUCHED VICTIM|'+
						'TOUCHING|'+						
						'UNLAWFUL SEXUAL CONTACT|'+
						'UNLAWFUL SEXUAL RELATIONS|'+
						'UNLAWFUL_SEX|'+
						'UNLAWFUL TOUCH|'+
						'UNLAWFUL VOLUNTARY SEX|'+
						'UNLAWFUL VOLUNTARY S|'+
						'UNNATURAL INTERCOURSE|'+
						'USED FORCE TO COMMIT SEXUAL IN|'+
						'VANARCKENS VICTIM WAS A TWENTY FOUR YEAR OLD FEMALE.|'+
						'VAGINAL INT|'+	
						'VICARIOUS SEX|'+
						'VICARI0US SEX|'+						
						'VICITM WAS AN ADULT FEMALE|'+
						'VICTIM AN ADULT FEMALE|'+
						'VICTIM AS AN ADULT FEMALE|'+
						'VICTIM WAS A ADULT FEMALE|'+
						'VICTIM WAS A ADULT FEMALE.|'+
						'VICTIM WAS A ADULT MALE|'+
						'VICTIM WAS A AND FEMALE|'+
						'VICTIM WAS A EIGHTY YEAR OLD FEMALE|'+
						'VICTIM WAS A FEMALE|'+
						'VICTIM WAS A FEMALE AGE SIXTY NINE|'+
						'VICTIM WAS A FEMALE OF AN UNKNOWN AGE|'+
						'VICTIM WAS A FEMALE, AGE UNKNOWN|'+                                                                                                                                                                                                                                                                                                
						'VICTIM WAS A FEMALE.|'+
						'VICTIM WAS A FIFTY FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A FIFTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A FIFTY YEAR OLD FEMALE|'+
						'VICTIM WAS A FIFTY YEAR OLD FEMALE.|'+
						'VICTIM WAS A FORTY SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A FORTY THREE YEAR OLD FEMALE|'+
						'VICTIM WAS A FORTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A FORTY YEAR OLD FEMALE|'+
						'VICTIM WAS A FORTY-TWO OLD FEMALE|'+
						'VICTIM WAS A MALE|'+
						'VICTIM WAS A SEVENTY FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVENTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVENTY YEAR OLD FEMALE|'+
						'VICTIM WAS A SEVENTY-FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A SIXTY FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A SIXTY YEAR OLD FEMALE|'+
						'VICTIM WAS A SIXTY-ONE YEAR OLD FEMALE.|'+
						'VICTIM WAS A THIRTY EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY NINE YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY ONE YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY SEVEN YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY THREE YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY THREE YEAR OLD MALE|'+
						'VICTIM WAS A THIRTY TWO YEAR FEMALE|'+
						'VICTIM WAS A THIRTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY YEAR OLD MALE|'+
						'VICTIM WAS A THIRTY-FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY-FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY-THREE YEAR OLD FEMALE|'+
						'VICTIM WAS A THIRTY-TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTEY FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY EIGHT YEAR OLD FEMALE.|'+
						'VICTIM WAS A TWENTY FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY ONE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY ONE YEAR OLD FEMALE.|'+
						'VICTIM WAS A TWENTY ONE YEAR OLD MALE|'+
						'VICTIM WAS A TWENTY SIX YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY THREE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY YEAR OLD FEMALE.|'+
						'VICTIM WAS A TWENTY-FIVE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY-FOUR YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY-ONE YEAR OLD FEMALE|'+
						'VICTIM WAS A TWENTY-SIX YEAR OLD FEMALE|'+
						'VICTIM WAS AN ADUL FEMALE|'+
						'VICTIM WAS AN ADULT|'+
						'VICTIM WAS AN ADULT FAMALE|'+
						'VICTIM WAS AN ADULT FEMALE|'+
						'VICTIM WAS AN ADULT FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
						'VICTIM WAS AN ADULT FEMALE.|'+
						'VICTIM WAS AN ADULT MALE|'+
						'VICTIM WAS AN ADULT MALE.|'+
						'VICTIM WAS AN ADULT OLD FEMALE|'+
						'VICTIM WAS AN ADULT YEAR OLD FEMALE|'+
						'VICTIM WAS AN ADUT FEMALE|'+
						'VICTIM WAS AN EIGHTY NINE YEAR OLD FEMALE|'+
						'VICTIM WAS AN EIGHTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS AN ELDERLY FEMALE|'+
						'VICTIM WAS AN TWENTY TWO YEAR OLD FEMALE|'+
						'VICTIM WAS AND ADULT FEMALE|'+
						'VICTIM WAS FEMALE|'+
						'VICTIM WAS TWENTY TWO YEAR OLD MALE|'+
						'VICTIM WERE TWO FEMALES AND A MALE|'+
						'VICTIMS WERE 2 ADULT AGED FEMALES|'+
						'VICTIMS WERE A MALE & FEMALE|'+
						'VICTIMS WERE A TWENTY FIVE AND TWENTY SEVEN YEAR OLD FEMALE|'+
						'VICTIMS WERE A TWENTY ONE AND A FIVE YEAR OLD FEMALE|'+
						'VICTIMS WERE ADULT FEMALES|'+
						'VICTIMS WERE ADULT FEMALES.|'+
						'VICTIMS WERE ADULT MALES|'+
						'VICTIMS WERE FEMALES|'+
						'VICTIMS WERE MALE AND FEMALE|'+
						'VICTIMS WERE MALES|'+
						'VICTIMS WERE THREE FEMALES|'+
						'VICTIMS WERE THREE MALES AND ONE FEMALE|'+
						'VICTIMS WERE THREE MALES AND THREE FEMALE|'+
						'VICTIMS WERE TWO ADULT FEMALES|'+
						'VICTIMS WERE TWO ADULT MALES|'+
						'VICTIMS WERE TWO FEMALES|'+	
						'VIOL SEXM OFFENDER ACT|'+
						'VULNERABLE ADULT|'+
						'WRONGFUL/ILLEGAL SEXUAL CONTACT|'+
						'WRONGFUL SEXUAL CONTACT|'+
						'ILLEGAL SEXUAL CONTACT|'+
						'SCHOOL EMPLOYEE ENGAGING IN A SEX ACT|'+
						'ATTEMPTED PRIOR CODE - TOUCH PERSON INTIMATELY AGA|'+
						'750.532 - SEDUCTION|'+
						'ADULT ABUSE W/MOTIVATION|'+
						'CRIIMINAL SEUAL CONDUCT 1ST DEGREE|'+                                                                                                                                                                                                                                                                                              
            'CRIMINAL SESXUAL CONDUCT 4TH DEGREE|'+  
						
            '3RD DEG SEX AS\'LT: BY MEDICAL PRACT\'NER|'+ 
						'AGG BTRY/USE DEADLY WEAPON|'+ 
						'AGG SAC|'+ 
						'AGGRAVATED CRIMINAL SE|'+ 
						'CAUSING BODILY INJURY - ART. 128|'+ 
						'CONDUCT 1ST DEGREE|'+ 
						'ENTICE|'+ 
						'ETC FOR IMMORAL PURPOSES|'+ 
						'FELONY CONVICT|'+ 
						'FELONY CONVICTI|'+ 
						'FELONY CONVICTION|'+ 
						'FELONY CONVICTION A|'+ 
						'GRATIFICATION|'+ 
						'INCAPACITATED OR PHYSICALLY HELPLESS|'+ 
						'INCAPACITATED OR PHYSICALLY HELPLESS FOR LU|'+ 
						'INCAPACITATED OR PHYSICALLY HELPLESS PERSON|'+ 
						'INCAPACITATED OR PHYSICALLY HELPLESS PERSON FOR|'+ 
						'INCAPACITATED OR PHYSICALLY HELPLESS PERSON FOR LUS|'+ 
						'INCAPACITATED/PHYSICALLY HELPLESS PERSON FOR LUST|'+ 
						'INCAPCATED/UNABLE TO A|'+ 
						'LECV. BATERY|'+ 
						'OFFENDER 18 OR OLDER|'+ 
						'OFFENDER 18 OR OLDER; F.S. 800.04(5)(B)|'+ 
						'PERFORMED ACTS PROHIBITED CHAPTER 38 11 1 A|'+ 
						'PERMIT SEX WITH SUBJECT|'+ 
						'PERSON OR PHYSICALLY HELPLESS|'+ 
						'PHYSICALLY HELPLESS PERSON FOR LUSTFUL PURPOSES|'+ 
						'PHYSICALLY HELPLESS PERSON FOR LUSTFUL PURPOSES (97-5-23)|'+ 
						'RETALIATION AGAINST A WITNESS/VICTIM|'+ 
						'RETALIATION FOR PAST ACTION|'+ 
						'SEX|'+ 
						'SEX CORRECTION INST-EMPLOY-CONTACT|'+ 
						'SEX/CORRECTION INST-EMPLOY-INTRUS/PENET|'+ 
						'SEX/PENAL INSTITUTION-EMPLOYEE-CONTACT|'+ 
						'SEXUAL CONT-SENT ENHANCER-THREAT RETAL|'+ 
						'SEXUALLY MOTIVATION|'+ 
						'SEXUAL_ACTS|'+ 
						'STATUTORY - C265 S23|'+ 
						'TOUCH PERSON INTIMATELY AGA|'+ 
						'USING FORCE|'+
						'ANNY MLEST 647A|'+
            'CARNAL KNWLEDGE-MILITARY|'+
            'ATTEMPT T CMMIT FELNY|'+
            'L/L MLESTATIN|'+
             'FNDLING|'+
             'INDECENT R IMMRAL PRACTICES WITH ANTHER|'+
             'MLESTATIN|'+
             'CARNAL KNWLEDGE|'+
             'CARNAL KNWLEDGE WITHUT FRCE|'+
             'CARNAL KNWLEDGE X 2|'+
						 'ABUSE BY CARETAKER|'+
						'BATERY|'+
						
						'FSA|'+
						'AFSA|'+
						'SAC/ATT|'+
						'SAC 18-3-405|'+
						'SAC / ATTEMPT|'+
						'SAC - ATTEMPT|'+
						
						'SAC; 03CR2964|'+
						'SAC; 99CR2887|'+
						'SAC 2005CR4365|'+
						'SAC; 94CR699|'+
						'SAC; 1993CR001300|'+
						'ADULTRY|'+
						'INDECENT A &AMP; B|'+
						'1ST DEG SAC|'+
						'SAC; 95CR2792|'+
						'ATT SAC; 2015CR540|'+
						'SAC|'+
						'ATT SAC|'+
						'SAC; 92CR2913|'+
						'SAC; 08CR2707|'+
						'SAC; 12CR2998|'+
						'SAC; 05CR480|'+
						'SAC; 2012CR809|'+
            'RCW 9A 44 100 ATTEMPTED INCDECENT LIBERTIES|'+
					          
						'PRED CRM SX ASSL|'+

						
						'SAC-ATTEMPT'
						,				
						
						trim(l.offense_description, left, right),
						0)<>'' => 'SEX',//'SEXUAL_ASSAULT',
						
						//Exact match
						trim(l.offense_description, left, right) = 'DOMESTIC' 		=> 'SEX',
						trim(l.offense_description, left, right) = 'ENTICEMENT' 		=> 'SEX',
						trim(l.offense_description, left, right) = 'MACON COUNTY'		=> 'SEX',
						trim(l.offense_description, left, right) = 'SA' 						=> 'SEX',
						trim(l.offense_description, left, right) = 'SEDUCTION' 			=> 'SEX',
						trim(l.offense_description, left, right) = 'SEX OFFENDER' 	=> 'SEX',
						
					regexfind('0.00 - UNKNOWN|'+
						'1 YR|'+
						'10 MOS SUSP|'+
						'1 YR SUPV PROB|'+
						'13A-4-2 - ATTEMPTED|'+
						'14:24 - PRINCIPAL TO|'+
						'14:27 - ATTEMPTED|'+
						'16-3-655|'+
						'16-15-335 - HIRE PERSON|'+
						'18 3 403|'+
						'18 U.S.C. 2252|'+
						'18-3-403|'+
						'2ND DEGREE RAPS|'+
						'203 - MAYHEM|'+
						'261(A) - SUBPARTS|'+
						'2923.02 - ATTEMPT|'+
						'2900 - UNKNOWN|'+
						'2923.02 - ATTEMPT|'+
						'2923.03 - COMPLICITY|'+
						'2925.02 - TO BE ADVISED|'+
						'30/02|'+
						'3449 HWY 138|'+
						'36699:39/13/PT5|'+
						'39-12-101 - CRIMINAL ATTEMPT|'+
						'545 WASHINGTON ST 2ND FL, COVENTRY, RI 02816|'+
						'5TH DEG NONCONS|'+
						'53A-62 - THREATENING:|'+
						'53-21(A)(1) - RISK OF INJUR|'+
						'7 HOLIDAY COURT|'+
						'80 - ATTEMPT|'+
						'9A.28.020 - CRIMINAL ATTEMPT|'+                                                                                                                                                                                                                                                                                                    	
						'901 - CRIMINAL ATTEMPT|'+
						'99.999 - IN STATE CONVICTION|'+
						'/ATTEMPT/11990004|'+
						'/FEDERAL/|'+
						'[A-Z][A-Z]-FELONY|'+
						'[A-Z][A-Z]-MISDEMEANOR|'+
						//'ABUSE 1ST|'+
						'ABUSE OF A CORPSE|'+
						'ACCESSORY AFTER THE FACT|'+
						'ACCESSORY TO A CRIME|'+
						'ACCOSTING FOR IMMORAL PURP|'+ 
						'ACTIVITIES RE MATERIAL CONST|'+
						'ACTIVITIES RELATING TO MATERIAL CONSTI|'+
						'AGGRAVATED CRIMINAL AGAINST NATURE|'+
						'AGGRAVATED FURNISHING OF SCHEDULED DRUG|'+
						'AGAINST A PESON IN CUSTODY|'+
						'AIDED & ABETTED|'+
						'AIDING & ABETTING|'+
						'AIDING AN OFFENDER|'+
						'ANIMAL CRUELTY|'+
						'ARRALC196360022020121115|'+
						'ARSON|'+ 
						'ARTICLE 120/11990001|'+
						'ARTICLE 134-GENERAL ARTICLE VIOLATION 18|'+
						'ARTICLE 134/POSSESSION, RECEIVING|'+
						'ARTICLE 80: ATTEMPTS|'+
						'ASSIMILATED CRIME ACTS MILITARY|'+
						'ATT.USI|'+
						'ATTEMP USI|'+
						'ATTEMPT DECEMINATE MATERIAL 1ST|'+
						'ATTEMPT-ACCOSTING FOR IMMORAL PURPOSES|'+
						'ATTORNEY GENERAL|'+
						'BATT W/ATMPT TO COMMIT FELONY|'+
						'BATT W/I TO COMMIT SERIOUS FELONY|'+
						'BATT W/INT TO COMM FELONY|'+
						'BENDOM198460214019840811|'+
						'BESTIAL|'+
						'BETWEEN 10/01/07|'+
						'BLACKMAIL|'+ 
						'BISROB197250514020110601|'+
						'BROSTE196550921520121105|'+
						'CALIFORNIA PENAL CODE SECTION 261|'+
						'CARTER198051116520121025|'+
						'CHAMPAIGN COUNTY OHIO SHERIFF|'+
						'CHARGE CORRELATION|'+
						'CHARGE CORRELATON PENDING|'+
						'CHARGE CORRLATION|'+
						'COMMIT A CLASS A CRIME|'+
						'COMMIT NONCAPITAL FELONIES|'+ 
						'COMMUNICATING FOR COMMITTING PRESCRIBED CONDUCT|'+
						'CONCEALED WEAPONS|'+
						'CONDUCT PREJUDICIAL TO GOOD ORDER|'+
						'CONSIPIRACY|'+
						'CONSPIRACY|'+
						'CONTROL SUB|'+
						'CONTROLLED SUB|'+
						'CONVICTED AS A JUVENILE|'+			
						'CONVICTION SET ASIDE|'+
						'CONVICTION WAS SET ASIDE|'+
						'CLANDESTINE LAB|'+
						'CRIM AGAINST NATURE|'+
						'CRIM CONDUCT|'+
						'CRIME AGAINST NATURE|'+
						'CRIME AGANST NATURE|'+
						'CRIME AGAINST PERSON|'+
						'CRIMES AGAINST NATURE|'+ 
						'CRIMES AGAINST PERSON|'+
						'CRIMINA SEXUAL 1ST DEGREE FEAR AND HARM|'+
						'CRIMINAL AGAINST NATURE|'+
						'CRIMINAL ATTEMPT|'+ 
						'CRIMINAL CONDUCT 2ND DEG|'+
						'CRIMINAL CONDUCT IN THE !ST DEGREE|'+
						'CRIMINAL FORFEITURE|'+
						'CRIMINAL MISCHIEF|'+
						'CRIMINAL RESPONSIBILITY FOR CONDUCT OF|'+
						'CRIMINAL RESPONSIBILITY FOR FACILITATI|'+
						'CRIMINAL RESPONSIBILITY TO COMMIT|'+
						'CRIMINAL USE OF COMMUNICATION FACILITY|'+
						'CSC|'+
						'CSE 4TH DEGREE|'+
						'CULTIVATE-DISTRIBUTE-W-INT OPIATES|'+
						'CUSTODIAL INTERFERENCE|'+ 
						'DAYS IN A CORRECTIONAL FACILITY|'+
						'DELIVER METHAMPHETAMINE|'+ 
						'DEPRIVATION OF CIVIL RIGHTS|'+			
						'DEPRIVATION OF RIGHTS UNDER COLOR|'+
						'DESIGNATED A CATEGORY|'+
						'DESIGNATED A LEVEL|'+
						'DESIGNATED A RISK|'+
						'DESIGNATED TIER 3 BY CONF TRIBES OF UMATILLA IND RES OREGON|'+
						'DIAGNOSTIC COMMITMENT UP TO|'+
						'DISORDERLY CONDUCT|'+ 
						'DISORDERLY PERSON|'+
						'DISPLAY DEADLY WEAPON|'+
						'DIST DEL MANUF CONTR SUB|'+
						'DISTRIBUTION OF CONTROLLED SUBSTANCE|'+
						'EAVESDROP|'+
						'EAVESDROPPING|'+ 
						'ELDERLY ABUSE|'+
						'ENGAGED IN PROHIBITED ACTS|'+
						'ESCAPE|'+
						'EVIDENCE TAMPERING|'+
						'EXCLUSION ZONES|'+
						'EXTORTION|'+			
						'FABRICATING PHYSICAL EVIDENCE|'+
						'FACILITATING THE COMMISSION TO COMMIT|'+ 
						'FACILITATION OF A FELONY AGGRAVATED S|'+ 
						'FAMILY VIOLENCE|'+
						'FEDERAL 370|'+
						'FEDERAL BILL|'+
						'FEDERAL CHARGE|'+
						'FEDERAL CONSPIRACTY TO MANUFACT|'+
						'FEDERAL HOBBS ACT|'+
						'FEDERAL MAINTAINING A DRUG INVOLVED PREMISES|'+
						'FEDERAL PROBATION|'+
						'FEDERAL USE OF INTERSTATE FACILITY IN AID OF RACKETEERING ENTERPRISE|'+
						'FEDERAL/1199|'+
						'FEDERAL/3|'+
            'FEMALE.|'+
            'FIRST DEGREE|'+
            'FIRST DEGREE (RELATIONSHIP)|'+
            'FOURTH DEGREE (MULTIPLE VARIABLES)|'+	
						'FIREARM|'+
						'FL CODE F.S. 800.04|'+
						'FORCE/AWD|'+
						'FORGERY|'+ 
						'FREE TEXT|'+
						'FROM THE STATE OF|'+
						'GAMBLING|'+
						'GROOMING|'+
						'GROSS INDECENC|'+ 
						'GSI|'+
						'GUAM/|'+
						'HARMFUL CIRCUMSTANCES|'+
						'IMMORAL ACTS|'+
						'IMMORAL_PRACTICES|'+
						'IMPORT ORIENTAL FEMALE SLAVE|'+
						'IN STATE CONVICTION|'+
						'INJURY TO PUBLIC DECENCY|'+
						'INSANE|'+
						'INTERFERENCE WITH CUSTODY|'+ 
						'INTERSTATE COMMERCE|'+
						'INTERSTATE FACILITIES TO TRANSM|'+
						'INTERFERE WITH CUSTODY|'+
						'INTERFERNENCE WITH CUXTODY|'+
						'INTERFERING WITH THE REPORTING|'+
						'INTIMIDATE WITNESS/VICTIM F2|'+
						'INTIMIDATING|'+
						'INTIMIDATION|'+
						'INVADE, LOOK IN HOLE/OPENING W/INSTRUMENT|'+                                                                                                                                                                                                                                                                                      
						'INVAS OF PRIV|'+                                                                                                                                                                                                                                                                                                          
						'INVASION OF PRIVACY|'+
						'INVASION OF PRIVACTY|'+
						'INVASION OF PRIVCY|'+
						'INVASION PRIVACY|'+
						'INVASION/PRIVACY|'+ 
						'INVASION/PRIVCY|'+
						'KNOWINGLY PERSUADING AN INDIVIDUAL TO|'+
						'LIFETIME SUPERVISION|'+
						'LURING|'+ 
						'MALICIOUS MISCHIEF|'+
						'MANUFACTURE METH|'+
						'MANUFACTURE OF METH|'+
						'MANUFACTURING OF CONTROLLED SUBSTANCE|'+ 
						'MANUFACTURING, CREATING, DELIVERING, OR POSSESSING WITH INTENT TO MANUFACTURE, CREATE, OR DELIVER CO|'+
						'MDSO|'+
						'MENACING|'+
						'MENTAL|'+
						'MILITARY - 99.99M|'+
						'MILITARY CRIME|'+
						'MILITARY-FEL|'+
						'MILITARY OFFENSE|'+
						'MILITARY/1|'+ 
						'MILITARY/3|'+
						'MORALS - DECENCY CRIMES|'+
						'MRALS/PBLIC H/SAFETY|'+
						'MULTIPLE 10 YEAR CONVICTIONS|'+
						'NC ARTICLE 7A SECTION 14-202.1|'+
						'NEGLECT DEPENDENT PERSON|'+
						'NO CHARGES FOUND IN THE RECORDS|'+
						'NO OFFENSE INFORMATION AVAILABLE|'+
            'NO DETAILS AVAILABLE|'+
            'NO VICTIM INFORMATION GIVEN|'+
            'NO VICTIM INFORMATION IS PROVIDED|'+
            'NOT AVAILABLE|'+	
						'NOT A SEX OFFENSE|'+
						'NOT SPECIFIED|'+	
						'NOTIFICATION/NO FIXED ADDRESS|'+
						'NMSA|'+
						'NULL|'+
						'OBSCENE PERF|'+
						'OBSCENITY 3RD|'+
						'OBSCENITY|'+
						'OBSENITY AND RELATED OFF|'+
						'OBSTRUCT/ETC PUBLIC OFFICER|'+
						'OFFENSE CORRELATION|'+
						'OFFENSE NOT LISTED|'+
						'OFFENSE_DESCRIPTION|'+
						'OFFICIAL MISCONDUCT|'+
						'OLD SECTION 27-335A|'+
						'OTHER|'+
						'OTHER CRIME|'+ 
						'OUT OF STATE|'+ 
            'PA 901/3124.1|'+ 
            'PENDING AG INPUT|'+ 
            'PRIOR 290 OFFENSE|'+ 	
						'PEEPING|'+
						'PENNSYLVANIA STATUTE CC3121|'+
						'PEPPING TOM|'+
						'PERSONAL INJURY|'+
						'PERVERSION|'+ 
						'PERVERTED PRACTICE|'+
						'PERVERTED SEX PRACTICES|'+
						'PHYSICAL FORCE VIOLENCE|'+
						'PHYSICAL FORCE/VIOLENCE|'+
						'POSSESSION OF DANGEROUS DRUGS|'+
						'POSSESSION OF PRECURSORS WITH INTENT TO MANUF|'+
						'POSSESSION, RECEIPT AND DISTRIBUTION O|'+
						'PUERTO RICO - 99.99P|'+
						'PREPARE DISRIBUTE MATERIALS|'+
						'PRINCIPAL ATTEMPT|'+
						'PRIVATE INDECENCY|'+
						'PRIVT INDECENCY|'+
						'PROHIBITED ACT|'+
						'PROHIBITION OF CERTAIN ACTS IN CONNECTION WITH OBSCENITY|'+ 
						'RECEIVING STOLEN PROPERTY|'+
						'RECKLESS CONDUCT|'+
						'RECKLESS ENDANGERMENT|'+
						'REPEALED|'+
						'RISK OF INJURY|'+
						'SAME AS ABOVE|'+
						'SCH DRUGS|'+
						'SCHEDULE DRUGS|'+
						'SECTION 566.040|'+
						'SERVED APPROXIMATELY 12 1/2 YEARS IN A CORRECTIONAL FACILITY|'+
						'SET UP TO MEET THE VICTIM|'+
						'SEX OFFENDER SEEK TO CHANGE NAME|'+
						'SEX WITH ANIMAL|'+ 
						'SEXUALLY EXPLICIT CONDUCT|'+ 
						'SHOOTING FROM A MOTOR VEHICLE|'+
						'SIGNIFICANT RELATIONSHIP|'+
						'SINGLE PROCEEDING/MULTIPLE VICTIM OF FELONIES|'+
						'STALKING|'+
						'STOLEN PROPERTY|'+
						'STRANGULA|'+
						'SUFFOC|'+
						'SUPPRESS RIOT|'+
						'SURREPTITIOUS INTRUS|'+
						'SURREPTITIOUS VISUAL OBSERV|'+ 
						'SURVEILLANCE|'+ 
						'SURVEILLING|'+ 
						'SECOND DEGREE (MULTIPLE VARIABLES)|'+ 
            'SUBPARTS|'+ 
            'THIRD DEGREE|'+ 
            'THREATS TO INJURE|'+ 
						'TAMPERING WITH WITNESS|'+
						'TAMPERING W/WITNESSES|'+
						'TERRORIST THREATS|'+
						'TERRORISTIC THREATS|'+ 
						'TERRORIZING|'+
						'TEST RECORD|'+ 
						'THREAT OF INCENDIARY|'+
						'TIER LEVEL 3 NEVADA|'+
						'TO BE ADVISED|'+
						'TO BE USED WHEN NO CODE FITS|'+
						'TRAVEL IN INT/ COMMERCE FOR THE PURPOS|'+
						'TRAVEL WITH INTENT|'+ 
						'TRESPASS|'+ 
						'TURNER/ TIFT COUNTY|'+
						'UCR_CODE: 07/17/1996 CRIMELOCATION|'+
						'UCR_CODE: 1199 CRIMELOCATION|'+
						'UCR_CODE: CRIMELOCATION|'+
						'UNAVAILABLE|'+
						'UNIFORM CODE OF MILITARY|'+
						'UNKNOWN OFFENSE|'+
						'UNLAWFUL SALES OF CONTROLLED SUBSTANCE|'+ 
						'UNLAWFUL SALES/MANUFACTURING/DISTRIBUTION OF CONTROLLED SUBSTANCE|'+ 
						'UNLAWFUL USE OF A WEAPON|'+
						'UNLAWFUL WOUNDING SERVED APPROXIMATELY|'+
						'UNNATURAL - PERVERTED SEXUAL ACT|'+
						'UNNATURAL AND PERVERTED SEX PRACTICE|'+
						'UNNATURAL_LASCV_ACTS|'+
						'UNNATURAL_LASC_ACTS|'+
						'UNSURE OF OFFENSE DATE|'+
						'USC 3RD|'+
						'USE OF INTERSTATE FACILITY TO CARRY ON UNLAWFUL ACTIVITY|'+
						'USE OF MAIL, FAC, MEANS OF INTER/ COMM|'+
						'VICTIM ADVISED IF WAS FORCED|'+
						'VIOLATION OF PRIVACY|'+ 
						'VIOLATION_OF_PRIVACY|'+
						'VIOLATION/INVASION OF PRIVACY|'+ 
						'VIOLENT CRIME - USE OF A WEAPON|'+
						'VOEURISM|'+                                                                                                                                                                                                                                                                                                                        
						'VOYERISM|'+                                                                                                                                                                                                                                                                                                                       
						'VOYEURISM|'+
						'VOYUERISM|'+
						'WANTON NEGLECT|'+
						'WEAPONS - TASER|'+
						'WILLFUL INJ|'+
						'WV 61-8C-3 POSSESS, DISPLAY AND TRANSPORT|'+
						'WY - IMMORAL ACTS|' +	
						'LISTED AS TIER 3 BY NEW HAMPSHIRE|' +
						'RETALIATION AGAINST WITNESS/VICTIM - SEXUAL FACTUAL BASIS (2006).|' +
						'847.0135(2) - PRINCIPAL|' +						
						'847.0135(2) - PRINCIPAL|' +                                                                                                                                                                                                                                                                                                         
            '99.99M|' +                                                                                                                                                                                                                                                                                                                          
            '99.99P|' +                                                                                                                                                                                                                                                                                                                          
            '99.99P (ATTEMPTED)|' +
						'ATTEMPT (TO COMMIT ANY OF THE FOREGOING)|' +                                                                                                                                                                                                                                                                                        
            'BU001 - UNKNOWN|' +        
						'CONDUCT CAUSING FEAR TO A PERSON OR A PERSONS FAMILY|' +
						'13A-6-66|' +
						'18-3-405.3(1)(2)(A)|' +
						'1ST DEGREE|' +
						'1ST DEGREE X3|' +
						'2ND DEGREE|' +
						'30.02 (D)|' +
						'36699:39-13-PT5|' +
						'3RD DEG|' +
						'3RD DEGREE|' +
						'4TH DEG.|' +
						'4TH DEGREE|' +
						'750.520E1A-A|' +
						'9A.44.079|' +
						'A MISDEMEANOR|' +
						'ADDED 12-11-01|' +
						'ADDED 8-1-00|' +
						'AGGRAVATE|' +
						'AGGRAVATED CRIMINA|' +
						'AIDING AND ABETTING|' +
						'ARTICLE 134--POSSESSION|' +
						'ATTEMPT (TO COMMIT ANY OF THE FOREGOING)|' +
						'BREACH OF PRIVACY; INTERCEPT MESSAGE WITHOUT CONSENT|' +
						'C FELONY|' +
						'C/L|' +
						'CAUSE|' +
						'CC3123-5|' +
						'CLASS D OR E|' +
						'CLASS D OR E FELONY|' +
						'COMMERCE|' +
						'COMMITTED|' +
						'CONDUCT CAUSING FEAR TO A PERSON OR A PERSON\'S FAMILY|' +
						'CONTACT|' +
						'CONVERSATION|' +
						'CONVINNM|' +
						'COUNT 5 ADDED 9-24-01|' +
						'CRIME AGAINS NATURE|' +
						'CULTIVATE/DISTRIBUTE/W/INT OPIATES/OPIUM/NARC DRUG AND CERTAIN STIMULANTS|' +
						'CUSTODIAN|' +
						'DEFT FOUND GUILTY OF THIS LESSER NON-INC|' +
						'DIRECT|' +
						'DISTRIBUTE CERTAIN HALLUCINOGENS|' +
						'DISTRIBUTE OPIATES, OPIUM, NARCOTICS OR STIMULANT; UNKNOWN QUANTITY|' +
						'FAC|' +
						'FELONY|' +
						'FOREIGN COMMERCE|' +
						'HAD NOT ESTABLISHED RELATIONSHIP.|' +
						'HARM|' +
						'HIMSELF TO HER ON NUMEROUS OCCASIONS|' +
						'HOUSE|' +
						'INDUCE|' +
						'JUNE|' +
						'LESSER INCLUDED|' +
						'MALE|' +
						'MALICIOUS PUNISHMENT|' +
						'MITIGATE|' +
						'MITIGATED|' +
						'MORE THAN ONE OCCASION|' +
						'NONE REPORTED,|' +
						'NONE REPORTED,|' +
						'O|' +
						'OBJECT|' +
						'OF AGE|' +
						'OFF|' +
						'OFFENDER NOT P|' +
						'OFFENDER NOT PARENT|' +
						'OFFICIAL OPPRESSION|' +
						'OR|' +
						'OR AGGRAVATED|' +
						'OR W/FORCE|' +
						'POSS|' +
						'RECEIVING|' +
						'REPORTS ADULT FEMALE|' +
						'REPROD/SELL|' +
						'SALE ETC. OF OPIATES, OPIUM OR NARCOTIC DRUGS; 1ST OFFENSE|' +
						'SEC 11-1.2 FORMERLY 720 ILCS 5/12-13|' +
						'SECOND DEGREE|' +
						'STRONG ARM|' +
						'VI|' +
						'VICTIM UN|' +
						'WITNESS/VICTIM-TAMPERING WITH|' +
						'18-3-405.3(1)(2)(A)|' +
						'30.02 (D)|' +
						'18-3-405.3(1)(2)(A)|' +
            '30.02 (D)|' +
            'ADDRESS|' +
            'MEDICAL EXAM, ETC.|' +
            'PHYSICALLY HELPLESS|' +
            'PREVENTS RESISTANCE|' +
            'THREAT/DEATH|' +
            '720ILCS5/12-14|' +
            '18-3-405.3|' +
            '720 ILCS 5/11-9.1B|' +
            'BRIBERY|' +
            '30.02|' +
            'QUARTERLY|' +
            'UNK|' +
            'ADDED 5/10/02|' +
            '847.0135\\(2\\) - PRINCIPAL|' +
						'DEGREE X3|' +
						'ARTICLE|' +
						'290\\(B\\) - LIFETIME|' +
						'F.S. 847.0135|' +
						'ATTEMPT 1ST DEGRE|' +
						'DEFECTIVE|' +
						'DEGREE|' +
						'C265 S23|' +
						'288 (A)|' +
						'14 C265 S13B|' +
						'GINGERICH|' +
						'ARS 4-244(9)|' +
						'ATTEMPT (ATTEMPTED)|'+
            '3669939-13-PT5|'+
            'BAD BAD BAD|'+
            'VYEURISM|'+
            'BIGAMY|'+
            'FEDERAL PRBATIN|'+
            'WV 61-8C-3A|'+
            'INTERFERNENCE WITH CUXTDY|'+
            'ARS 4-244(9)|'+
            'DEPRIVATIN F RIGHTS UNDER CLR F LAW|'+
            'ATTEMPT (ATTEMPTED)|'+
						'ARS 4-244(9)|'+
						'UNNATURAL ACTS|'+
						'LA|'+
            'ATTEMPT (ATTEMPTED)|'+
						'ACT: >48|'+
						'2907.322(A)(5)|'+
						'ARS 4-244(9)|'+
						'3RD|'+
						'M1|'+
						'TEXAS PC 22.011 \\(A\\) \\(1\\)|'+
						'2907.322\\(A\\)\\(5\\)|'+
						'ARS 4-244\\(9\\)|'+
						'ATTEMPT \\(ATTEMPTED\\)|'+
						'MILITARY FEDERAL CRIME|' +
						'MT 45-5-622|' +
						'DE11077000A1FC|' +
						'CA|' +
						'720ILCS5/12-15\\(AZ\\)|' +
						'647.6(A)(1)|' +
            'GA|' +
            '2ND DEG|' +
            '130.65 SUB 03|' +
            '647.6\\(A\\)\\(1\\)|' +
						'6-2-315 \\(A\\) \\(1\\)|' +
						'SENTENCED AS ADULT|' +
						'RACKETEERING|'+
						
						'ISSUING BAD CHECKS|'+
						'WITNESS TAMPERING|'+
						'SALE C/DRUG|'+
						'N/A|'+
						
						'ISSUING BAD CHECKS|'+
						'16-6=4 \\(C\\)|'+
						'SALE N/DRUG|'+
						'DRIVE AFTER REV/SUS|'+
						'CNTRL DRUG; MARIJ/HASH|'+
						'DRIVE AFTER REV/SUS|'+
						'D001 1996CR920|'+
						'SALE N/DRUG-CRIM LIAB|'+
						'INTERFERE W/CEMETARY|'+
						'FL794.041|'+
						'FL794.011 \\(2A\\)|'+
						'CNTRL DRUG; MARIJ/HASH|'+
						'18-3-402\\(1\\)\\(B\\)|'+
						'DUI AGGRVTD|'+
						'PRINCIPAL|'+
						'PA 18 \\? 6312 \\?\\?D|'+ 
						'INVADE PRIVACY|'+	
						'MILITARY/FEDERAL RELEASE|'+ 
            '18 U.S.C 2252A\\(A\\)\\(2\\)\\(A\\)|'+ 
						
						'TIER 1|'+	
						'HANDGUN|'+	
						'TIER 2|'+	
						'750.520CIA|'+	
						'11-37 B 1\\(\\)|'+	
						'AS11.41.438\\(A\\)\\(1\\)|'+	
						'VA|'+	
						'WELD|'+	
						'RSA 649-B:3|'+	
						'FL800.04|'+	
						'632-A:3|'+	
						'RSA 632-A:2|'+	
						'18 USC 2252A\\(A\\)\\(2\\) AND 18:2256\\(A\\)\\(2\\)&AMP;\\(8\\)\\(A\\)|'+	
						'RSA 632-A:2|'+	
						'DUI - IMPAIRMENT|'+
						'UCMJ ART 134|'+

						'ENTERED BY MISTAKE|'+
						'D0622012CR000238|'+
						'D0622015CR001097|'+
						'D0622015CR001339|'+
						'DE1111110000FF\\(\\)|'+
						'TIME.|'+
						'D0222007CR000271|'+
						'D0392016CR005553|'+						
					
						'LCD_DS|'+		
						'750.520E1|'+		
						'18-3-405 CSA|'+		
						'18-3-405 CSA|'+		
						'INDECENT A&AMP;B|'+		
						'DELETE|'+		
						'16-6-3\\(B\\)|'+		
						'CRG READS: 18-2-101 & 18-3-405 CRIM ATTE|'+		
						'D0301996M 004635|'+		
						'D0302005CR004409|'+		
						'ART UCMJ 120B DIBRS 120BB3|'+		
						'D0621999CR000953|'+		
						'18-6-401\\(1\\),\\(7\\)\\(B\\)\\(I\\)|'+		
						'D0622005CR001337|'+		
            'T17-A 253\\(1\\) \\(B\\)|'+		
            'TENN STING|'+		
						
            'NEW JERSEY;|'+
						'ATTEMPT;|'+
						'AGRAVETED;|'+
						'38-12-14-A|'+
						'NEW HAMPSHIRE|'+
						'13A-6-64|'+
						'22 021 A1 B\\(\\)|'+
						'ATTEMPT;|'+
						'632-A:2 II|'+
						'INDICTMENT NUMBER CP870011443;|'+
						
						'FRAUD|'+
						'18USC2252A\\(A\\)\\(5\\)\\(B\\);|'+
						'130.50 SUB 01;|'+
						'MAINE|'+
						'LIFETIME|'+
						'MANUF/DELIVER AMPHETAMINE \\(<=3G\\)|'+
						'ATTEMPTED \\(ATTEMPTED\\)|'+
						
						
						
						'16-6-4-\\(B\\)'						
						,						
						trim(l.offense_description, left, right),
						0)<>'' => 'OTH',//'OTHER',
					
					//Exact match
					trim(l.offense_description, left, right) = '8-4(A) - ATTEMPT' 				=> 'OTH',	
					trim(l.offense_description, left, right) = '11-37 B 1' 								=> 'OTH',	
					trim(l.offense_description, left, right) = '14.27 - ATTEMPTED' 				=> 'OTH',
					trim(l.offense_description, left, right) = '261(A) - SUBPARTS' 				=> 'OTH',
					trim(l.offense_description, left, right) = '2ND' 											=> 'OTH',
					trim(l.offense_description, left, right) = '2ND DEGREE'								=> 'OTH',
					trim(l.offense_description, left, right) = '2ND DEGREE(2ND DEGREE)'		=> 'OTH',
					trim(l.offense_description, left, right) = '2ND DEGREE SEXUAL DEGREE' => 'OTH',
					trim(l.offense_description, left, right) = 'ABUSE 1ST' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'ATTEMPT' 									=> 'OTH',
					trim(l.offense_description, left, right) = 'ATTEMPTED' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'ATTEMPTED/36010001' 			=> 'OTH',
					trim(l.offense_description, left, right) = 'ATTEMPTED AGGRAVATED' 		=> 'OTH',
					trim(l.offense_description, left, right) = 'ATTEMPTS' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'COMPLICITY'								=> 'OTH',
					trim(l.offense_description, left, right) = 'FACILITATION'							=> 'OTH',
					trim(l.offense_description, left, right) = 'FAMILY OFFENSE'						=> 'OTH',
					trim(l.offense_description, left, right) = 'FEDERAL' 									=> 'OTH',
					trim(l.offense_description, left, right) = 'GUAM' 										=> 'OTH',	
					trim(l.offense_description, left, right) = 'INDECENT' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'INTIMIDATION' 						=> 'OTH',	
					trim(l.offense_description, left, right) = 'MILITARY' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'MINNESOTA' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'MOVE' 										=> 'OTH',
					trim(l.offense_description, left, right) = 'OBSCENITY' 								=> 'OTH',	
					trim(l.offense_description, left, right) = 'POSSESSION' 							=> 'OTH',
					trim(l.offense_description, left, right) = 'RECEIVE OR DISTRIBUTE' 		=> 'OTH',
					trim(l.offense_description, left, right) = 'SEX_' 										=> 'OTH',
					trim(l.offense_description, left, right) = 'STATUT' 									=> 'OTH',
					trim(l.offense_description, left, right) = 'STATUTORY' 								=> 'OTH',
					trim(l.offense_description, left, right) = 'TESTING' 									=> 'OTH',
					trim(l.offense_description, left, right) = 'TRANSPORT OR SHIP' 				=> 'OTH',
					trim(l.offense_description, left, right) = 'UNKNOWN' 									=> 'OTH',
					trim(l.offense_description, left, right) = 'WYOMING' 									=> 'OTH',
          trim(l.offense_description, left, right) = 'A'     => 'OTH',					
					
					trim(l.offense_description, left, right) in ['ARRALC196360022020121115','ATTEMPT 1ST DEGREE','BARKIM196660118920131111','BARSAM196851116020120808','BEADAN197550719520130828','BLADAV196750822320130712','BLADAV196750823020130712','BONALB198460015420130101','BONALB198460016420130101',
						'BONALP197550716020130225','BROCHR199250917020121214','BROCHR199250917220121214','BROKEN196750916320121114','BROMAR197351015020000717',
						'BROSAM196450515520121109','BUREDW195951120020001128','BUREDW195951135020001128','BUTSHA198460122520121129','CANKEV198151016520121207','CANKEV198151019520121207','CARROB197360017520121204','CARROB197360018020121204',
						'CAUDON196351117020130108','CHARGE COORRELATION PENDING','CLASS C FELONY','CLASS C FELONY(18 U.S.C. 1470)','COODAV196350722020120812','CONTIM197550625420121105',
						'CRAJAM199060622520121018','CURJAM196951038020121108','CURLON197950814020121024','DEEJAM198450919520051223','DEEJAM198451023220051223','DIGMIC196050315020121018',
						'DONPAU198760421520121003','DRUWIL196960318220121219','EDAPAT198451017020121103','EXLBRU198450614020121019','EXLBRU198450615020121019',
						'FLAGAV194850917020121105','FRACHR198550922820131206','FRAGRE198551023020130421','FRAGRE198551023120130421','GANKEV196951015020130108','GANKEV196951017020130108','GANKEV196951017520130108','GAVFLA194850917020121105','GLALAM196350716520130711','GUSDEL198850620520121030',
						'HALCHA195851018020121231',
						'HAMRIC197850917720121019','HANEST198450721520121022','HANEST198450721620121022','HANEST198450823320121022','HARBIL197960118520121204','HARBIL197960222020121204','HARJEF196450926520130401',
						'HECCHR199160318020130828','HENLAN195150719520131206','HENZAC199251018020121121','HILTHO196960121520120417','HOCJAK195251020020070628',
						'HILTHO196960121020120417','HOLBRA198850915020121217','HOUERI199050715520121115','HOUPRE199351018520121207','HUFBAR196360016820121211','INZARG199050817020121206',
						'JACSTA197960121020130104','JOHMAR19925007320121018','JOHMAR19925007820121018','JOHMAT198860020020130101','JORKEI195850819519991119','KELTHO194150516020121031','KNIFE','KNIFE(KNIFE)','LANWIL196950914020121122',
						'LILJOS198760021920121003','LLOCAR197851130520130923','LUCQUI198760218520121011','MANLAR198160319020121104','MAYTYL199250715820120808','MCBSHA197550820420091109',
						'MCGHEN195750818020130116','MCCSAN197860214520101206','MCCKYM197651121520121012','MCCTIF199350613020130108',
						'MCCTOM195950918620130117','MCCWIL198451117520130724','MCDDAN197150514020121029','MCDROB194450816020121223','MCKRIC195950615520121011',
						'MEDALE199450518020121219','MEEJAM199350914520130101','MEILOU196850821520121024','MILTIM198951114020090303','MULTIPLE 10 YEAR CONVICTIONS','MURTIM196450619020121022','MURTIM196450720120121022',
						'NESWIL195250820520080818','NESWIL195250823020080818','OATNAT197351026519980730','ONTALB198050818020130104','PADWIL196460422420121210','PARJOA194750515820131202',
						'PERWIL196050817020121201','PORROB195350916820130821','RADTRA196851119020121122','RAMROB197150314020130924','RAZOR','RAZOR(RAZOR)','REEJAM196260120020121204','RELMIC199160216120121214',
						'REYROB195851017019980806','RICROB197760118020121105','RUICHR198250417020131010','RUIJOS198851017520130909','SANJOH195960325320121106','SCOCHR197560020120121218','SCODAV197051018520130618','SCOJUS198660520520121024',
						'SEAWAL197951114020121112','SEAWAL197951117820121112','SEGEST195650918120130909','SEIJUL195650715020121017','SIMWIN194460025320131104','SINDEL197550616020130101','STRJER197950921020121003',
						'SWEJAS197550815520131107','SWIWIL195160318020041216','TATGER195850718020121011','THEDAV196651122020090721','THEDAV196651124020090721','THOTIM198150815520121017','TOOJAM196350715020121009','VANLES196851116520121211',
						'WADBEN199350916520121017','WALJAM193550617820121024','WALJAM193550620020121024','WALJAM193550618020121024','WALSAM198650616520130719','WEADAV198360214020121005','WEAJOH198350917020130410','WASHINGTON RISK LEVEL 3',
						'WHICUR198050913020121219','WILCHA198950714020121214','WILHAR194651125920090206','WILSEA198151022020131031','WILWIL193860218020130910','WITJUL195650916520121119','WOOAND196051116520121011','WOOAND196051119020121011','WOOCOR196760125020121219',
						'WOOCOR196760130020121219','YAWANT195750920020121102'] => 'OTH',
					
					regexfind('[A-Z]',	
						trim(l.offense_description, left, right),
						0)='' => 'OTH',//'OTHER',
						''));
	
	category_2 := (map(					regexfind('A&B CHILD|'+
						'ABUSE OF A CHILD|'+
						'ANNOY__MOL_VIC_<_18|'+
						'ASLT-CHILD|'+
						'CHILD FOR SEX|'+
						'CHILD MOLES|'+
						'CHILD PORN|'+
						'CHILD TO ENGAGE IN SEXUAL CONDUCT|'+
						'CHILD / SEX|'+
						'CHILD/SEX ACT|'+
						'CHLD SEX|'+
						'CORRUPTION OF A MINOR AND|'+
						'INCEST WITH CHILD/MINOR|'+
						'INDECENT BEAHVIOR WITH JUV|'+
						'INDECENT LIBERTIES WITH A MINOR|'+
						'INTERCOURSE WITH A CHILD|'+
						'INTERCOURSE WITH PERSON LESS THAN|'+
						'INTRCOURSE W/MINOR|'+
						'MATERIAL WHICH EXPLOITS MINORS|'+
						//'JUVENILE|'+
						//'MINOR|'+
						'RAPE AGAINST A CHILD|'+ 
						'RAPE AND ABUSE OF CHILD|'+ 
						'RAPE AND CARNAL KNOWLEDGE OF A CHILD|'+ 
						'RAPE FOURTH DEGREE SEXUAL INTERCOURSE VICTIM IS LESS THAN|'+ 
						'RAPE OF A CHILD|'+ 
						'RAPE THIRD DEGREE SEXUAL PENETRATION VICTIM UNDER|'+ 
						'RAPE, SEXUAL INTERCOURSE WITH A CHILD|'+ 
						//'RAPE???VICTIM IS UNDER |'+X|'+ YEARS OF AGE|'+ 
						//RAPE???VICTIM LESS THAN |'+X|'+ YEARS OLD|'+ 
						'SEX ABUSE OF CHILD|'+
						'SEX TRAFFIC CHILD|'+
						'SEX TRAFFICKING MINOR|'+
						'SEX TRAFFICKING OF A MINOR|'+
						'SEX W MINOR|'+
						'SEX W/MINOR|'+
						'SEXUAL CONTACT WITH MALE & FEMALE VICTIMS (AGE 3-ADULT)|'+
						'SEXUAL CONTACT WITH VICTIMS (FEMALES, AGE 7-ADULT)|'+
						'SEXUAL EXPLOITATION OF A CHILD/SEXUAL ASSAULT|'+
						'SEXUAL EXPLOITATION OF A MINOR|'+
						'SEXUAL TERCOURSE WITH MOR|'+
						'SEXUAL TRAFFICKING MINOR|'+
						'SEXUAL TRAFFICKING OF A MINOR|'+
						'SODOMY W/PERSON UNDER 18|'+ 
						'SODOMY WITH A MINOR|'+ 
						'SODOMY WITH CHILD >|'+ 
						'SODOMY WITH PERSON UNDER|'+ 
						'SODOMY WITH/ON A CHILD|'+ 
						'TRAFFICKING IN/OF CHIL|'+
						'UNDER AGE 18 TO ENGAGE IN SEXUAL ACTIVITY|'+	
						'UNLAWFUL VIDEOTAPING OF A MINOR|'+	
						'USE OF COMMUNICATION SYSTEMS TO FACILITATE CERTAIN OFFENSES INVOLVING CHILDREN|'+
						'W-CHILD|'+
						'CALIFORNIA CONVICTION INVOLVING A 5 YR OLD FEMALE|'+
            'UNDER/16 MIAMI DADE FL;|'+				
						
						'CONVICTED IN THE STATE OF IOWA FOR SEXUALLY ABUSING THREE MALE VICTIMS, AGES 5, 11, AND 15. SUBJECT'
						
						,
						trim(l.offense_description, left, right),
						0)<>'' and
						regexfind('EXPLOITATION OF A MINOR', trim(l.offense_description, left, right), 0)=''	
						=> 'SAM',//'SEXUAL_ASSAULT_MINOR',
	
					regexfind('COMPUTER AIDED SOLICITATION|'+ 
						'DEPICTING MINOR/SENT TO MINOR/INTERNET|'+ 
						'ELECTRONIC SEXUAL SOLICITATION|'+ 
						'ONLINE SOLICIT MINOR|'+ 
						'SEDUCTION OF MINOR/ELEC.MAIL/INTERNET|'+ 
						'SEX BATT/SOLICIATION OF CHILD|'+ 
						'SEXUAL SOLICITATION OF A CHILD UNDER 16 TO ENGAGE IN PROHIBITED SEXUAL ACT|'+ 
						'SOLICIT|'+	
						'UNDERCOVER SOLIT|'+
						'USE INTERNET TO SOLICIT|'+ 
						'PRSTITUTIN - SLICITATIN 6-4-102|'+
						'USE F CMPUTER T SLICIT MINR|'+
						'CMPUTER AIDED SLICITATIN F A MINR LA|'+

						'USE OF COMMUNICATION SYSTEM TO SOLICIT',
						trim(l.offense_description, left, right),
						0)<>'' => 'SOL',

					regexfind('FELONIOUS RESTRAINT AGAINST A MINOR|'+
						//'RESTRAIN|'+
						'SEXUAL BATTERY INVOLVING RESTRAINED PERSON|'+ 
						'UNL RESTRAINT LESS THAN 17 YRS OF AGE|'+
						'SEXUAL BATTERY/RESTRAINT',
						trim(l.offense_description, left, right),
						0)<>'' and
						regexfind('SEXUAL BATTERY INVOLVING RESTRAINED PERSON', trim(l.offense_description, left, right), 0)=''
						=> 'RES',//'RESTRAINT',
						 
					regexfind('CORRUPTION OF A MINOR/RAPE|'+ 
						'CORRUPTION OF A MINOR/SEXUAL INTERCOURSE|'+ 
						'CORRUPTION OF MINOR (STAT RAPE)|'+ 
						'CORRUPTION OF MINOR UNLAWFUL SEX|'+ 
						//'CORRUPTION OF MINOR|'+
						'CRIMINAL SOLICITATION - INVOLUNTARY DEVIATE SEXUAL INTERCOURSE|'+ 
						'INTERCOURSE WITHOUT CONSENT|'+	
						'INTERSTATE TRANSPORTATION OF MINOR FOR PURPOSE OF SEXUAL ACT - STATUTORY RAPE|'+
						'INVOLUNTARY DEVIANT SEXUAL INTER|'+	
						'RAEP|'+
						'RAPE|'+
						'SODOMY|'+
						'ORAL COP|'+
						'SLICITATIN T CMMIT SDMY|'+
            'SLICITATIN F SDMY|'+

						'UNLAWFUL SEXUAL INTERCOURSE',
						trim(l.offense_description, left, right),
						0)<>'' => 'RAP',//RAPE
					
					regexfind('ABUSIVE MATERIAL|'+
						'ATTEMPTED FURN PORNO/ATMPT TO MINOR|'+ 
						'CHILD SEXUALLY ABUSIVE ACTIVITY-DISTRIBUTING OR PROMOTING|'+
						//'CONTAINING MINORS ENGAGED|'+
						'DEPICTIONS OF MINORS|'+
						'DISPLAY TO MINOR OF OBSCENE MATTER|'+ 
						'DECEMINATE MATERIAL|'+
						'DISSEMINATE INDECENT MATERIAL TO MINORS|'+
						'DISSEMINATE OBSCENE MATERIAL TO A MINOR|'+ 
						'DISSEMINATING INDECENT MATERIAL|'+ 
						'DISSEMINATION OF SEXUALLY ORIENTED MATERIAL TO CHILDREN|'+ 
						'DISTRIBUTE & EXIBIT OBSCENE MATERIAL TO MINOR|'+ 
						'DISTRIBUTE EXPLICIT MATERIAL TO MINOR|'+ 
						'ENDANGERING THE WELFARE OF A CHILD BY POSSESSING CHILD PORNOGRAPHY|'+ 
						'EXHIBITING OBSCENE VIDEO TO MINOR|'+
						'EXPLICIT MATERIAL|'+
						'EXPLT SEX MATL|'+                                                                                                                                                                                                                                                                                                          
						'FILM|'+
						'FURNISHING OBSCENITY|'+
						'GRAPHIC IMAGES|'+                                                                                                                                                                                                                                                                                            
						'ILLEGAL USE NUDITY OF A MINOR|'+ 
						'IMAGES OF CHILD|'+
						'INDECENT ACTS WITH A MINOR & CHILD PORNOGRAPHY|'+
						'MATERIAL DEPICTING|'+
						'MATERIAL HARMFUL TO MIN|'+
						'MATERIALS INVOLVING SEXUAL|'+                                                                                                                                                                                                                                                                                           
						'MTRL INVOL SEX EXPLOIT|'+
						'MTRL TO MINOR|'+
						//'NUDITY|'+
						'NUDITY ORIENTED MATERIAL|'+
						'OBS MTR|'+
						'OBSC ITEMS|'+
						'OBSCENE MAT|'+
						'OBSCENE MATERIAL TO MINOR|'+ 
						'OBSCENE WRIT|'+
						'OBSCENITY - PROMOTION TO MINOR|'+
						'OBSENITY MATERIAL|'+
						'PANDERING OBSCENITY|'+
						'PANDER SEXUAL ORIENTED MATERIAL TO A MINOR|'+ 
						'PHOTO|'+
						'PORN|'+
						'POSS MATER|'+
						'POSESSION OF MATERIAL|'+
						'POSSESSION OF SEXUALLY EXPLOITATIVE MATERIAL|'+
						'PRN|'+
						'PRODUCE A PERFORMANCE|'+
						'PRODUCE DIRECT SEXUAL WITH MIN|'+
						'PROMOTING A MINOR IN AN OBSCENE PERFORMANCE|'+ 
						'PROMOTING OBSCENITY TO MINOR|'+ 
						'PROMOTION OF OBSCENITY|'+
						'PROV.OBSCENE MAT|'+
						'RECEIPT OF OBSCENITY|'+
						'RECEIVING MAIL SEXUALLY EXPLIC|'+
						'SEND/BRING/DISTRIBUTE(DSTRBT) OBSCENE MATTER(MTR) DEPICT(ING) MINOR TO A MINOR|'+ 
						'SEX MATERIAL|'+	
						'SEXUAL ABUSE OF CHILDREN-PHOTOGRAPHING, VIDEOTAPING|'+ 
						'SEXUAL ABUSE/KIDNAPPING AND USE OF A MINOR IN FILMING SEXUALLY EXPLICIT CONDUCT|'+ 
						'SEXUAL ASSAULT AND 2 COUNTS POSESSION OF MATERIAL DEPICTING MINORS ENGAGED IN SEXUALLY EXPLICIT CONDUCT|'+ 
						'SEXUALLY EXPLICATE MATERIAL|'+	
						'SEXUALLY EXPLICIT MATERIAL|'+
						'SEXUAL EXPLOITATION OF A CHILD- PHOTOGRAPH FILM IN SEXUAL ACT OR SIM|'+ 
						'SEXUAL EXPLOITATION OF A CHILD- PHOTOGRAPH FILM IN SEXUAL ACT OR SIMULATION|'+ 
						'SEXUAL EXPLOITATION OF A CHILD- PUBLISH BOOK/MAG/PAMPHLET/PHOTO|'+ 
						'SEXUAL EXPLOITATION OF CHILD, FILM/MAGAZINE/PRINTED|'+ 
						'SEXUAL PERF BY CHILD UNDER 14 YRS PRODUCE/DIR/PROMO|'+
						'SEXUAL PERF BY CHILD UNDER 14YRS EMPLOY/DIR/PROMO|'+
						'SEXUAL PERFORM CHILD PRODUCE/DIRECT/PROMOTE|'+
						'SEXUAL PERFORM CHILD-POSSESSION|'+
						'SEXUAL PERFORMANCE BY A CHILD POSS|'+
						'SEXUALLY ORIENTED MAT|'+
						'SHOW PORN TO CHILD|'+ 
						'SHOWING VICTIMS PORNOGRAPHIC FILMS|'+
						'SHOWING VICTIMS PORNOGRAPHY|'+
						'SHOWING VICTIMS PORNOGRAPHY/PORNOGRAPHIC FILMS|'+ 
						'SHOWING/TRANSFER/TRANSPORT OF OBSCENE MATERIAL TO MINOR|'+
						'TAKING NUDE PHOTOS|'+ 
						'TRANS DIST REPRO POSSESS VIS D|'+
						'TRANSPORTING MATERIAL SEXUAL E|'+
						'USE OF A MINOR IN FILMING SEXUALLY EXPLICIT CONDUCT|'+
						'USE ELECTRONIC MEANS FOR CHILD SEX CRIME OR PORN|'+ 
						//'USE OF COMPUTER|'+ 
						'USE OF INTERNET TO TRANSPORT OBSCENE PICTURES|'+ 
						'VIDEO|'+
						'DISTRIBUTIN F BSCENE MATTER T MINIRS|'+
            'DISSEMINATE BSCENE MATERIAL T MINR|'+
						'TRANFER F BSCENE MATERIAL T MINRS|'+
						'USE F MINRS FR BSCENE MATERIAL R EXHIBITIN|'+
						'DISTRIBUTIN F BSCENE MATTER T A MINR|'+
						'2907.323A3/ILLEGAL USE F A MINR IN NUDITY RIENTED MATERIAL R PERFRMANCE|'+
						'CMPUTER PRNGRAPHY|'+
						'DISTRIBUTIN F BSENITY MATERIAL T A MINR|'+
						'USE F A MINR IN PRDUCING PRNAGRAPHY|'+

						'VISUAL DEP',
						trim(l.offense_description, left, right),
						0)<>'' => 'POR',//PORNOGRAPHY
					
					regexfind('EXHIBIT GENITALS|'+
						'EXPOSE ORGANS|'+ 
						'INDECENCY W/A CHILD EXPO|'+
						'INDECENCY W/CHILD EXPOSES|'+
						'INDECENT EXPOSURE|'+
						'INDECENT LIBERTIES W CHILD- EXPOSURE|'+
						'KIDNAPPING, INDECENT EXPOSURE|'+ 
						'LASCIVIOUS EXHIBITION|'+
						'LEWD OR LASCIVIOUS CONDUCT EXPOSUR|'+
						'LEWD, LASCIVIOUS BEHAVIOR-EXPOSURE|'+
						'PUB SX INDEC|'+
						'PUBLIC INDEC|'+
						'PUBLIC IDENC|'+
						'PUBLIC INDCENCY|'+
						'PUBLIC INDENCENCY|'+                                                                                                                                                                                                                                                                                                              
						'RAPE, INDECENT EXP', 
						//'SEXUAL CONDUCT AND CONTACT WITH ADULT FEMALE VICTIMS|'+ 
						//'SEXUAL CONTACT WITH ADULT FEMALE VICTIMS',
						trim(l.offense_description, left, right),
						0)<>'' => 'EXS',//'EXPOSURE'

					regexfind('ATT MOLESTATION OF A CHILD/ SEX EXPLOIT|'+ 
						'ATT MOLESTATION OF A CHILD/COMMERCL EXPLOIT|'+ 
						'CARETAKER SEXUAL ABUSE OR SEXUAL EXPLOIT|'+ 
						'CHILD ABUSE SEXUAL / EXPLOITATION|'+ 
						'CHILD PORNOGRAPHY INVOLVING THE SEXUAL EXPLOITATION|'+ 
						'EXPLOITATION OF CHILDREN; CONTRIBUTING TO THE DELINQUENCY|'+ 
						'INTERNET LURING-CHILD WITH INTERNET-EXPLOIT|'+ 
						'INTERNET SEXUAL EXPLOITATION OF A CHILD|'+ 
						'KIDNAP MINOR,EXPLOIT|'+ 
						'LURE/LURING MINOR FOR SEXUAL EXPLOITATION|'+ 
						'MATERIAL INVOLVING/DEPICTING SEXUAL EXPLOITATION|'+ 
						'PORN AND CHILD/SEXUAL EXPLOIT|'+ 
						'PORNOGRAPHY AND CHILD/SEXUAL EXPLOIT|'+ 
						'POSS MATERIAL EXPLOITATING|'+ 
						'POSS MATERIAL SEX EXPLOITATION|'+ 
						'POSS VISUAL SEX EXPLOITATION|'+ 
						'POSSESSION OF OBSCENE MATERIAL/SEXUAL EXPLOITATION|'+ 
						'SHIP MATERIAL INV SEX EXPLOITAT MINOR|'+ 
						'SOLICITATION TO COMMIT SEXUAL EXPLOITA|'+ 
						'TRAFFICKING IN MATERIAL INVOLVING SEXUAL EXPLOITATION|'+ 
						'USE OF A COMPUTER FOR CHILD EXPLOITATION|' + 
						'33V6902-7D - ELDERLY/DISABLED-EXPLOIT-SEXUAL',
						trim(l.offense_description, left, right),
						0)<>'' => 'EXP',//'EXPLOITATION'		

					regexfind('DEVIATE SEXUAL INTERCOURSE 3 INDECENT ASSAULT 4 CORRUPTION|'+
						'INDECENT ASSAULT AND CORRUPTION OF MINORS|'+
						'INVOLUNTARY DEVIATE SEXUAL INTERCOURSE AND CORRUPTION|'+
						'RAPE AND CORRUPTION OF MINOR|'+
						'SEXUAL ASSAULT, STATUTORY SEXUAL ASSAULT, 2ND DEGREE INDECENT ASSAULT AND CORRUPTING THE MORALS|'+
						'SEXUAL BATTERY AND CORRUPTION OF A MINOR', 
						trim(l.offense_description, left, right),
						0)<>'' => 'COR',//CORRUPTION
						
					regexfind('CHILD BY COMP|'+
						'CHILD PORN ON COMPUTER|'+ 
						'CHILD PORN ON INTERNET|'+
						'CHILD PORN ON/VIA COMPUTER|'+
						'CHILD PORNOGRAPHY ON COMPUTER|'+
						'CHILD PORNOGRAPHY ON INTERNET|'+ 
						'CHILD PORNOGRAPHY ON/VIA COMPUTER|'+
						'COMPTR|'+
						'COMPUTE|'+
						'COMPUTER|'+
						'CMPTR|'+
						'DISTRIBUTION OF CHILD PORNOGRAPHY BY MEANS OF A COMPUTER|'+ 
						'DOWNLOADING CHILD PORNOGRAPHY TO COMPUTER|'+ 
						'ELEC FURN OBSC MATERIAL MINORS|'+ 
						'ELEC_DISP|'+
						'ELECT DEVICE|'+
						'ELECT EQUIP|'+
						'ELECTRONIC|'+
						'ELECTRONICALLY FURNISHING OBSCENE MATERIAL MINORS|'+ 
						'EMAIL|'+
						'ENTICING CHILD OVER INTERNET|'+ 
						'EXPLOITATION OF A MINOR BY ELECTRONIC|'+ 
						'INTERNET|'+
						'LEWD, LASCIVIOUS ACT BY COMPUTER TRANSMISSION, VICTIM UNDER 16|'+ 
						'LURING MINOR BY COMPUTER|'+
						'ONLINE|'+
						'PORNOGRAPHY ON GOVERNMENT COMPUTER|'+ 
						'POSS SEXUAL PERFORMANCE BY COMPUTER|'+ 
						'POSSESSION OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+
						'POSSESSION/TRANSPORTING/RECEIPT/RECEIVE OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+ 
						'RECEIPT OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+
						'RECEIVEING OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+
						'RECEIVE OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+
						'SOLICITATION OF CHILD BY COMPUTER|'+
						'SOLICITING A MINOR VIA COMPUTER|'+
						'TRANSPORTED IN INTERSTATE COMMERCE BY COMPUTER|'+ 
						'RECEIVING IN INTERSTATE COMMERCE VISUAL DEPICTIONS OF A MINOR ENGAGED IN SEXUALLY EXPLICIT CONDUCT BY MEANS OF A COMPUTER|'+ 
						'SOLIC OF CHILD BY COMPUTER|'+ 
						'SOLICIT A MINOR THROUGH ELECTRONIC MEANS|'+ 
						'SOLICITATION OF CHILD BY COMPUTER|'+
						'TRANSPORTING OF CHILD PORNOGRAPHY VIA/BY COMPUTER|'+
						'USE OF INTERNET/PHONE|'+
						'SLICIT A MINR THRUGH ELECTRNIC MEANS|'+
            'ATTEMPTING T LURE A MINR BY ELECTRNIC MEANS|'+
						'USING CMPUTER T SEND INAPPRPRIATE MATERIAL T A MINR|'+
						'SLICIT BY CMPUTER/ APPEAR|'+
						'RECEIPT F BSENE CMPUTER IMAGE|'+
						'TRANSPRTATIN F BSCENE MATERIAL CMPUTERS|'+
						'SLICITATIN F MINR BY ELECTRNIC MEANS|'+

						'USING TECH',
						trim(l.offense_description, left, right),
						0)<>'' => 'COM',//COMPUTER_CRIME
						
					regexfind('ABDUCT|'+
						'CRIMINAL SEXUAL CONDUCT 2ND DEGREE AND KIDNAPPING|'+ 
						'FACILITATION OF AGGRAVATED RAPE (2 CNTS) & FACILITATION OF AGGRAVATED KIDNAPPING|'+ 
						'KIDNAP|'+
						'KIDNAPPING|'+ 
						'LEWD/LASCIV ACT W/CHILD -14, KIDNAP|'+ 
						'RAPE-1ST,KIDNAPPING|'+ 
						'SEX BAT KIDNAP|'+
						'SEX OFFENDER/FELONY-KIDNAP|'+ 
						'SEXUAL ABUSE AND ABDUCTION/KIDNAPPING|'+ 
						'SEXUAL ASSAULT & KIDNAPPING/ABDUCTION|'+ 
						'SEXUAL ASSAULT AND 18-3-303 - KIDNAPPING|'+ 
						'SEXUAL BATTERY KIDNAPPING|'+ 
						'SEXUAL IMPOSITION, KIDNAPPING',
						trim(l.offense_description, left, right),
						0)<>'' => 'ABD',//ABDUCTION

					regexfind('A&B CHILD|'+
						'ABUSE OF A CHILD|'+
						'ASLT-CHILD|'+
						'CHILD FOR SEX|'+
						'CHILD MOLES|'+
						'CHILD PORN|'+
						'CHILD TO ENGAGE IN SEXUAL CONDUCT|'+
						'CHILD / SEX|'+
						'CHILD/SEX ACT|'+
						'CHLD SEX|'+
						'CORRUPTION OF A MINOR AND|'+
						'GRABBED 14 YR OLD|'+
						'INCEST WITH CHILD/MINOR|'+
						'INDECENT BEAHVIOR WITH JUV|'+
						'INDEC BEHAV W/JUV|'+
						'INDECENT LIBERTIES WITH A MINOR|'+
						'INTERCOURSE WITH A CHILD|'+
						'INTERCOURSE WITH PERSON LESS THAN|'+
						'INTRCOURSE W/MINOR|'+
						'MATERIAL WHICH EXPLOITS MINORS|'+
						//'JUVENILE|'+
						//'MINOR|'+
						'RAPE AGAINST A CHILD|'+ 
						'RAPE AND ABUSE OF CHILD|'+ 
						'RAPE AND CARNAL KNOWLEDGE OF A CHILD|'+ 
						'RAPE FOURTH DEGREE SEXUAL INTERCOURSE VICTIM IS LESS THAN|'+ 
						'RAPE OF A CHILD|'+ 
						'RAPE THIRD DEGREE SEXUAL PENETRATION VICTIM UNDER|'+ 
						'RAPE, SEXUAL INTERCOURSE WITH A CHILD|'+ 
						//'RAPE???VICTIM IS UNDER |'+X|'+ YEARS OF AGE|'+ 
						//RAPE???VICTIM LESS THAN |'+X|'+ YEARS OLD|'+ 
						'RUSH SODOMIZED A NINE YEAR OLD MALE.|'+ 
						'SEX ABUSE OF CHILD|'+
						'SEX TRAFFIC CHILD|'+
						'SEX TRAFFICKING MINOR|'+
						'SEX TRAFFICKING OF A MINOR|'+
						'SEX W MINOR|'+
						'SEX W/MINOR|'+
						'SEXUAL CONTACT WITH MALE & FEMALE VICTIMS (AGE 3-ADULT)|'+
						'SEXUAL CONTACT WITH VICTIMS (FEMALES, AGE 7-ADULT)|'+
						'SEXUAL EXPLOITATION OF A CHILD/SEXUAL ASSAULT|'+
						'SEXUAL EXPLOITATION OF A MINOR|'+
						'SEXUAL TRAFFICKING MINOR|'+
						'SEXUAL TRAFFICKING OF A MINOR|'+
						'SODOMY W/PERSON UNDER 18|'+ 
						'SODOMY WITH A MINOR|'+ 
						'SODOMY WITH CHILD >|'+ 
						'SODOMY WITH PERSON UNDER|'+ 
						'SODOMY WITH/ON A CHILD|'+ 
						'SINGLETON SEXUALLY ABUSED AND SODOMIZED A FIVE YEAR OLD MALE.|'+ 
						'T INTER COMM ENGAG IN SEX W MI|'+
						'TRAFFICKING IN/OF CHIL|'+
						'UNDER AGE 18 TO ENGAGE IN SEXUAL ACTIVITY|'+	
						'UNLAWFUL VIDEOTAPING OF A MINOR|'+	
						'USE OF COMMUNICATION SYSTEMS TO FACILITATE CERTAIN OFFENSES INVOLVING CHILDREN|'+
						'VICTIM WAS AN ADULT FEMALE AND AN EIGHT YEAR OLD FEMALE|'+
            'VICTIMS WERE A TWENTY ONE AND A FIVE YEAR OLD FEMALE|'+
						'W-CHILD|'+
						'SLICITATIN F A MINR IF MISDEMEANR R D R E FELNY|'+
						'UNLAWFUL USE F ELECTRNIC MEANS T INCUDE MINR|'+
						'ATTEMPT T PARTICIPATE IN PRSTITUTIN F A MINR|'+
						'ATTEMPT T TRANSPRT MINR ACRSS STATE LINES|'+
						'CRRUPTIN F MINRS|'+
						'BSCENE MATERIALS F MINR|'+
						'SLICITATIN F A MINR MISDEMEANR, CLASS D R E FELNY|'+
						'SLICITATIN F A MINR|'+
						'CRIMINAL RESPNSIBILITY T CMMIT SLICITATIN F A MINR CLASS B R C FELNY|'+
						'EXPLITATIN F A MINR BY ELECTRNIC MEANS|'+
						'ATTEMPTED CRRUPTIN F A MINR|'+
						'CRIMINAL SLICITATIN F A MINR|'+
						'PRMTING PRSTITUTIN F A MINR|'+
						'SLICITATIN T CMMIT SLICITATIN F A MINR CLASS B R C FELNY|'+
						'TRAVELING T MEET A MINR|'+
						'RAL CPULATIN F A MINR|'+
						'SLICITATIN T CMMIT SLICITATIN F A MINR MISDEMEANR, CLASS D R E FELNY|'+
						'NLINE SLICITATIN F A MINR|'+
						'SLICITATIN F A MINR CLASS B R C FELNY|'+
						'PRCURING PRSTUTIN F A MINR|'+
						'BSCENE MATERIAL - EXHIBIT PRN MATERIAL T MINRS|'+
						'CMPEL PRSTITUTIN MINR|'+
						'TRAVELING T MEET MINR T CMMIT|'+
						'RAL CP-14/R BY FRCE|'+
						'ATTEMPT SLICITATIN F A MINR - AL|'+
						'RAL SDMY F MINR|'+

						'VA023 - PROPOSE SEX BY COMP ETC. 15+Y, OFFENDER 7+YR'
						,

						trim(l.offense_description, left, right),
						0)<>'' and
						regexfind('EXPLOITATION OF A MINOR', trim(l.offense_description, left, right), 0)=''	
						=> 'SAM',//'SEXUAL_ASSAULT_MINOR',		
						''));
						
		self.offense_category :=  if(category_1 ='REG' and category_2<>'',
																trim(category_1, left, right),
															if(category_1 <> category_2 and category_2 ='SAM' and category_1 not in ['CON','END','POR','SOL','UNL', ''],
																trim(category_1+' '+category_2, left, right),
															if(category_1 <> category_2 and category_2 <>'SAM' and category_1<>'',
																trim(category_1+' '+category_2, left, right),	
																category_1)));

		self :=  l;
end;
	
	offensesCat := project(o2, defCategory(left)):persist('~thor_data400::Persist::hd::Sex_Offender_CROSSOffenses');

/*
dslayout := RECORD
,maxLength(200000)
  string16 seisint_primary_key;
  string20 source_file;
  string80 conviction_jurisdiction;
  string8 conviction_date;
  string30 court;
  string25 court_case_number;
  string8 offense_date;
  string20 offense_code_or_statute;
  string320 offense_description;
  string180 offense_description_2;
  string30 offense_category;
  string10 offense_level;
  string1 victim_minor;
  string3 victim_age;
  string10 victim_gender;
  string30 victim_relationship;
  string180 sentence_description;
  string180 sentence_description_2;
  string8 disposition_dt;
  string8 arrest_date;
  string250 arrest_warrant;
  string40 offense_location;
 END;

offensescat 	:= dataset('~thor_data400::Persist::hd::Sex_Offender_CROSSOffenses', dslayout, flat);
*/	
//CROSS OUTPUT
CROSSoffenses 	:= offensesCat;

//LN OUTPUT
	Sexoffender.Layout_common_offense_new oldForm(CROSSoffenses l):= transform
		self.fcra_conviction_flag 					:= 'Y';
		self.fcra_traffic_flag 							:= 'N';
		self.fcra_date 											:= l.dt_last_reported;
		self.fcra_date_type 								:= 'R';
		self.conviction_override_date 			:= l.dt_last_reported;
		self.conviction_override_date_type 	:= 'C';
		self.offense_score 									:= 'S';
		self := l;
	end;
	
LNoffenses		:= project(CROSSoffenses, oldForm(left)):persist('~thor_data400::Persist::hd::Sex_Offender_LNOffenses');
	
export Mapping_Accurint_Offenses_As_Common := LNoffenses;