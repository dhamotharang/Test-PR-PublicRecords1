// ATACRaids multi mode merge logic:
//		The idea is to always return records from all modes. So we split the mode datasets into even buckets and take the top (max_records/modes) records of each bucket.
//		If number of records is still less than max_records, take the next records of each mode until we reach max_records to be returned.
EXPORT PickTopRecords(dRecsEVE, dRecsCFS, dRecsCRA, dRecsLPR, dRecsOFF, dRecsSPO, dRecsINT, max_records) := FUNCTIONMACRO
	
	nActiveModes := 
			IF(exists(dRecsEVE), 1, 0)
		+ IF(exists(dRecsCFS), 1, 0)
		+ IF(exists(dRecsCRA), 1, 0)
		+ IF(exists(dRecsLPR), 1, 0)
		+ IF(exists(dRecsOFF), 1, 0)
		+ IF(exists(dRecsSPO), 1, 0)
		+ IF(exists(dRecsINT), 1, 0)
		;
	
	bSize := IF(nActiveModes>0, max_records/nActiveModes, 0);
	
	// Concatenate all datasets in the same order used by ATACRaids: Events, CFS, LPR, Crashes, Intel, Shotspotter, Offenders
	
	dIn := 
			dRecsEVE(seq<=bSize)
		+ dRecsCFS(seq<=bSize)
		+ dRecsLPR(seq<=bSize)
		+ dRecsCRA(seq<=bSize)
		+ dRecsINT(seq<=bSize)
		+ dRecsSPO(seq<=bSize)
		+ dRecsOFF(seq<=bSize)		
		;
	
	dOut := 
			dRecsEVE(seq>bSize)
		+ dRecsCFS(seq>bSize)
		+ dRecsLPR(seq>bSize)
		+ dRecsCRA(seq>bSize)
		+ dRecsINT(seq>bSize)
		+ dRecsSPO(seq>bSize)
		+ dRecsOFF(seq>bSize)
		;
		
	dTopRecs := CHOOSEN(dIn + dOut, max_records);		
	RETURN dTopRecs;
	
ENDMACRO;
