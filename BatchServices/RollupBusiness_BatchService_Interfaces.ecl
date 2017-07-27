EXPORT RollupBusiness_BatchService_Interfaces := MODULE

	EXPORT Input := INTERFACE
		EXPORT UNSIGNED1 DPPAPurpose;
		EXPORT UNSIGNED1 GLBPurpose;
		EXPORT UNSIGNED1 FuzzinessDial;
		EXPORT UNSIGNED1 PenaltThreshold;
		EXPORT UNSIGNED1 MaxResultsPerRow;
	END;

END;
