IMPORT corp2,tools;

EXPORT Build_Bases_Filings(
	STRING																				 	pfiledate,
	STRING																				 	pversion,
	BOOLEAN																				 	puseprod,	
	DATASET(Corp2_Raw_LA.Layouts.FilingsLayoutIn)	 	pInFilings   = Corp2_Raw_LA.Files(pfiledate,puseprod).Input.Filings.Logical,
	DATASET(Corp2_Raw_LA.Layouts.FilingsLayoutBase) pBaseFilings = IF(Corp2_Raw_LA._Flags(puseprod).Base.Filings, Corp2_Raw_LA.Files(,pUseOtherEnvironment := FALSE).Base.Filings.qa, DATASET([], Corp2_Raw_LA.Layouts.FilingsLayoutBase))
) := MODULE

	Corp2_Raw_LA.Layouts.FilingsLayoutBase standardize_input(Corp2_Raw_LA.Layouts.FilingsLayoutIn L) := TRANSFORM
		SELF.action_flag				:=	'U';
		SELF.dt_first_received	:=	(INTEGER)pversion;
		SELF.dt_last_received		:=	(INTEGER)pversion;
		SELF                    :=  L;
	END;

	// Take the LA Corp update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInFilings, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseFilings;
	combined_dist := DISTRIBUTE(combined, HASH(filing_entityid));
	combined_sort := SORT(combined_dist, filing_entityid, record, except dt_first_received, dt_last_received, LOCAL);
	
	Corp2_Raw_LA.Layouts.FilingsLayoutBase rollupBase(	Corp2_Raw_LA.Layouts.FilingsLayoutBase L,
																											Corp2_Raw_LA.Layouts.FilingsLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate	 (L.dt_last_received,  R.dt_last_received);
	  SELF                    := L;
	END;
	
	BaseRollup						 := ROLLUP(	combined_sort,
																		rollupBase(LEFT, RIGHT),
																		RECORD,
																		EXCEPT dt_first_received, dt_last_received,
																		LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_LA.Filenames(pversion).Base.Filings.New, BaseRollup, Build_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_LA.Build_Bases_Filings attribute')
									 );

END;