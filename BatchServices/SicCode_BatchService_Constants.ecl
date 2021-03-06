EXPORT SicCode_BatchService_Constants := MODULE

	EXPORT UNSIGNED1 MAX_RESULTS_PER_ACCT := 10;
	EXPORT UNSIGNED1 MAX_ZIPS_PER_ACCT := 5000;
	
	EXPORT ErrorCodes := MODULE
		
		EXPORT STRING3 NO_ERRORS                     := '000';
		EXPORT STRING3 NO_ZIP_CODE_OR_SIC_CODE       := '010';
		EXPORT STRING3 NO_ZIP_CODE                   := '020';
		EXPORT STRING3 NO_SIC_CODE                   := '030';
		
		EXPORT STRING3 RADIUS_PRODUCES_TOO_MANY_ZIPS := '040';
		
	END;
	
END;
