IMPORT BIPv2, DueDiligence;


// ------ Get Legal Event Types by searching for keywords in the charges    ------
// ------ Notice the Legal Event Types are calculated at the DID level      ------
// ------ for the attribute logic,                                          ------
// ------ while the Legal Event Types are reported at the offense level     ------   


EXPORT getIndOffenseLegalEventType(DATASET(DueDiligence.LayoutsInternal.RelatedParty) inData) := FUNCTION
															
		offenses := DueDiligence.Common.getRelatedPartyOffenses(inData);
		
    OffenseWithEventTypes := PROJECT(offenses, TRANSFORM({DueDiligence.LayoutsInternal.CriminalOffenses, BOOLEAN hitLevel9, BOOLEAN hitLevel8, BOOLEAN hitLevel7, 
																															BOOLEAN hitLevel6, BOOLEAN hitLevel5, BOOLEAN hitLevel4, BOOLEAN hitLevel3, BOOLEAN hitLevel2},
																																															
																								expression := DueDiligence.RegularExpressions2(LEFT.offense.charge, LEFT.offense.offenseScore, LEFT.offense.trafficFlag);
																								
																						   	typeLevel_9 := max(expression.foundCorruptionOrBribery,
																																expression.foundLaundering ,
																																expression.foundOrganizedCrime ,
																																expression.foundTerror ,
																																expression.foundIdentityTheft ,
																																expression.foundCounterfeit ,
																																expression.foundFalsePretense,
																																expression.foundInterceptCommunication ,
																																expression.foundInsiderTrading ,
																																expression.foundTreasonOrEspionage ,
																																expression.foundExtortion ,
																																expression.foundConcealmentOfFunds ,
																																expression.foundHijacking ,
                                                                expression.foundWire ,               
																																expression.foundChopShop);
																																																						
																								typeLevel_8 := max(expression.foundTraffickingOrSmuggling ,
																																expression.foundExplosives ,
																																expression.foundWeapons ,
																																expression.foundDrugs ,
																																expression.foundDistributionManufacturingTransportation);
																																																						
																								typeLevel_7 := max(expression.foundFraud ,                 
                                                               expression.foundCheckFraud ,          
																															 expression.foundForgery ,              
																															 expression.foundEmbezzlement ,         
                                                               expression.foundTaxOffenses);            
                                                                 
																																																						
																								typeLevel_6 := max(expression.foundGrandLarceny ,
																															 expression.foundBankRobbery ,
																															 expression.foundArmedRobbery ,
																															 expression.foundRobbery ,
																															 expression.foundFelonlyTheft ,
																															 expression.foundMisdemeanorTheft ,
																															 expression.foundLarceny ,
																															 expression.foundOrganizedRetailTheft ,
																															 expression.foundArson ,
																															 expression.foundBurglary ,
																															 expression.foundBreakingAndEntering ,
                                                               expression.foundMurderHomocideManslaughter ,   
                                                               expression.foundAssultWithIntentToKill ,       
                                                               expression.foundKidnappingOrAbduction);          
                                                                
																																																						
																								 typeLevel_5 := max(expression.foundSolicitation ,
																															 expression.foundPorn ,
																															 expression.foundProstitution ,
																															 expression.foundSexualAssaultAndBattery ,
																															 expression.foundSexualAbuse ,
																															 expression.foundStatutoryRape ,
																															 expression.foundRape ,
																															 expression.foundMolestation);
																																																						
																								 typeLevel_4 := max(expression.foundAggravatedAssaultOrBattery ,
																															  expression.foundAssaultWithDeadlyWeapon ,
																																expression.foundAssault ,
																																expression.foundDomesticViolence ,
																																expression.foundAnimalFighting ,
																																expression.foundStalkingOrHarassment ,
																																expression.foundCyberStalking ,
																																expression.foundViolateRestrainingOrder ,
																																expression.foundResistingArrest ,
																																expression.foundPropertyDestruction ,
																																expression.foundVandalism);
																																																						
																								typeLevel_3 := max(expression.foundPerjury ,
																															 expression.foundObstruction ,
																															 expression.foundTampering ,
																															 expression.foundComputerOffenses ,
																															 expression.foundGamblingOrBitcoin);
																																																						
																							 typeLevel_2 := max(expression.foundShoplifting ,
																															expression.foundAlienOffenses ,
																															expression.foundTrafficOffenses ,
																															expression.foundDUI ,
																															expression.foundTrespassing ,
																															expression.foundDisorderlyConduct ,
																															expression.foundPublicIntoxication);
																										
																								/* hitLevel# are boolean values used to calculate the attribute      */
                                                /* each expression is passing back a weight when it finds a key word */
                                                /* in the charge field of the offense                                */
                                                /* so if anything was found we an can set the hit level to TRUE      */ 
																								SELF.hitLevel9 := typeLevel_9 > 0;
																								SELF.hitLevel8 := typeLevel_8 > 0;
																								SELF.hitLevel7 := typeLevel_7 > 0;
																								SELF.hitLevel6 := typeLevel_6 > 0;
																								SELF.hitLevel5 := typeLevel_5 > 0;
																								SELF.hitLevel4 := typeLevel_4 > 0;
																								SELF.hitLevel3 := typeLevel_3 > 0;
																								SELF.hitLevel2 := typeLevel_2 > 0;
																								/*  If the charge is not filled in set the code to 999 */   
                                                ChargeisEmpty  := IF(LEFT.offense.charge = '', 999, 0);
                                                /*  each leval eveny type has a code/weight and will be used to pick up a description for the legal event that */ 
                                                /*  carried the most weight.  The report section will pick up a description that matches this legal event type */ 
                                                SELF.offense.legalEventTypeCode      := max(typeLevel_9, typeLevel_8, typeLevel_7, typeLevel_6, typeLevel_5, typeLevel_4,
                                                                                            typeLevel_3, typeLevel_2, ChargeisEmpty);
																								SELF.offense.did := LEFT.offense.did;
                                                SELF.offense     := LEFT.offense;  
                                                /* populate the remaininder of the row with the data from left */ 
																								SELF := LEFT;));
																								 																		
		reformatEventTypes  := PROJECT(OffenseWithEventTypes, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, BOOLEAN hitLevel9, BOOLEAN hitLevel8, BOOLEAN hitLevel7, 
																						BOOLEAN hitLevel6, BOOLEAN hitLevel5, BOOLEAN hitLevel4, BOOLEAN hitLevel3, BOOLEAN hitLevel2},
                                            SELF.did   := LEFT.offense.did;
                                            SELF       := LEFT;));  
    
    sortEventTypes := SORT(reformatEventTypes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    
    
		
		//roll up by person
		rollEventTypes := ROLLUP(sortEventTypes, 
															LEFT.seq = RIGHT.seq AND
															LEFT.ultID = RIGHT.ultID AND
															LEFT.orgID = RIGHT.orgID AND
															LEFT.seleID = RIGHT.seleID AND
															LEFT.did = RIGHT.did,
															TRANSFORM(RECORDOF(LEFT),
																				SELF.hitLevel9 := LEFT.hitLevel9 OR RIGHT.hitLevel9;
																				SELF.hitLevel8 := LEFT.hitLevel8 OR RIGHT.hitLevel8;
																				SELF.hitLevel7 := LEFT.hitLevel7 OR RIGHT.hitLevel7;
																				SELF.hitLevel6 := LEFT.hitLevel6 OR RIGHT.hitLevel6;
																				SELF.hitLevel5 := LEFT.hitLevel5 OR RIGHT.hitLevel5;
																				SELF.hitLevel4 := LEFT.hitLevel4 OR RIGHT.hitLevel4;
																				SELF.hitLevel3 := LEFT.hitLevel3 OR RIGHT.hitLevel3;
																				SELF.hitLevel2 := LEFT.hitLevel2 OR RIGHT.hitLevel2;
																				
																				SELF := LEFT;));
								
				
		addEventType := JOIN(InData, rollEventTypes,
													LEFT.seq = RIGHT.seq AND
													LEFT.ultID = RIGHT.ultID AND
													LEFT.orgID = RIGHT.orgID AND
													LEFT.seleID = RIGHT.seleID AND
													LEFT.party.did = RIGHT.did,
													TRANSFORM(RECORDOF(RIGHT),
																		SELF.hitLevel9 := RIGHT.hitLevel9;
																		SELF.hitLevel8 := RIGHT.hitLevel8;
																		SELF.hitLevel7 := RIGHT.hitLevel7;
																		SELF.hitLevel6 := RIGHT.hitLevel6;
																		SELF.hitLevel5 := RIGHT.hitLevel5;
																		SELF.hitLevel4 := RIGHT.hitLevel4;
																		SELF.hitLevel3 := RIGHT.hitLevel3;
																		SELF.hitLevel2 := RIGHT.hitLevel2;	
																		
																		SELF.did := LEFT.party.did;
																		SELF := LEFT;),
													LEFT OUTER);		
																								

		convertRelatedParties := PROJECT(addEventType, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																															SELF.seq := LEFT.seq;
																															SELF.inquiredDID := LEFT.did;
																															SELF.atleastOneCategory9 := LEFT.hitLevel9;
																															SELF.atleastOneCategory8 := LEFT.hitLevel8;
																															SELF.atleastOneCategory7 := LEFT.hitLevel7;
																															SELF.atleastOneCategory6 := LEFT.hitLevel6;
																															SELF.atleastOneCategory5 := LEFT.hitLevel5;
																															SELF.atleastOneCategory4 := LEFT.hitLevel4;
																															SELF.atleastOneCategory3 := LEFT.hitLevel3;
																															SELF.atleastOneCategory2 := LEFT.hitLevel2;
																															SELF := [];));																						
		
		addScore := JOIN(InData, convertRelatedParties, 
											LEFT.seq = RIGHT.seq AND
											LEFT.party.did = RIGHT.inquiredDID,
											TRANSFORM(RECORDOF(LEFT),
																legalEventType := DueDiligence.getIndKRILegalEventType(RIGHT);
																SELF.party.legalEventTypeScore := legalEventType.name;
																SELF.party.legalEventTypeFlags := legalEventType.value;
																SELF := LEFT;),
											LEFT OUTER);
                      
   
    // ------
   	// ------ Convert this list of offenses (which were updated with a legalEventTypeCode in this module) into a DATASET associated to each DID and seq #  ------
    // ------ The main purpose of these next set of steps is to get the updated offenses back into the list of related parties                             ------
	  // ------
   projectTheseOffenses := PROJECT(OffenseWithEventTypes, TRANSFORM({UNSIGNED seq, UNSIGNED6 did, DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) offenses},
                                                            SELF.seq      := LEFT.seq;                                                              
                                                            SELF.did      := LEFT.offense.did;
                                                            SELF.offenses := DATASET([TRANSFORM(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense,
                                                                                  SELF.did           := LEFT.offense.did;
                                                                                  SELF.offender_key  := LEFT.offense.offender_key;
                                                                                  SELF.historydate   := LEFT.offense.historydate;  
                                                                                  SELF.ToDaysDate    := LEFT.offense.todaysdate;
                                                                                  SELF.DateToUse     := LEFT.offense.datetouse;
                                                                                  SELF.NumOfDaysAgo  := LEFT.offense.NumOfDaysAgo;
                                                                                  SELF.caseNum       := LEFT.offense.caseNum;
                                                                                  SELF.courtType     := LEFT.offense.courtType;
                                                                                  SELF.num_of_counts := LEFT.offense.num_of_counts;
                                                                                  SELF.charge        := LEFT.offense.charge;
                                                                                  SELF.courtDispDesc1 := LEFT.offense.courtDispDesc1;
                                                                                  SELF.courtDispDesc2 := LEFT.offense.courtDispDesc2;
                                                                                  SELF.caseType      := LEFT.offense.caseType;
                                                                                  SELF.arrestLevel   := LEFT.offense.arrestLevel;
                                                                                  SELF.untouchedOffenseScore := LEFT.offense.untouchedOffenseScore;
                                                                                  SELF.offenseScore  := LEFT.offense.offenseScore;
                                                                                  SELF.courtOffenseLevel := LEFT.offense.courtOffenseLevel;
                                                                                  SELF.offenseState  := LEFT.offense.offenseState;
                                                                                  SELF.offenseCounty := LEFT.offense.offenseCounty;
                                                                                  SELF.courtCounty   := LEFT.offense.courtCounty;
                                                                                  SELF.offenseCity   := LEFT.offense.offenseCity;
                                                                                  SELF.agency        := LEFT.offense.agency;
                                                                                  SELF.offenseDate   := LEFT.offense.offenseDate;
                                                                                  SELF.arrestDate    := LEFT.offense.arrestDate;
                                                                                  SELF.courtDispDate := LEFT.offense.courtDispDate;
                                                                                  SELF.sentenceDate  := LEFT.offense.sentenceDate;
                                                                                  SELF.appealDate    := LEFT.offense.appealDate;
                                                                                  SELF.incarcerationDate := LEFT.offense.incarcerationDate;
                                                                                  SELF.incarcerationReleaseDate := LEFT.offense.incarcerationReleaseDate;
                                                                                  SELF.Ever_incarc_offenders := LEFT.offense.Ever_incarc_offenders;
                                                                                  SELF.Ever_incarc_offenses := LEFT.offense.Ever_incarc_offenses;
                                                                                  SELF.Ever_incarc_punishments := LEFT.offense.Ever_incarc_punishments; 
                                                                                  SELF.Curr_incarc_offenders := LEFT.offense.Curr_incarc_offenders;
                                                                                  SELF.Curr_incarc_offenses := LEFT.offense.Curr_incarc_offenses;
                                                                                  SELF.Curr_incarc_punishments := LEFT.offense.Curr_incarc_punishments;
                                                                                  SELF.currentProbation := LEFT.offense.currentProbation;
                                                                                  SELF.probationSentence := LEFT.offense.probationSentence; 
                                                                                  SELF.race           := LEFT.offense.race;
                                                                                  SELF.sex            := LEFT.offense.sex;
                                                                                  SELF.hairColor      := LEFT.offense.hairColor;
                                                                                  SELF.eyeColor       := LEFT.offense.eyeColor;
                                                                                  SELF.height         := LEFT.offense.height;
                                                                                  SELF.weight         := LEFT.offense.weight;
                                                                                  SELF.citizenship    := LEFT.offense.citizenship;
                                                                                  SELF.legalEventTypeCode := LEFT.offense.legalEventTypeCode;
                                                                                  SELF.stateFederalData   := LEFT.offense.stateFederalData;
                                                                                  SELF.earliestOffenseDate := LEFT.offense.earliestOffenseDate;
                                                                                  SELF.untouchedearliestOffenseDate := LEFT.offense.untouchedearliestOffenseDate;
                                                                                  SELF.courtStatute        := LEFT.offense.courtStatute;
                                                                                  SELF.courtStatuteDesc    := LEFT.offense.courtStatuteDesc;
                                                                                  SELF.curr_parole_flag    := LEFT.offense.curr_parole_flag;
                                                                                  SELF.curr_parole_punishments := LEFT.offense.curr_parole_punishments;
                                                                                  SELF.convictionFlag      := LEFT.offense.convictionFlag;
                                                                                  SELF.trafficFlag         := LEFT.offense.trafficFlag;
                                                                                  SELF.criminalOffenderLevel := LEFT.offense.criminalOffenderLevel;
                                                                                  SELF.caseTypeDesc        := LEFT.offense.caseTypeDesc;
                                                                                  SELF.stc_desc_2          := LEFT.offense.stc_desc_2;
                                                                                  SELF.court_off_lev_mapped := LEFT.offense.court_off_lev_mapped;
                                                                                  SELF := LEFT;)]);
                                                            SELF := LEFT;)); 
   
  
   /* Rollup and tie each DATASET of offenses to a DID  */  
   rollTPersonOffenses := ROLLUP(SORT(projectTheseOffenses, seq, did),
                                LEFT.seq = RIGHT.seq AND
                                LEFT.did = RIGHT.did,
                                TRANSFORM(RECORDOF(LEFT),
                                           SELF.offenses := LEFT.offenses + RIGHT.offenses;
                                           SELF := LEFT;)); 
     
    /* JOIN by DID and overlay the old DATASET of offenses with the updated DATASET of offenses  */                   
    popTRelatedParty := JOIN(addScore, rollTPersonOffenses,
                          LEFT.seq       = RIGHT.seq AND
                          LEFT.party.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                      SELF.party.partyOffenses := RIGHT.offenses;
                                      SELF := LEFT;),
                          LEFT OUTER);

		
													
		// OUTPUT(inData, NAMED('inData'));
		// OUTPUT(offenses, NAMED('offenses'));
		// OUTPUT(OffenseWithEventTypes, NAMED('OffenseWithEventTypes'));
    // OUTPUT(reformatEventTypes,  NAMED('reformatEventTypes'));  
		// OUTPUT(eventTypes, NAMED('eventTypes'));
		// OUTPUT(rollEventTypes, NAMED('rollEventTypes'));
		// OUTPUT(addEventType, NAMED('addEventType'));
		// OUTPUT(projectTheseOffenses,  NAMED('projectTheseOffenses'));  
		// OUTPUT(rollTPersonOffenses,  NAMED('rollTPersonOffenses'));  
		// OUTPUT(popTRelatedParty,  NAMED('popTRelatedParty'));  
		// OUTPUT(convertRelatedParties, NAMED('convertRelatedParties'));
		// OUTPUT(addScore, NAMED('addScore'));

		RETURN popTRelatedParty;
END;