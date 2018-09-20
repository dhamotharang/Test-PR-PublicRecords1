IMPORT BIPV2, Business_Risk_BIP, DueDiligence;

EXPORT getBusExecResidency(DATASET(DueDiligence.Layouts.Busn_Internal) indata,
																											Business_Risk_BIP.LIB_Business_Shell_LIBIN options) := FUNCTION
		
		
		
		INTEGER bsVersion := DueDiligence.CitDDShared.DEFAULT_BS_VERSION;
		UNSIGNED8 bsOptions := DueDiligence.CitDDShared.DEFAULT_BS_OPTIONS;
		BOOLEAN isFCRA := DueDiligence.Constants.DEFAULT_IS_FCRA;
		
		UNSIGNED1 dppa := options.DPPA_Purpose;
		UNSIGNED1 glba := options.GLBA_Purpose;
		STRING dataRestrictionMask := options.DataRestrictionMask;
		
		
		pullExecs := DueDiligence.CommonBusiness.getExecs(indata);
		
			
		indLayout := PROJECT(pullExecs, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																							SELF.seq := LEFT.seq;
																							SELF.historyDate := DueDiligence.Common.GetMyDate(LEFT.historyDate);
																							SELF.inquiredDID := LEFT.party.did;
																							SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
																							SELF.individual := LEFT.party;
																							SELF := [];));
		
		
		//get the best data for the individual if do not have it
		execBestData := DueDiligence.getIndBestData(indLayout, dppa, glba, FALSE);								
		
		//get relatives of the inquired individual
		inquiredRelatives := DueDiligence.getIndRelatives(execBestData, dppa, glba, FALSE);
		
		//get header information
		indHeader := DueDiligence.getIndHeader(inquiredRelatives, dataRestrictionMask, dppa, glba, isFCRA, FALSE);
		
		//get information pertaining to SSN
		indSSNData := DueDiligence.getIndSSNData(indHeader, dataRestrictionMask, dppa, glba, bsVersion, bsOptions, isFCRA, FALSE);
		
		//add the best data to the execs with the residency score for the given exec
		combineExecs := JOIN(pullExecs, indSSNData,
													LEFT.seq = RIGHT.seq AND
													LEFT.party.did = RIGHT.inquiredDID,
													TRANSFORM(RECORDOF(LEFT),
																							
																		residencyRisk := DueDiligence.getIndKRIResidency(RIGHT);																																																	
																		
																		SELF.party.usResidencyScore := residencyRisk.name;
																		SELF.party.usResidencyFlags := residencyRisk.value;
																		SELF.party.ssn := RIGHT.individual.ssn;
																		SELF.party.dob := RIGHT.individual.dob;
																		SELF.party.phone := RIGHT.individual.phone;
																		
																		SELF.party.streetAddress1 := RIGHT.individual.streetAddress1;
																		SELF.party.streetAddress2 := RIGHT.individual.streetAddress2;
																		SELF.party.prim_range := RIGHT.individual.prim_range;
																		SELF.party.predir := RIGHT.individual.predir;
																		SELF.party.prim_name := RIGHT.individual.prim_name;
																		SELF.party.addr_suffix := RIGHT.individual.addr_suffix;
																		SELF.party.postdir := RIGHT.individual.postdir;
																		SELF.party.unit_desig := RIGHT.individual.unit_desig;
																		SELF.party.sec_range := RIGHT.individual.sec_range;
																		SELF.party.city := RIGHT.individual.city;
																		SELF.party.state := RIGHT.individual.state;
																		SELF.party.zip5 := RIGHT.individual.zip5;
																		SELF.party.zip4 := RIGHT.individual.zip4;
																		
																		SELF := LEFT;
																		SELF := [];));
		
	
		//replace the updated exec data
		updatedExecOnInquired := DueDiligence.CommonBusiness.ReplaceExecs(indata, combineExecs);
		
		//translate the flags to rollup to the business
		updtHitLevels := PROJECT(combineExecs, TRANSFORM({BOOLEAN hitLevel9, BOOLEAN hitLevel8, BOOLEAN hitLevel7, BOOLEAN hitLevel6, BOOLEAN hitLevel5,
																																														BOOLEAN hitLevel4, BOOLEAN hitLevel3, BOOLEAN hitLevel2, BOOLEAN hitLevel1, RECORDOF(LEFT)},
																											
																											flags := LEFT.party.usResidencyFlags;
																											
																											SELF.hitLevel9 := flags[1] = 'T';
																											SELF.hitLevel8 := flags[2] = 'T';
																											SELF.hitLevel7 := flags[3] = 'T';
																											SELF.hitLevel6 := flags[4] = 'T';
																											SELF.hitLevel5 := flags[5] = 'T';
																											SELF.hitLevel4 := flags[6] = 'T';
																											SELF.hitLevel3 := flags[7] = 'T';
																											SELF.hitLevel2 := flags[8] = 'T';
																											SELF.hitLevel1 := flags[9] = 'T';
																											SELF := LEFT;));
		
		//roll the combined execs to determine if atleast one exec hits overall
		sortCombined := SORT(updtHitLevels, seq, #EXPAND(BIPV2.IDmacros.mac_ListTop3Linkids()));
		
		rollCombined := ROLLUP(sortCombined,
														LEFT.seq = RIGHT.seq AND
														LEFT.ultID = RIGHT.ultID AND
														LEFT.orgID = RIGHT.orgID AND
														LEFT.seleID = RIGHT.seleID,	
														TRANSFORM(RECORDOF(LEFT),
																			SELF.hitLevel9 := LEFT.hitLevel9 OR RIGHT.hitLevel9;
																			SELF.hitLevel8 := LEFT.hitLevel8 OR RIGHT.hitLevel8;
																			SELF.hitLevel7 := LEFT.hitLevel7 OR RIGHT.hitLevel7;
																			SELF.hitLevel6 := LEFT.hitLevel6 OR RIGHT.hitLevel6;
																			SELF.hitLevel5 := LEFT.hitLevel5 OR RIGHT.hitLevel5;
																			SELF.hitLevel4 := LEFT.hitLevel4 OR RIGHT.hitLevel4;
																			SELF.hitLevel3 := LEFT.hitLevel3 OR RIGHT.hitLevel3;
																			SELF.hitLevel2 := LEFT.hitLevel2 OR RIGHT.hitLevel2;
																			SELF.hitLevel1 := LEFT.hitLevel1 OR RIGHT.hitLevel1;
																			SELF := LEFT;));
		
		addResidency := JOIN(updatedExecOnInquired, rollCombined,
													LEFT.seq = RIGHT.seq AND
													LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
													LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
													LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,	
													TRANSFORM(DueDiligence.Layouts.Busn_Internal,
																		SELF.atleastOneBEOInvalidSSN := RIGHT.hitLevel9;
																		SELF.atleastOneBEOAssocITINOrImmigrantSSN := RIGHT.hitLevel8;
																		SELF.atleastOneBEODOBPriorToParentSSN := RIGHT.hitLevel7;
																		SELF.atleastOneBEOParentWithITINOrImmigrantSSN := RIGHT.hitLevel6;
																		SELF.atleastOneBEONoParentsOrNeitherHaveSSNITIN := RIGHT.hitLevel5;
																		SELF.atleastOneBEOPublicRecordsLess3YrsWithNoVote := RIGHT.hitLevel4;
																		SELF.atleastOneBEOPublicRecordsBetween3And10YrsWithNoVote := RIGHT.hitLevel3;
																		SELF.atleastOneBEOPublicRecordsMoreThan10YrsWithNoVote := RIGHT.hitLevel2;
																		SELF.atleastOneBEOOrParentRegisteredVoter := RIGHT.hitLevel1;
																		SELF := LEFT;),
													LEFT OUTER);
		
		
		
		// OUTPUT(indata, NAMED('indata_execResidency'));
		// OUTPUT(pullExecs, NAMED('pullExecs'));
		// OUTPUT(indLayout, NAMED('indLayout'));
		// OUTPUT(execBestData, NAMED('execBestData'));
		// OUTPUT(inquiredRelatives, NAMED('inquiredRelatives'));
		// OUTPUT(indHeader, NAMED('indHeader'));
		// OUTPUT(indSSNData, NAMED('indSSNData'));
		// OUTPUT(combineExecs, NAMED('combineExecs'));
		// OUTPUT(updatedExecOnInquired, NAMED('updatedExecOnInquired'));
		// OUTPUT(updtHitLevels, NAMED('updtHitLevels'));
		// OUTPUT(rollCombined, NAMED('rollCombined'));
		// OUTPUT(addResidency, NAMED('addResidency'));
									
										
			RETURN addResidency;							
END;										