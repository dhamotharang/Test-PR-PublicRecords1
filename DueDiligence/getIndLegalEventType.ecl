IMPORT BIPv2, DueDiligence;

EXPORT getIndLegalEventType(DATASET(DueDiligence.LayoutsInternal.RelatedParty) inData) := FUNCTION
																	
		offenses := DueDiligence.Common.getRelatedPartyOffenses(inData);

		eventTypes := PROJECT(offenses, TRANSFORM({DueDiligence.LayoutsInternal.InternalBIPIDsLayout, UNSIGNED6 did, DueDiligence.Layouts.LegalEventTypes},
																																															
																																															expression := DueDiligence.RegularExpressions(LEFT.offense.charge);
																																															
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
																																																	
																																																	
																																															SELF.category9 := typeLevel_9;
																																															SELF.category8 := typeLevel_8;
																																															SELF.category7 := typeLevel_7;
																																															SELF.category6 := typeLevel_6;
																																															SELF.category5 := typeLevel_5;
																																															SELF.category4 := typeLevel_4;
																																															SELF.category3 := typeLevel_3;
																																															SELF.category2 := typeLevel_2;
																																															
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
																																									SELF.category9 := LEFT.category9 OR RIGHT.category9;
																																									SELF.category8 := LEFT.category8 OR RIGHT.category8;
																																									SELF.category7 := LEFT.category7 OR RIGHT.category7;
																																									SELF.category6 := LEFT.category6 OR RIGHT.category6;
																																									SELF.category5 := LEFT.category5 OR RIGHT.category5;
																																									SELF.category4 := LEFT.category4 OR RIGHT.category4;
																																									SELF.category3 := LEFT.category3 OR RIGHT.category3;
																																									SELF.category2 := LEFT.category2 OR RIGHT.category2;
																																									
																																									SELF := LEFT;));
								
				
		addEventType := JOIN(inData, rollEventTypes,
																								LEFT.seq = RIGHT.seq AND
																								LEFT.ultID = RIGHT.ultID AND
																								LEFT.orgID = RIGHT.orgID AND
																								LEFT.seleID = RIGHT.seleID AND
																								LEFT.party.did = RIGHT.did,
																								TRANSFORM(RECORDOF(LEFT),
																																			SELF.party.category9 := RIGHT.category9;
																																			SELF.party.category8 := RIGHT.category8;
																																			SELF.party.category7 := RIGHT.category7;
																																			SELF.party.category6 := RIGHT.category6;
																																			SELF.party.category5 := RIGHT.category5;
																																			SELF.party.category4 := RIGHT.category4;
																																			SELF.party.category3 := RIGHT.category3;
																																			SELF.party.category2 := RIGHT.category2;														
																																			SELF := LEFT;),
																								LEFT OUTER);		
																								

			convertRelatedParties := PROJECT(addEventType, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																																																																		SELF.seq := LEFT.seq;
																																																																		SELF.inquiredDID := LEFT.party.did;
																																																																		SELF.atleastOneCategory9 := LEFT.party.category9;
																																																																		SELF.atleastOneCategory8 := LEFT.party.category8;
																																																																		SELF.atleastOneCategory7 := LEFT.party.category7;
																																																																		SELF.atleastOneCategory6 := LEFT.party.category6;
																																																																		SELF.atleastOneCategory5 := LEFT.party.category5;
																																																																		SELF.atleastOneCategory4 := LEFT.party.category4;
																																																																		SELF.atleastOneCategory3 := LEFT.party.category3;
																																																																		SELF.atleastOneCategory2 := LEFT.party.category2;
																																																																		SELF := [];));																						
		
		addScore := JOIN(addEventType, convertRelatedParties, 
																				LEFT.seq = RIGHT.seq AND
																				LEFT.party.did = RIGHT.inquiredDID,
																				TRANSFORM(RECORDOF(LEFT),
																															legalEventType := DueDiligence.getIndKRILegalEventType(RIGHT);
																															SELF.party.eventTypeScore := legalEventType.name;
																															SELF := LEFT;),
																				LEFT OUTER);
		

		
																	
		// OUTPUT(inData, NAMED('inData_crimType'));
		// OUTPUT(offenses, NAMED('offenses'));
		// OUTPUT(eventTypes, NAMED('eventTypes'));
		// OUTPUT(rollEventTypes, NAMED('rollEventTypes'));
		// OUTPUT(addEventType, NAMED('addEventType'));
		
		// OUTPUT(convertRelatedParties, NAMED('convertRelatedParties'));
		// OUTPUT(addScore, NAMED('addScore'));

		RETURN addScore;
END;