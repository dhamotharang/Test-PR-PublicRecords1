Import doxie, drivers, header, mdr, Risk_Indicators, riskwise, header_quick, ut, STD, VotersV2;

/*
	Following Keys being used:
			doxie.Key_Header
			header_quick.key_DID
			VotersV2.Key_Voters_States
*/

EXPORT getIndHeader(DATASET(DueDiligence.Layouts.Indv_Internal) inData,
																				STRING dataRestrictionMask,
																				UNSIGNED1 dppa,
																				UNSIGNED1 glba,
																				BOOLEAN isFCRA,
																				BOOLEAN includeReport = FALSE) := FUNCTION

												
		BOOLEAN isUtility := FALSE;

		glb_ok := Risk_Indicators.iid_constants.glb_ok(glba, isFCRA);
		dppa_ok := Risk_Indicators.iid_constants.dppa_ok(dppa, isFCRA);
		
		
		parents := DueDiligence.CommonIndividual.getRelationship(inData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);																																																							
		allInd := parents + inData;
		
		getHeaderData(key, didField, atmostValue, keepValue) := FUNCTIONMACRO
				results := JOIN(allInd, key, 
												KEYED(LEFT.individual.did = RIGHT.didField) AND
												RIGHT.src NOT IN Risk_Indicators.iid_constants.masked_header_sources(dataRestrictionMask, isFCRA) AND 
												(~mdr.Source_is_Utility(RIGHT.src) OR ~isUtility)	AND
												(header.isPreGLB(RIGHT) OR glb_ok) AND 
												(~mdr.Source_is_DPPA(RIGHT.src) OR (dppa_ok AND drivers.state_dppa_ok(header.translateSource(RIGHT.src), dppa, RIGHT.src))) AND 
												~Risk_Indicators.iid_constants.filtered_source(RIGHT.src, RIGHT.st), 
												TRANSFORM(DueDiligence.LayoutsInternal.IndSlimHeader, 
																	SELF.seq := LEFT.seq;
																	SELF.inquiredDID := LEFT.inquiredDID;
																	SELF.did := LEFT.individual.did;
																	SELF.indvType := LEFT.indvType;
																	SELF.historydate := LEFT.historyDate;
																	SELF.dateFirstSeen := IF(RIGHT.dt_first_seen = 0, RIGHT.dt_vendor_first_reported, RIGHT.dt_first_seen);
																	SELF.dateLastSeen := IF(RIGHT.dt_last_seen = 0, RIGHT.dt_vendor_last_reported, RIGHT.dt_last_seen);
																	SELF.addr_suffix := RIGHT.suffix;
																	SELF.city := RIGHT.city_name;
																	SELF.state := RIGHT.st;
																	SELF.zip5 := RIGHT.zip;
																	SELF.firstName := RIGHT.fname;
																	SELF.middleName := RIGHT.mname;
																	SELF.lastName := RIGHT.lname;
																	SELF.suffix := RIGHT.name_suffix;
																	SELF := RIGHT;
																	SELF := [];),  
												LEFT OUTER, 
												ATMOST(atmostValue), 
												KEEP(keepValue));
												
			RETURN results;		
		ENDMACRO;
		
		
		keyHeader := getHeaderData(doxie.Key_Header, s_did, ut.limits.HEADER_PER_DID, DueDiligence.Constants.MAX_ATMOST_150);									
		quickHeader := getHeaderData(header_quick.key_DID, did, RiskWise.max_atmost, DueDiligence.Constants.MAX_ATMOST_100);
												
		realHeader :=  quickHeader + keyHeader;

		headerCleanDates := DueDiligence.Common.CleanDatasetDateFields(realHeader, 'dateFirstSeen, dateLastSeen');
		
		//filter out records after our history date
		filterHeader := DueDiligence.Common.FilterRecordsSingleDate(headerCleanDates, dateFirstSeen);


		//sort header data to grab the first seen date for a given inquired did
		sortHeaderDateFirstSeen := SORT(filterHeader(dateFirstSeen <> 0), seq, did, dateFirstSeen);
		dedupHeaderDateFirstSeen := DEDUP(sortHeaderDateFirstSeen, seq, did);
		
		addDateFirstReported := JOIN(inData, dedupHeaderDateFirstSeen,
																	LEFT.seq = RIGHT.seq AND
																	LEFT.individual.did = RIGHT.did,
																	TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																						SELF.firstReportedDate := RIGHT.dateFirstSeen;
																						SELF := LEFT;),
																	LEFT OUTER);

		//determine if there was a voter source for an individual
		voterSources := filterHeader(src = MDR.sourceTools.src_Voters_v2);
		
		sortVoterSources := SORT(voterSources, seq, did);
		dedupVoterSources := DEDUP(sortVoterSources, seq, did);
		
		projectVoterSources := PROJECT(dedupVoterSources, TRANSFORM({RECORDOF(LEFT), BOOLEAN indVoterSource, BOOLEAN parentVoterSource},
																																	SELF.indVoterSource := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL;
																																	SELF.parentVoterSource := LEFT.indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT;
																																	SELF := LEFT;));
																																																																
		rollVoterSources := ROLLUP(SORT(projectVoterSources, seq, inquiredDID, indvType),
																LEFT.seq = RIGHT.seq AND
																LEFT.inquiredDID = RIGHT.inquiredDID,
																TRANSFORM(RECORDOF(LEFT),
																					SELF.indVoterSource := LEFT.indVoterSource OR RIGHT.indVoterSource;
																					SELF.parentVoterSource := LEFT.parentVoterSource OR RIGHT.parentVoterSource;
																					SELF := LEFT;));																																																														
		
		addRegVoter := JOIN(addDateFirstReported, rollVoterSources,
												LEFT.seq = RIGHT.seq AND
												LEFT.individual.did = RIGHT.did,
												TRANSFORM(RECORDOF(LEFT),
																	SELF.registeredVoter := RIGHT.indVoterSource;
																	SELF.atleastOneParentIsRegisteredVoter := RIGHT.parentVoterSource;
																	SELF := LEFT;),
												LEFT OUTER);
		
		//sort and dedup addresses based on state (we only need to know state)
		sortStates := SORT(filterHeader(indvType = DueDiligence.Constants.INQUIRED_INDIVIDUAL), seq, inquiredDID, state);
		dedupStates := DEDUP(sortStates, seq, inquiredDID, state);
		
		//determine if the voter info has state coverage for the inquired individual
		stateVoterInfo := JOIN(dedupStates, VotersV2.Key_Voters_States(isFCRA),
																									KEYED(LEFT.State = RIGHT.State) AND
																									(STRING)LEFT.historyDate > RIGHT.date_first_seen,
																									TRANSFORM({RECORDOF(LEFT), BOOLEAN stateVoterInfoAvailable},
																																				SELF.stateVoterInfoAvailable := (UNSIGNED)RIGHT.date_first_seen > 0;
																																				SELF := LEFT;),
																									LEFT OUTER,
																									ATMOST(1));
																					
		rollStateVoterInfo := ROLLUP(SORT(stateVoterInfo, seq, did),
																	LEFT.seq = RIGHT.seq AND
																	LEFT.did = RIGHT.did,
																	TRANSFORM(RECORDOF(LEFT),
																						SELF.stateVoterInfoAvailable := LEFT.stateVoterInfoAvailable OR RIGHT.stateVoterInfoAvailable;
																						SELF := LEFT;));
																					
		addIndStateVoter := JOIN(addRegVoter, rollStateVoterInfo,
															LEFT.seq = RIGHT.seq AND
															LEFT.individual.did = RIGHT.did,
															TRANSFORM(RECORDOF(LEFT),
																				SELF.stateVotingSourceAvailable := RIGHT.stateVoterInfoAvailable;
																				SELF := LEFT;),
															LEFT OUTER);
																					

																																					
		



		// output(keyHeader, named('keyHeader'));
		// output(quickHeader, named('quickHeader'));
		// output(allInd, named('allInd_header'));
		// output(realHeader, named('realHeader'));
		
		// output(headerCleanDates, named('headerCleanDates'));
		// output(filterHeader, named('filterHeader'));
		
		// output(voterSources, named('voterSources'));
		// output(sortHeaderDateFirstSeen, named('sortHeaderDateFirstSeen'));
		// output(dedupHeaderDateFirstSeen, named('dedupHeaderDateFirstSeen'));
		// output(addDateFirstReported, named('addDateFirstReported'));
	
		// output(projectVoterSources, named('projectVoterSources'));
		// output(rollVoterSources, named('rollVoterSources'));
		// output(addRegVoter, named('addRegVoter'));
		
		// output(sortStates, named('sortStates'));
		// output(dedupStates, named('dedupStates'));
		
		// output(stateVoterInfo, named('stateVoterInfo'));
		// output(rollStateVoterInfo, named('rollStateVoterInfo'));
		// output(addIndStateVoter, named('addIndStateVoter'));


		RETURN addIndStateVoter;
END;
