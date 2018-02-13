IMPORT BIPv2, DueDiligence;

EXPORT getIndLegalEventType(DATASET(DueDiligence.LayoutsInternal.RelatedParty) inData) := FUNCTION
																	
		offenses := DueDiligence.Common.getRelatedPartyOffenses(inData);
		
		//filter out those who have convictions
		//convictedParties := offenses(offense.convictionflag = DueDiligence.Constants.YES OR offense.criminaloffenderlevel IN [DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC_CONVICTED]);

		eventTypes := PROJECT(offenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED6 did, BOOLEAN hitLevel9, BOOLEAN hitLevel8, BOOLEAN hitLevel7, 
																															BOOLEAN hitLevel6, BOOLEAN hitLevel5, BOOLEAN hitLevel4, BOOLEAN hitLevel3, BOOLEAN hitLevel2},
																																															
																								expression := DueDiligence.RegularExpressions(LEFT.offense.charge, LEFT.offense.offenseScore);
																								
																								typeLevel_9 := expression.foundCorruptionOrBribery OR
																																expression.foundLaundering OR
																																expression.foundOrganizedCrime OR
																																expression.foundTerror OR
																																expression.foundFraud OR
																																expression.foundIdentityTheft OR
																																expression.foundCounterfeit OR
																																expression.foundCheckFraud OR
																																expression.foundForgery OR
																																expression.foundEmbezzlement OR
																																expression.foundFalsePretense OR
																																expression.foundInterceptCommunication OR
																																expression.foundWire OR
																																expression.foundInsiderTrading OR
																																expression.foundTreasonOrEspionage OR
																																expression.foundExtortion OR
																																expression.foundConcealmentOfFunds OR
																																expression.foundTaxOffenses OR
																																expression.foundHijacking OR
																																expression.foundChopShop;
																																																						
																								typeLevel_8 := expression.foundTraffickingOrSmuggling OR
																																expression.foundExplosives OR
																																expression.foundWeapons OR
																																expression.foundDrugs OR
																																expression.foundDistributionManufacturingTransportation;
																																																						
																								typeLevel_7 := expression.foundMurderHomocideManslaughter OR
																																expression.foundAssultWithIntentToKill OR
																																expression.foundKidnappingOrAbduction;
																																																						
																								typeLevel_6 := expression.foundGrandLarceny OR
																																expression.foundBankRobbery OR
																																expression.foundArmedRobbery OR
																																expression.foundRobbery OR
																																expression.foundFelonlyTheft OR
																																expression.foundMisdemeanorTheft OR
																																expression.foundLarceny OR
																																expression.foundOrganizedRetailTheft OR
																																expression.foundArson OR
																																expression.foundBurglary OR
																																expression.foundBreakingAndEntering;
																																																						
																								typeLevel_5 := expression.foundSolicitation OR
																																expression.foundPorn OR
																																expression.foundProstitution OR
																																expression.foundSexualAssaultAndBattery OR
																																expression.foundSexualAbuse OR
																																expression.foundStatutoryRape OR
																																expression.foundRape OR
																																expression.foundMolestation;
																																																						
																								typeLevel_4 := expression.foundAggravatedAssaultOrBattery OR
																																expression.foundAssaultWithDeadlyWeapon OR
																																expression.foundAssault OR
																																expression.foundDomesticViolence OR
																																expression.foundAnimalFighting OR
																																expression.foundStalkingOrHarassment OR
																																expression.foundCyberStalking OR
																																expression.foundViolateRestrainingOrder OR
																																expression.foundResistingArrest OR
																																expression.foundPropertyDestruction OR
																																expression.foundVandalism;
																																																						
																								typeLevel_3 := expression.foundPerjury OR
																																expression.foundObstruction OR
																																expression.foundTampering OR
																																expression.foundComputerOffenses OR
																																expression.foundGamblingOrBitcoin;
																																																						
																								typeLevel_2 := expression.foundShoplifting OR
																																expression.foundAlienOffenses OR
																																expression.foundDUI OR
																																expression.foundTrespassing OR
																																expression.foundDisorderlyConduct OR
																																expression.foundPublicIntoxication;
																										
																										
																								SELF.hitLevel9 := typeLevel_9;
																								SELF.hitLevel8 := typeLevel_8;
																								SELF.hitLevel7 := typeLevel_7;
																								SELF.hitLevel6 := typeLevel_6;
																								SELF.hitLevel5 := typeLevel_5;
																								SELF.hitLevel4 := typeLevel_4;
																								SELF.hitLevel3 := typeLevel_3;
																								SELF.hitLevel2 := typeLevel_2;
																								
																								SELF.did := LEFT.offense.did;
																								SELF := LEFT;
																								SELF := [];));
																									

		sortEventTypes := SORT(eventTypes, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
		
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
								
				
		addEventType := JOIN(inData, rollEventTypes,
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
		
		addScore := JOIN(inData, convertRelatedParties, 
											LEFT.seq = RIGHT.seq AND
											LEFT.party.did = RIGHT.inquiredDID,
											TRANSFORM(RECORDOF(LEFT),
																legalEventType := DueDiligence.getIndKRILegalEventType(RIGHT);
																SELF.party.legalEventTypeScore := legalEventType.name;
																SELF.party.legalEventTypeFlags := legalEventType.value;
																SELF := LEFT;),
											LEFT OUTER);
		

		
																	
		// OUTPUT(inData, NAMED('inData_crimType'));
		// OUTPUT(offenses, NAMED('offenses'));
		// OUTPUT(convictedParties, NAMED('convictedParties'));
		// OUTPUT(eventTypes, NAMED('eventTypes'));
		// OUTPUT(rollEventTypes, NAMED('rollEventTypes'));
		// OUTPUT(addEventType, NAMED('addEventType'));
		
		// OUTPUT(convertRelatedParties, NAMED('convertRelatedParties'));
		// OUTPUT(addScore, NAMED('addScore'));

		RETURN addScore;
END;