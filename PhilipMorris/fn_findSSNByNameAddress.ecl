CN := PhilipMorris.Constants;
LT := PhilipMorris.Layouts;
FN := PhilipMorris.Functions;
TF := PhilipMorris.Transforms;

export LT.OutputRecord.CandidateRecord fn_findSSNByNameAddress (
	DATASET(LT.OutputRecord.CandidateRecord) SearchData, 
	UNSIGNED2 AddressIdHit,
	BOOLEAN NoHouseNumber, 
	BOOLEAN isDobMatch) := FUNCTION
	
	nada := DATASET([], LT.OutputRecord.CandidateRecord);
	
	// Filter data by name and address with or without house number.	
	dataHitsAddress := IF (NoHouseNumber, 
	  SearchData( MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4 and MatchesSSN4 and SearchAddressIDHit = AddressIdHit) , 
	  SearchData( MatchesFirstName and MatchesLastName and MatchesZipCode and MatchesStreetNameFirst4 and MatchesHouseNumberFirst3 and MatchesSSN4 and SearchAddressIDHit = AddressIdHit));

	dataHits := IF(isDobMatch, 
		dataHitsAddress(MatchesYOB), dataHitsAddress);
	 // Record used to calculate count for ssn.
	rollupRec := RECORD
		dataHits.InternalSeqNo ;
		dataHits.SSN ;
		dataHits.SearchAddressIDHit;
		SSNCount := COUNT(GROUP) ;
	END;
	
	ssnTable := TABLE(dataHits, rollupRec, InternalSeqNo, SSN, SearchAddressIDHit, FEW);
	
    //if distinct ssns has more than one ssn number remove the ssns that have only one hit
	ssnByAddress1Count1 := IF (COUNT(ssnTable) > 1, ssnTable(SSNCount > 1), ssnTable);

	ssnByNameAddress_data := JOIN(ssnByAddress1Count1, dataHits, LEFT.SSN = RIGHT.SSN, 		
		TRANSFORM(LT.OutputRecord.CandidateRecord, 
			SELF.InputMatchCode := IF (RIGHT.SearchAddressIdHit = CN.AddressTypeEnum.GIID, 'F', 
												IF (RIGHT.SearchAddressIdHit = CN.AddressTypeEnum.CURRENT, 'S', 
													Constants.DISPLAY_INPUTMATCHCODE_ADDRESS_MISS));
			SELF := RIGHT),
			LEFT OUTER, KEEP(1));
	
	ssnByNameAddress := IF( COUNT(ssnByAddress1Count1)=1, ssnByNameAddress_data, nada);
		
	RETURN ssnByNameAddress;
END;