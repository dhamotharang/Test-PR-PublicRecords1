EXPORT PersonByCompany_BatchService_Interfaces := MODULE

	EXPORT Input := INTERFACE
		EXPORT UNSIGNED1 DPPAPurpose;
		EXPORT UNSIGNED1 GLBPurpose;
		EXPORT UNSIGNED1 FuzzinessDial;
		EXPORT UNSIGNED2 ZipRadius;
		EXPORT UNSIGNED1 MaxResultsPerRow;
		EXPORT REAL EmailThreshold;
		EXPORT STRING32 applicationType;
	END;

END;
