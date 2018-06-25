IMPORT doxie, DueDiligence, Gateway, Risk_Indicators, STD;

EXPORT getIndDID(DATASET(DueDiligence.Layouts.CleanedData) cleanedData,
																	STRING dataRestrictionMask,
																	UNSIGNED1 dppa,
																	UNSIGNED1 glba,
																	INTEGER bsVersion,
																	UNSIGNED8 bsOptions,
																	BOOLEAN includeReport = FALSE,
																	BOOLEAN isFCRA = FALSE) := FUNCTION
	
	
		UNSIGNED1 appendBest := 0;	// search the best file 
    gateways := DATASET([], Gateway.Layouts.Config);
	
																										
		uniqueDIDs := DEDUP(SORT(PROJECT(cleanedData((UNSIGNED)cleanedInput.individual.lexID <> 0), TRANSFORM(doxie.layout_references, SELF.did := (UNSIGNED)LEFT.cleanedInput.individual.lexID )), did), did);
   	
		// get best info for those that pass in a DID
		didData := risk_indicators.collection_shell_mod.getBestCleaned(uniqueDIDs, 
																																																																	dataRestrictionMask, 
																																																																	glba, 
																																																																	clean_address:=true);  

		searchDIDs := JOIN(cleanedData, didData,
																					(UNSIGNED)LEFT.cleanedInput.individual.lexID = RIGHT.did,
																					TRANSFORM(Risk_Indicators.Layout_Input,
																										
																																cleaned := LEFT.cleanedInput;
																																indv := cleaned.individual;
																																name := indv.name;
																																addr := indv.address;
																																
																																fullAddressProvided := cleaned.fullAddressProvided;
																																
																																SELF.seq := cleaned.seq;
																																
																											
																											
																																SELF.fname := IF(TRIM(name.firstName) = DueDiligence.Constants.EMPTY, RIGHT.fname, name.firstName);
																																SELF.mname := IF(TRIM(name.middleName) = DueDiligence.Constants.EMPTY, RIGHT.mname, name.middleName);
																																SELF.lname := IF(TRIM(name.lastName) = DueDiligence.Constants.EMPTY, RIGHT.lname, name.lastName);
																																SELF.suffix := IF(TRIM(name.suffix) = DueDiligence.Constants.EMPTY, RIGHT.name_suffix, name.suffix);

																																SELF.in_streetAddress := IF(fullAddressProvided, TRIM(addr.streetAddress1 + ' ' + addr.streetAddress2, LEFT, RIGHT), RIGHT.street_addr);
																																SELF.in_city := IF(fullAddressProvided, addr.city, RIGHT.city_name);
																																SELF.in_state := IF(fullAddressProvided, addr.state, RIGHT.st);
																																SELF.in_zipCode := IF(fullAddressProvided, addr.zip5, RIGHT.zip);

																																SELF.prim_range := IF(fullAddressProvided, addr.prim_range, RIGHT.prim_range);
																																SELF.predir := IF(fullAddressProvided, addr.predir, RIGHT.predir);
																																SELF.prim_name := IF(fullAddressProvided, addr.prim_name, RIGHT.prim_name);
																																SELF.addr_suffix := IF(fullAddressProvided, addr.addr_suffix, RIGHT.suffix);
																																SELF.postdir := IF(fullAddressProvided, addr.postdir, RIGHT.postdir);
																																SELF.unit_desig := IF(fullAddressProvided, addr.unit_desig, RIGHT.unit_desig);
																																SELF.sec_range := IF(fullAddressProvided, addr.sec_range, RIGHT.sec_range);
																																SELF.p_city_name := IF(fullAddressProvided, addr.city, RIGHT.city_name);
																																SELF.st := IF(fullAddressProvided, addr.state, RIGHT.st);
																																SELF.z5 := IF(fullAddressProvided, addr.zip5, RIGHT.zip);
																																SELF.zip4 := IF(fullAddressProvided, addr.zip4, RIGHT.zip4);
																																SELF.county := IF(fullAddressProvided, addr.county, RIGHT.county);
																																SELF.geo_blk := IF(fullAddressProvided, addr.geo_blk, RIGHT.geo_blk);
																																
																																SELF.addr_type := IF(fullAddressProvided, addr.rec_type, RIGHT.addr_type);
																																SELF.addr_status := IF(fullAddressProvided, addr. err_stat, RIGHT.addr_status);
																																
																																SELF.ssn := IF(TRIM(indv.ssn) = DueDiligence.Constants.EMPTY, RIGHT.ssn, indv.ssn);
																																SELF.dob := IF(TRIM(indv.dob) = DueDiligence.Constants.EMPTY, (STRING)RIGHT.dob, indv.dob);
																																SELF.phone10 := IF(TRIM(indv.phone) = DueDiligence.Constants.EMPTY, RIGHT.phone, indv.phone);
																																SELF := LEFT;
																																SELF := [];),
																					LEFT OUTER);


		withDID := risk_indicators.iid_getDID_prepOutput(searchDIDs, dppa, glba, isFCRA, bsVersion, dataRestrictionMask, appendBest, gateways, bsOptions);
		
		//if there are multiple dids for an individual grab the one with the highest score
		sortDIDs := SORT(UNGROUP(withDID), seq, -score, did);
		highestDID := DEDUP(sortDIDs, seq);
		
		indivWithDID := JOIN(cleanedData, highestDID, 
																							LEFT.cleanedInput.seq = RIGHT.seq,
																							TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																																	SELF.seq := LEFT.cleanedInput.seq;
																																	SELF.indvRawInput := LEFT.inputEcho.individual;
																																	SELF.indvCleanInput := LEFT.cleanedInput.individual;
																																	SELF.historyDateRaw := LEFT.cleanedinput.historyDateYYYYMMDD;
																																	SELF.historyDate := IF(LEFT.cleanedinput.historyDateYYYYMMDD = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.cleanedinput.historyDateYYYYMMDD);
																																	SELF.indvType := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
																																	
																																	cleaned := LEFT.cleanedInput;
																																	indv := cleaned.individual;
																																	addr := indv.address;
																																	
																																	SELF.inquiredDID := RIGHT.did;
																																	SELF.individual.did := RIGHT.did;
																																	SELF.individual.score := RIGHT.score;
																																	SELF.individual.ssn := indv.ssn;
																																	SELF.individual.dob := (UNSIGNED4)indv.dob;
																																	SELF.individual.phone := indv.phone;
																																	
																																	SELF.inputaddressprovided := LEFT.cleanedInput.addressProvided;
																																	SELF.fullinputaddressprovided := LEFT.cleanedInput.fullAddressProvided;
																																	
																																	SELF.individual := indv.name;
																																	SELF.individual := indv.address;

																																	SELF := LEFT;
																																	SELF := [];),
																							LEFT OUTER);

				
											
		// OUTPUT(uniqueDIDs, NAMED('uniqueDIDs'));									
		// OUTPUT(didData, NAMED('didData'));									
		// OUTPUT(searchDIDs, NAMED('searchDIDs'));		
		// OUTPUT(withDID, NAMED('withDID'));		
		// OUTPUT(sortDIDs, NAMED('sortDIDs'));		
		// OUTPUT(highestDID, NAMED('highestDID'));		
		// OUTPUT(indivWithDID, NAMED('indivWithDID'));		
		
		
		RETURN indivWithDID;
												
END;