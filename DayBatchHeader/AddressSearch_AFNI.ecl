/*
Special DID append logic for AFNI searches
Only allows did from a name address match to be returned if no ssn was on input record or ssn was on input,
and did also got an ssn match
*/
export AddressSearch_AFNI(GROUPED DATASET(DayBatchHeader.Layout_LinkHeader) indata_grouped, 
														STRING20 searchType,
														INTEGER dppa,
														INTEGER glba) := FUNCTION	
	
	re_grp := GROUP(UNGROUP(indata_grouped),indata.acctno);
	// Used to only accept matches on SSN when an SSN input is sent
	DayBatchHeader.Layout_LinkHeader filterSsnInputs(DayBatchHeader.Layout_LinkHeader inputWithDid) := TRANSFORM
		
		hasInputSsn := ~inputWithDid.indata.ssn = '';
		// Is an ssn match if there is an S anywhere in the matchcode field
		isSsnMatch := stringLib.StringContains(inputWithDid.matchCode,'S',false);
		
		// If the input has an ssn, the output must match on ssn to be used		
		SELF.outdata.did := IF(hasInputSsn AND ~isSsnMatch,0,inputWithDid.outdata.did);
		SELF.matchCode := IF(hasInputSsn AND ~isSsnMatch,'',inputWithDid.matchCode);
		SELF := inputWithDid;
		
	END;
	
	filteredInput := PROJECT(re_grp,filterSsnInputs(LEFT));

/*
	// Get best record for each linked did
	bestRec := DayBatchHeader.BatchGetBestRecords(filteredInput,dppa,glba);

	// Sort the best match code for the search to the top, with newest date last seen at top of duplicate match codes
	srtBestRec := SORT(bestRec,DayBatchHeader.getPriority(matchCode,searchType),-outdata.dt_last_seen);
	
	// Take the top record for each acctNo
	retVal := DEDUP(srtBestRec, true);
*/

//output(indata_Grouped,named('InputData'));
//output(filteredInput,named('filteredInpt'));
//output(bestRec,named('BestRecs'));
//output(srtBestRec,named('SortedBestRecs'));
//output(retVal, named('retFromSimple'));

	RETURN filteredInput;	
	
END;